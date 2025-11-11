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
    @AuraEnabled
	public static void doCreateAccount(String acntName,String acntNum,String acntDesc,String acntStreet ,String acntCity,String acntState,String acntCountry,String acntPostalCode){
		System.debug('acntName :'+acntName+ ' acntNum: '+acntNum);
		Account acnt = new Account();
		acnt.Name = acntName;
		acnt.AccountNumber=acntNum;
        acnt.Description=acntDesc;
		acnt.BillingStreet=acntStreet;
		acnt.BillingCity=acntCity;
        acnt.BillingState=acntState;
		acnt.BillingCountry=acntCountry;
        acnt.BillingPostalCode=acntPostalCode;
		insert acnt;
		system.debug('ID: '+acnt.id);
		
	}
}
