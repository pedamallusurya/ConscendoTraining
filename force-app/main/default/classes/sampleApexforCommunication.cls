public  class sampleApexforCommunication {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        try {
            List<Account> accList = [SELECT Id, Name, Phone FROM Account LIMIT 5];
            return accList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
     @AuraEnabled(cacheable=true)
    public static list<contact> getContacts(){
        try {
            List<Contact> conList = [SELECT Id, Name, Phone FROM Contact LIMIT 5];
            return conList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}