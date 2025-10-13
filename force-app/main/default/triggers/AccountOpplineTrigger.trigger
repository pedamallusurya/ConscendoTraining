trigger AccountOpplineTrigger on OpportunityLineItem(After insert,After Update,After Delete,After undelete) {
    if(trigger.isAfter){
        set<id> accountIdset = new set<id>();
        if(trigger.isInsert || trigger.isUndelete){
        for(OpportunityLineItem oppLineItem : trigger.new){
            if(oppLineItem.AccountId != null){
             accountIdset.add(oppLineItem.AccountId);
            }
        }
    }
    if(trigger.isDelete){
         for(OpportunityLineItem oppLineItem : trigger.old){
                if(oppLineItem.AccountId != null){
                     accountIdset.add(oppLineItem.AccountId);
                }
         }
    }
    if(trigger.isUpdate){
        for(OpportunityLineItem oppLineItem : trigger.new){
            OpportunityLineItemunity oldOppLineItem = trigger.oldMap.get(oppLineItem.Id);
            if(oppLineItem!=null && oppLineItem.AccountId != oldOppLineItem.AccountId){
                    accountIdset.add(oppLineItem.AccountId);
                    accountIdset.add(oldOppLineItem.AccountId);
            }
    }
} 
        if(!accountIdset.isEmpty()){
          list<Account> toupdateAccList = new list<Account>();
        List<Account> accList = [SELECT Id, Name,(SELECT Id, Name,(SELECT Id, Quantity, TotalPrice, PricebookEntry.Name FROM OpportunityLineItems) FROM Opportunities) FROM Account WHERE Id = :someAccountId];  
         for(Account acnt : accList){
            if(acnt.Opportunities.size()>0 && acnt.Opportuinty.OpportunityLineItems.size()>0){
                  acnt.opportunityLineCount = acnt.Opportuinty.OpportunityLineItems.size();
                  toupdateAccList.add(acnt);
            }
      }
        if(!toupdateAccList.isEmpty()){
            update toupdateAccList;
        }
   }
 }
}