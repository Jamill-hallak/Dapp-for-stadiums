pragma solidity >=0.7.0 <0.9.0;
import "./SafeMath.sol";
contract jnbez_coin{
 using SafeMath for uint;
 using SafeMath for uint256;
    string public  name;
    uint256 totalSupply;
 event Approval(address indexed tokenOwner, address indexed spender,uint tokens);
 event Transfer(address indexed from, address indexed to,uint tokens);
    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed ;
   
constructor() public {
    name = 'jnbez';
   totalSupply = 7777777;
   balances[msg.sender] = totalSupply;
}

function totalSupply_() public view returns (uint256) {
  return totalSupply;
}

 function balanceOf(address tokenOwner) public view returns (uint) {
  return balances[tokenOwner];
}

 function transfer(address receiver,uint numTokens) public returns (bool) {
  require(numTokens <= balances[msg.sender]);
  balances[msg.sender] = balances[msg.sender].sub(numTokens);
  balances[receiver] = balances[receiver] .add(numTokens);
  emit Transfer(msg.sender, receiver, numTokens);
  return true;
}

    // for marketplace 
    function approve(address delegate, uint numTokens) public  returns (bool) {
      allowed[msg.sender][delegate] = numTokens;
     emit Approval(msg.sender, delegate, numTokens);
  return true;
}
    // for marketplace :This function returns the current approved number of tokens by an owner to a specific delegate.
    function allowance(address owner,address delegate) public view returns (uint) {
  return allowed[owner][delegate];
}

// for marketplace Transfer jnbez Tokens by Delegate
function transferFrom(address owner, address buyer, uint numTokens) public returns (bool) {
  require(numTokens <= balances[owner]);
  require(numTokens <= allowed[owner][msg.sender]);
  balances[owner] = balances[owner].sub(numTokens);
  allowed[owner][msg.sender] =allowed[owner][msg.sender].sub(numTokens);
  balances[buyer] = balances[buyer].add(numTokens);
  emit Transfer(owner, buyer, numTokens);
  return true;
}




    
    
}