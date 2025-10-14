trigger AccountOpplineTrigger on OpportunityLineItem (
    after insert, after update, after delete, after undelete
) {
    if (Trigger.isAfter) {
        Set<Id> opportunityIds = new Set<Id>();
        // Insert or Undelete
        if (Trigger.isInsert || Trigger.isUndelete) {
            for (OpportunityLineItem oli : Trigger.new) {
                if (oli.OpportunityId != null) {
                    opportunityIds.add(oli.OpportunityId);
                }
            }
        }
        // Delete
        if (Trigger.isDelete) {
            for (OpportunityLineItem oli : Trigger.old) {
                if (oli.OpportunityId != null) {
                    opportunityIds.add(oli.OpportunityId);
                }
            }
        }
        // Update — check if parent changed
        if (Trigger.isUpdate) {
            for (OpportunityLineItem oli : Trigger.new) {
                OpportunityLineItem oldOli = Trigger.oldMap.get(oli.Id);
                if (oli.OpportunityId != oldOli.OpportunityId) {
                    if (oli.OpportunityId != null)
                        opportunityIds.add(oli.OpportunityId);
                    if (oldOli.OpportunityId != null)
                        opportunityIds.add(oldOli.OpportunityId);
                }
            }
        }
        if (!opportunityIds.isEmpty()) {
            // Get Opportunities and their related Accounts
            Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>(
                [SELECT Id, AccountId FROM Opportunity WHERE Id IN :opportunityIds]
            );
            Set<Id> accountIds = new Set<Id>();
            for (Opportunity opp : oppMap.values()) {
                if (opp.AccountId != null)
                    accountIds.add(opp.AccountId);
            }// Get total line items count per Opportunity
            Map<Id, Integer> oppLineCountMap = new Map<Id, Integer>();
            for (AggregateResult ar : [
                SELECT OpportunityId, COUNT(Id) total
                FROM OpportunityLineItem
                WHERE OpportunityId IN :oppMap.keySet()
                GROUP BY OpportunityId
            ]) {
                oppLineCountMap.put((Id) ar.get('OpportunityId'), (Integer) ar.get('total'));
            }// Aggregate totals per Account
            Map<Id, Integer> accTotalLineCount = new Map<Id, Integer>();
            for (Opportunity opp : oppMap.values()) {
                Integer count = oppLineCountMap.containsKey(opp.Id) ? oppLineCountMap.get(opp.Id) : 0;
                if (accTotalLineCount.containsKey(opp.AccountId))
                    accTotalLineCount.put(opp.AccountId, accTotalLineCount.get(opp.AccountId) + count);
                else
                    accTotalLineCount.put(opp.AccountId, count);
            }// Update Accounts
            List<Account> accToUpdate = new List<Account>();
            for (Id accId : accTotalLineCount.keySet()) {
                Account acc = new Account(Id = accId);
                acc.OpportunityLineCount__c = accTotalLineCount.get(accId); // custom field
                accToUpdate.add(acc);
            }
            if (!accToUpdate.isEmpty()) {
                update accToUpdate;
            }
        }
    }
}
