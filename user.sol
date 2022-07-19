pragma solidity >=0.7.0 <0.9.0;
 
 import "./jnbez_coin.sol";

contract user is  jnbez_coin {
     using SafeMath for uint;
   struct   studuim  {
    string  name ;
    uint id ;
    uint price ;
    address payable addr ;
    string location ;
     uint [7][7] day_time ;
      
     uint cap  ;
     

    }
    mapping (address => studuim) user ;

    studuim []   internal studuims ;
     constructor  ()public{
         
         user[msg.sender].name = "camp";
         user[msg.sender].id = 0;
         user[msg.sender].price = 7;
         user[msg.sender].addr = payable( 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4);
          user[msg.sender].location = "maza";
           user[msg.sender].cap =12;
         for (uint i =0;i<7;i++){
           for(uint j=0 ;j<7;j++){
           user[msg.sender].day_time[i][j]=0;
        
       }}
       studuims.push(user[msg.sender]);
     }
    
 
   // event addstudium_event (string  _name,uint _id ,uint _price ,address payable _address ,string  _location,uint _cap   );
  function addstrudtuim (string memory _name,uint _id ,uint _price ,address payable _address ,string memory _location,uint _cap  ) public  returns (bool s) {
      user[msg.sender].name =_name;
      user[msg.sender].id =_id;
      user[msg.sender].price =_price;
      user[msg.sender].addr =_address;
      user[msg.sender].location =_location;
      user[msg.sender].cap =_cap;
       for (uint i =0;i<7;i++){
           for(uint j=0 ;j<7;j++){
           user[msg.sender].day_time[i][j]=0;
        
       }}
      
      
      
     studuims.push(user[msg.sender]);
     //emit addstudium_event(_name,_id,_price,_address,_location,_cap) ;
     return true ;
    
  }
   
   
   
    
    
    
    function compareStrings(string memory a, string memory b) internal  view  returns (bool) {
    return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
}
     function concatenate(string memory s1, string memory s2) internal pure returns (string memory) {
        return string(abi.encodePacked(s1, s2));
    }
   
   //search_by_location
         event searchlo(string [] result,uint [] idd) ;
  function search_by_location(string memory _lo)  public  returns(string  [] memory result,uint [] memory idd){
       uint count = 0 ;
      for (uint i =0;i<studuims.length ;i++){
         if(compareStrings(studuims[i].location,_lo) ){count++;}}
      string  [] memory result = new string[](count) ;
      uint [] memory idd =new uint [](count) ;
     count =0;
     for (uint i =0;i<studuims.length ;i++){
         if(compareStrings(studuims[i].location,_lo) ){
           result[count]= concatenate( result[count],studuims[i].name) ;
            idd[count]=studuims[i].id ;
             count++ ;
         }
         
         
     }
    
   
     return (result,idd) ;
  }
 
 // show possilbe time by location same bottom in front end
 
  
     function show_possible(uint _id ,uint day ) public view returns (uint []memory target_time ,uint  price,uint iid){
         uint ta = 0;
         uint  price ;
         uint iid =0;
         
         for (uint i =0;i<studuims.length ;i++){
             if ( studuims[i].id== _id){
                 iid=studuims[i].id;
                 for(uint j =0;j<7;j++){
                     if(studuims[i].day_time[day][j]<studuims[i].cap){
                         ta++;}
                 }
             }
         }
           string  [] memory result = new string[](ta) ;
          uint  [] memory target_time = new uint [](ta) ;
         uint count = 0;
         for (uint i =0;i<studuims.length ;i++){
             if ( studuims[i].id== _id){
                 for(uint j =0;j<7;j++){
                      if(studuims[i].day_time[day][j]<studuims[i].cap){
                          target_time[count]=j;
                          price = studuims[i].price;
                     count++;
                 }
                 }
             }
          }
         
        
         return (target_time,price,iid);
     }
     
     //  search_by_timeE 
      event search_by_timeE(string []  name, uint []  pric,uint [] _iddr);
  function search_by_time(uint d ,uint t )  public view returns(string [] memory name, uint [] memory pric,uint []memory _iddr  ){
      uint count = 0;
      
      for (uint i =0;i<studuims.length ;i++){
          if(studuims[i].day_time[d][t]<studuims[i].cap){ count++; } }
      
            string  [] memory name = new string[](count) ;
            uint  [] memory price = new uint[](count) ;
            uint  [] memory id = new uint[](count) ;
             count = 0 ;

       for (uint i =0;i<studuims.length ;i++){
          if(studuims[i].day_time[d][t]<studuims[i].cap){
            name[count]=concatenate( name[count],studuims[i].name) ;
            price[count]=studuims[i].price ;
            id[count]=studuims[i].id ;
            count++;
          }
          
      }
                 
         
         return (name,price,id);
 } 
 
  
 // fire when pay ;
  event get_addressE(address payable a);
 function get_address (uint ids ) public view returns ( address payable s ){
     for( uint i =0 ; i<studuims.length;i++){
          if ( studuims[i].id==ids ){
             
              return studuims[i].addr ;
              
          }
     }
 }
  //resver
     //event resverE(bool s,uint  qr);
     function resver(uint _id,uint d,uint t) public   returns (bool s,uint  qr) {
         uint qr = 0 ;
         for( uint i =0;i<studuims.length;i++){
         if(studuims[i].id==_id){
             if(studuims[i].day_time[d][t]<studuims[i].cap){
                 if(transfer(studuims[i].addr,studuims[i].price)){
                     studuims[i].day_time[d][t]++;
                     qr=(1000*i)+(100*d)+(10*t)+studuims[i].day_time[d][t];
                    // emit resverE(true,qr) ;
                     return (true,qr) ;
                 }
             }
         }    
         }
    //emit resverE(false,0);
    return (false,0) ;
}
}
