public with sharing class AccountConHandler {
    public static void  Handler(List<Account> newAccList, Map<Id, Account> oldAccMap) {
          map<Id,Account> accMap = new map<id,Account>();
          for(Account acc : newAccList){
            if(acc.Description != oldAccMap.get(acc.id).description){
                accMap.put(acc.id,acc);
        }
    }
    List<Contact> conListToUpdate =new List<Contact>();
    for(contact con:[Select Id,Description,AccountId from Contact where AccountId in :accMap.keyset()]){
      //  contact newcon = new contact();
        con.Description = accMap.get(con.AccountId).Description;
       // newcon.id = con.id;
        conListToUpdate.add(con);
    } if(!conListToUpdate.isEmpty()){
        update conListToUpdate;
      }
}
}