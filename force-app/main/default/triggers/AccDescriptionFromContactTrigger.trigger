trigger AccDescriptionFromContactTrigger on Contact (After update) 
{
    List<Account> accList = new List<Account>();
    Map<Id,Account> accountMap = new Map<Id,Account>();
    for(contact con:Trigger.new)
    {
        Contact oldContact = Trigger.oldMap.get(con.Id);
        if(oldContact.Description!= con.Description && con.AccountId != null && !accountMap.containsKey(con.AccountId)){
            Account accountRecord = new Account();
            accountRecord.Id = con.AccountId;
            accountRecord.Description = con.Description;
            accountMap.put(con.AccountId,accountRecord);
        }
    }
    if(!accountMap.isEmpty()){
        update accountMap.values();
    }
}