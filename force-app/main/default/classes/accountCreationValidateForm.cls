public with sharing class accountCreationValidateForm {
    /*@AuraEnabled
    public static void insertOrUpdateAccount(Account acc) {
        try {
            if (acc.Id == null) {
                insert acc;
            } else {
                update acc;
            }
        } catch (Exception e) {
            throw new AuraHandledException('Error: ' + e.getMessage());
        }
    }
      // New method to fetch Account by Id
    @AuraEnabled(cacheable=true)
    public static Account getAccountById(Id accountId) {
        try {
            return [SELECT Id, Name, AccountNumber, BillingStreet, Description
                    FROM Account
                    WHERE Id = :accountId
                    LIMIT 1];
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching Account: ' + e.getMessage());
        }
    }*/
   
    // Method to insert a new Account
    @AuraEnabled
    public static String insertAccount(Account acc) {
        try {
            insert acc;
            return 'Account created successfully with Id: ' + acc.Id;
        } catch (Exception e) {
            return 'Error while inserting Account: ' + e.getMessage();
        }
    }

    // Method to update an existing Account
    @AuraEnabled
    public static String updateAccount(Account acc) {
        try {
            update acc;
            return 'Account updated successfully';
        } catch (Exception e) {
            return 'Error while updating Account: ' + e.getMessage();
        }
    }
}

	

