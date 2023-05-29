//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

struct Requisite {
    string label;
    address token1;
    address token2;
    uint256 threshold1;
    uint256 threshold2;
}

contract FantoonAI is Ownable {
    Requisite[] private requisites;
    mapping(address => uint256) public expires;

    address public developer;
    
    IERC20 public token;
    uint256 public threshold = 0;
    uint256 public expiredPeriod = 30 days;

    constructor() Ownable() {
        developer = msg.sender;
    }

    function addRequisite(
        string memory label,
        address _token1, uint256 _threshold1,
        address _token2, uint256 _threshold2
    ) public onlyOwner {
        require(_token1 != address(0) || _token2 != address(0), "Either of tokens must not be NULL");

        requisites.push(Requisite({
            label: label,
            token1: _token1,
            token2: _token2,
            threshold1: _threshold1,
            threshold2: _threshold2
        }));
    }

    function removeRequisite(uint8 _step) public onlyOwner {
        require(_step > 0 && _step <= requisites.length, "Invalid Number");

        Requisite storage requisite = requisites[_step - 1];
        requisite.token1 = address(0);
        requisite.token2 = address(0);
    }

    function updateRequisite (
        uint8 _step,
        string memory label,
        address _token1, uint256 _threshold1,
        address _token2, uint256 _threshold2
    ) public onlyOwner {        
        require(_step > 0 && _step <= requisites.length, "Invalid Number");
        require(_token1 != address(0) || _token2 != address(0), "Either of tokens must not be NULL");

        requisites[_step - 1] = Requisite({
            label: label,
            token1: _token1,
            token2: _token2,
            threshold1: _threshold1,
            threshold2: _threshold2
        });
    }

    function plans() public view returns (Requisite[] memory) {
        uint256 length = requisites.length;
        for(uint256 i = 0;i<requisites.length;i++) {
            if(requisites[i].token1==address(0) && requisites[i].token2==address(0))
                length--;
        }
        Requisite[] memory _requisites = new Requisite[](length);
        uint256 j = 0;
        for(uint256 i = 0;i<requisites.length;i++) {
            if(requisites[i].token1!=address(0) || requisites[i].token2!=address(0)) {
                _requisites[j].label = requisites[i].label;
                _requisites[j].token1 = requisites[i].token1;
                _requisites[j].threshold1 = requisites[i].threshold1;
                _requisites[j].token2 = requisites[i].token2;
                _requisites[j].threshold2 = requisites[i].threshold2;
                j ++;
            }
        }
        return _requisites;
    }

    function check(address _account) public view returns (uint32) {
        uint32 res = 0;
        for( uint32 index = 0 ; index<requisites.length ; index++ ) {
            Requisite storage requisite = requisites[index];
            uint8 permitted = 0;
            if( requisite.token1 != address(0) && requisite.threshold1 > 0 ) {
                uint256 balance = IERC20(requisite.token1).balanceOf(_account);
                if(balance < requisite.threshold1) {
                    continue;
                } else {
                    permitted++;
                }
            }
            if(requisite.token2 != address(0) && requisite.threshold2 > 0) {
                uint256 balance = IERC20(requisite.token2).balanceOf(_account);
                if(balance < requisite.threshold2) {
                    continue;
                } else {
                    permitted++;
                }
            }
            if(permitted > 0) {
                res = index + 1;
                break;
            }
        }
        if(expires[_account] >= block.timestamp){
            res = uint32(requisites.length + 1);
        }
        return res;
    }

    function setToken(address _token, uint256 _threshold) public onlyOwner {
        require(_token != address(0), "Address cannot be NULL");
        require(_threshold > 0, "Threshold cannot be negotive");
        token = IERC20(_token);
        threshold = _threshold;
    }

    function setDeveloper(address _developer) public onlyOwner {
        require(_developer != address(0), "Address cannot be NULL");

        developer = _developer;
    }

    function setExpirePeriod(uint256 _period) public onlyOwner {
        require(_period > 0 && _period < 365 days, "Period range invalid");

        expiredPeriod = _period;
    }

    function pay(uint8 _months) public {
        require(address(token) != address(0) && developer != address(0) && threshold > 0, "Payment has not initialized");
        require(_months > 0 && _months <= 12, "Invalid argument");

        token.transferFrom(msg.sender, developer, threshold * _months);
        expires[msg.sender] = (expires[msg.sender]==0 ? block.timestamp : expires[msg.sender]) + _months * expiredPeriod;
    }

    function withdraw(address _token) public onlyOwner {
        IERC20 wtoken = IERC20(_token);
        uint256 balance = wtoken.balanceOf(address(this));
        wtoken.transfer(msg.sender, balance);
    }
}