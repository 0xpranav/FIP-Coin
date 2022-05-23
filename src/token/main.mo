import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";

actor Token{
    var owner: Principal = Principal.fromText("aqfow-fhhma-nsp2x-bngu5-caa3o-sehlj-m7ruv-5x7dm-xuxge-f3t7i-yqe");
    
    var totalSupply: Nat = 1000000000000;
    var symbol: Text = "GARG";

    private stable var balanceEntries: [(Principal,  Nat)] = [];

    private var balances = HashMap.HashMap<Principal, Nat>(1,Principal.equal, Principal.hash);
    /*if(balances.size() < 1){
             balances.put(owner, totalSupply);
        }*/
   

    public query func getSymbol() : async Text{
        return "GARG";
    };

    public query func balanceOf(who: Principal): async Nat{
        
        let balance : Nat = switch (balances.get(who)){
            case null 0;
            case  (?result) result;};
        
       if (balances.size() < 1) {
      balances.put(owner, totalSupply);
    };
        return balance;
    };

    public shared(msg) func payOut() : async Text{
        Debug.print(debug_show(msg.caller));
        if(balances.get(msg.caller)==null){
let amount =  1000;
         let result = await transfer(msg.caller, amount);
        
        return result;
        }else{
            
            return "Already Claimed"
        }
        
    };

    public shared(msg) func transfer(to: Principal, amount: Nat) : async Text{
        let fromBalance = await balanceOf(msg.caller);
        if(fromBalance > amount){
            let newFromBalance: Nat= fromBalance-amount;
            balances.put(msg.caller, newFromBalance);

            let toBalance = await balanceOf(to);
            let newToBalance = toBalance+amount;
            balances.put(to, newToBalance);
              return "success";
        }else{
              return "insufficient funds"
        }
        
    };

    system func preupgrade(){
        balanceEntries:= Iter.toArray(balances.entries());
    };

    system func postupgrade(){
        balances := HashMap.fromIter<Principal, Nat>(balanceEntries.vals(), 1,Principal.equal, Principal.hash); 
        balances.put(owner, totalSupply);
        if(balances.size() < 1){
             balances.put(owner, totalSupply);
        };
   
    };


};