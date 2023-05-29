// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

// File: @openzeppelin/contracts/math/SafeMath.sol

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        uint256 c = a + b;
        if (c < a) return (false, 0);
        return (true, c);
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b > a) return (false, 0);
        return (true, a - b);
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) return (true, 0);
        uint256 c = a * b;
        if (c / a != b) return (false, 0);
        return (true, c);
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b == 0) return (false, 0);
        return (true, a / b);
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        if (b == 0) return (false, 0);
        return (true, a % b);
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) return 0;
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: modulo by zero");
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        return a - b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryDiv}.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        return a % b;
    }
}

// File: @openzeppelin/contracts/utils/Context.sol

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

// File: @openzeppelin/contracts/access/Ownable.sol

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

pragma solidity ^0.6.0;

interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}

contract ERC20 is Context, IERC20, IERC20Metadata {
    using SafeMath for uint256;

    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * The default value of {decimals} is 18. To select a different value for
     * {decimals} you should overload it.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(string memory name_, string memory symbol_) public {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5,05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC20} uses, unless this function is
     * overridden;
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `recipient` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * Requirements:
     *
     * - `sender` and `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     * - the caller must have allowance for ``sender``'s tokens of at least
     * `amount`.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }

    /**
     * @dev Moves tokens `amount` from `sender` to `recipient`.
     *
     * This is internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `sender` cannot be the zero address.
     * - `recipient` cannot be the zero address.
     * - `sender` must have a balance of at least `amount`.
     */
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);

        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
        emit Transfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be to transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
}

    //======================================Diamond=========================================//
contract Diamond is ERC20, Ownable {
    using SafeMath for uint;

    // Public Parameters
    address developer;
    uint public initialSupply;
    
    uint public currentHour;
    uint public startTime;
    uint public secondsPerHour;

    uint public nextHourTime;
    address payable public burnAddress;

    uint public totalBurnt;
    uint public totalEmitted;
    uint public totalWithdrawed;

    // Public Mappings
    address[] public arrLpTokens;
    mapping(address=>mapping(uint=>uint)) public mapTokenHour_MemberCount;
    mapping(address=>mapping(uint=>address[])) public mapTokenHour_Members;
    mapping(address=>mapping(uint=>uint)) public mapTokenHour_Units;
    mapping(address=>mapping(uint=>uint)) public mapTokenHour_Emission;
    mapping(address=>mapping(uint=>mapping(address=>uint))) public mapTokenHour_MemberUnits;
    mapping(address=>mapping(address=>uint[])) public mapMemberToken_Hours;

    // Events
    event NewHour(uint hour, uint time);
    event Burn(address indexed member, address token, uint hour, uint units, uint dailyTotal);
    event Withdrawal(address indexed member, address token, uint hour, uint value);

    //=====================================CREATION=========================================//
    // Constructor
    constructor() public ERC20("Diamond", "DIAMOND") {
        developer = _msgSender();

        currentHour = 0;
        secondsPerHour = 3600;                                      // 1 hour
        
        burnAddress = 0x000000000000000000000000000000000000dEaD;
        
        initialSupply = 100000 * 10 ** 18;                          // 100K diamond

        _mint(developer, initialSupply);
        _mint(address(this), 1000000 * 10 ** 18 - initialSupply);   // 900K diamond, total supply = 100K + 900K = 1M Diamond
        
        arrLpTokens = new address[](4);
        arrLpTokens[0] = address(0);
        arrLpTokens[1] = address(0);
        arrLpTokens[2] = address(0);
        arrLpTokens[3] = address(0);
        
        emit Transfer(burnAddress, address(this), totalSupply());
    }

    // destroy developer
    function destroyDeveloper() public onlyOwner{
        developer = address(0);
    }

    function setLPToken(uint8 index, address _lpToken) public onlyOwner {
        require(_lpToken != address(0), "LP token is the zero address");
        require(index >= 0 && index < 4, "Index is wrong");

        arrLpTokens[index] = _lpToken;
    }
    
    function setStartBurning() public onlyOwner {
        require(arrLpTokens[0] != address(0) || arrLpTokens[1] != address(0)
                || arrLpTokens[2] != address(0) || arrLpTokens[3] != address(0), "LP token is not set");
                
        _updateEmission();
        currentHour = 1;
        startTime = block.timestamp;
        nextHourTime = block.timestamp + secondsPerHour;
    }
    
    function isRegisteredLPToken(address _lpToken) private view returns (bool)
    {
        require(_lpToken != address(0), "LP token is the zero address");

        for (uint8 i=0; i<arrLpTokens.length; i++)
        {
            if (arrLpTokens[i] == _lpToken)
                return true;
        }

        return false;
    }

    //==================================PROOF-OF-VALUE======================================//

    // Burn ether for nominated member
    function burnLPtoken(address _lpToken, uint _burnAmount) external {  
        require(currentHour > 0, "Buring LP Tokens is not started.");
        require(isRegisteredLPToken(_lpToken) == true, "LP token address is wrong");

        ERC20(_lpToken).transferFrom(msg.sender, address(this), _burnAmount);
        ERC20(_lpToken).transfer(burnAddress, _burnAmount); 

        _recordBurn(msg.sender, _lpToken, currentHour, _burnAmount);
    }
    // Internal - Records burn
    function _recordBurn(address _account, address _lpToken, uint _hour, uint _amount) private {
        require(_account != address(0), "Account is the zero address");
        require(isRegisteredLPToken(_lpToken) == true, "LP token address is wrong");

        if (mapTokenHour_MemberUnits[_lpToken][_hour][_account] == 0){
            mapMemberToken_Hours[_account][_lpToken].push(_hour);
            mapTokenHour_MemberCount[_lpToken][_hour] += 1;
            mapTokenHour_Members[_lpToken][_hour].push(_account);
        }
        mapTokenHour_MemberUnits[_lpToken][_hour][_account] += _amount;
        mapTokenHour_Units[_lpToken][_hour] += _amount;
        totalBurnt += _amount;
        
        emit Burn(_account, _lpToken, _hour, _amount, mapTokenHour_Units[_lpToken][_hour]);
        _updateEmission();
    }
    
    //======================================WITHDRAWAL======================================//
    // Used to efficiently track participation in each era
    function getHoursContributedForToken(address _account, address _lpToken) public view returns(uint){
        require(currentHour > 0, "Buring LP Tokens is not started.");
        require(_account != address(0), "Account is the zero address");
        require(isRegisteredLPToken(_lpToken) == true, "LP token address is wrong");

        return mapMemberToken_Hours[_account][_lpToken].length;
    }
    
    function pendingRewards(address _account, address _lpToken) public view returns(uint){
        require(currentHour > 0, "Buring LP Tokens is not started.");
        require(_account != address(0), "Account is the zero address");
        require(isRegisteredLPToken(_lpToken) == true, "LP token address is wrong");
        
        uint length = mapMemberToken_Hours[_account][_lpToken].length;
        
        uint _hour;
        uint totalUnits;
        uint memberUnits;
        uint currentEmission;
        uint value;
        for (uint i=0; i<length; i++){
            _hour = mapMemberToken_Hours[_account][_lpToken][i];
            
            if (_hour == currentHour)
                continue;
            
            memberUnits = mapTokenHour_MemberUnits[_lpToken][_hour][_account];
            if (memberUnits == 0)
                continue;
            
            totalUnits = mapTokenHour_Units[_lpToken][_hour];
                
            currentEmission = mapTokenHour_Emission[_lpToken][_hour];
            
            value += (currentEmission * memberUnits) / totalUnits;
        }

        return value;
    }
    
    function getMembersAtCurrentHour() public view returns(uint){
        require(currentHour > 0, "Buring LP Tokens is not started.");
       
        uint length = arrLpTokens.length;
        uint totalCount;
        for (uint8 i=0; i<length; i++)
        {
            totalCount += mapTokenHour_MemberCount[arrLpTokens[i]][currentHour];
        }

        return totalCount;
    }
    
    function getEmissionsAtCurrentHour() public view returns(uint){
        require(currentHour > 0, "Buring LP Tokens is not started.");
       
        uint length = arrLpTokens.length;
        uint totalEmission;
        for (uint8 i=0; i<length; i++)
        {
            totalEmission += mapTokenHour_Emission[arrLpTokens[i]][currentHour];
        }

        return totalEmission;
    }
    
    function getLPTokensBurntAtCurrentHour() public view returns(uint){
        require(currentHour > 0, "Buring LP Tokens is not started.");
       
        uint length = arrLpTokens.length;
        uint totalTokens;
        for (uint8 i=0; i<length; i++)
        {
            totalTokens += mapTokenHour_Units[arrLpTokens[i]][currentHour];
        }

        return totalTokens;
    }
    
    // Call to withdraw a claim
    function withdrawShare(address _lpToken) external returns (uint) {
        require(currentHour > 0, "Buring LP Tokens is not started.");
        require(isRegisteredLPToken(_lpToken) == true, "LP token address is wrong");
        
        uint value;
        uint _hour;
        uint length = mapMemberToken_Hours[msg.sender][_lpToken].length;
        for (uint i=0; i<length; i++){
            _hour = mapMemberToken_Hours[msg.sender][_lpToken][i];
            
            value += _withdrawShare(_lpToken, _hour, msg.sender); 
        }
        
        return value;
    }
    
    function withdrawShare(address _lpToken, uint _hour) external returns (uint value) {
        require(currentHour > 0, "Buring LP Tokens is not started.");
        require(isRegisteredLPToken(_lpToken) == true, "LP token address is wrong");

        value = _withdrawShare(_lpToken, _hour, msg.sender);                           
    }

    // Internal - withdraw function
    function _withdrawShare (address _lpToken, uint _hour, address _account) private returns (uint value) {
        _updateEmission(); 

        if (_hour < currentHour) 
        {
            value = _processWithdrawal(_lpToken, _hour, _account);
        }
        
        return value;
    }

    // Internal - Withdrawal function
    function _processWithdrawal (address _lpToken, uint _hour, address _account) private returns (uint value) {
        uint memberUnits = mapTokenHour_MemberUnits[_lpToken][_hour][_account];
        if (memberUnits == 0) { 
            value = 0;
        } else {
            value = getEmissionShare(_lpToken, _hour, _account);
            mapTokenHour_MemberUnits[_lpToken][_hour][_account] = 0;

            totalWithdrawed += value;

            ERC20(address(this)).transfer(_account, value);

            emit Withdrawal(_account, _lpToken, _hour, value);
        }
        return value;
    }

    // Get emission Share function
    function getEmissionShare(address _lpToken, uint _hour, address _account) public view returns (uint value) {
        require(currentHour > 0, "Buring LP Tokens is not started.");
        require(_account != address(0), "Account is the zero address");
        require(isRegisteredLPToken(_lpToken) == true, "LP token address is wrong");

        uint memberUnits = mapTokenHour_MemberUnits[_lpToken][_hour][_account];
        if (memberUnits == 0) {
            return 0;
        } else {
            uint totalUnits = mapTokenHour_Units[_lpToken][_hour];
            uint currentEmission = mapTokenHour_Emission[_lpToken][_hour];
            uint balance = balanceOf(address(this));

            if (currentEmission > balance)
            {
                currentEmission = balance; 
            }

            value = (currentEmission * memberUnits) / totalUnits;
            return  value;                            
        }
    }
    //======================================EMISSION========================================//
    // Internal - Update emission function
    function _updateEmission() private {
        if (block.timestamp >= nextHourTime) 
        {
            currentHour += 1;
            nextHourTime = block.timestamp + secondsPerHour;       
            
            uint[] memory emmisions = getCurrentHourEmission();

            for (uint8 i=0; i<emmisions.length; i++)
            {
                mapTokenHour_Emission[arrLpTokens[i]][currentHour] = emmisions[i];
                totalEmitted += emmisions[i];
            }
           
            emit NewHour(currentHour, nextHourTime); 
        }
    }

    // Calculate Next Hour emission
    function getCurrentHourEmission() public view returns (uint[] memory emissions) {
        require(currentHour > 0, "Buring LP Tokens is not started.");
        uint remains = totalSupply() - initialSupply - totalEmitted;
        
        uint length = arrLpTokens.length;
        
        emissions = new uint256[](length);
        for (uint8 i=0; i<length; i++)
        {
            if (arrLpTokens[i] == address(0))
            {
                emissions[i] = 0;
                continue;
            }
                
            if (i == 0)
                emissions[i] = (remains * 80 / 10000) / 24;
            else
                emissions[i] = (remains * 40 / 10000) / 24;
        }

        return emissions;
    }
}