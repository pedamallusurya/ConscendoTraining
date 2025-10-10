public with sharing class ContactTriggerHandler {
    public static void Handler(list<Contact> conlist) {
            set<id> acountIdSet = new Set<Id>();
            for(Contact con : conlist){
          acountIdSet.add(con.AccountId);
      }
      Map<Id,Account> accountMap = new Map<Id,Account>([Select Id,Description from Account where Id in :acountIdSet]);
      for(Contact con : conlist){
          con.Description = accountMap.get(con.AccountId).Description;
      }
    }
}