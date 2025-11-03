public with sharing class LeadHandlerForm {
    @AuraEnabled
    public static Id createLead(String firstName, String lastName, String email, String company, String phone) {
        try {
            Lead newLead = new Lead(
                FirstName = firstName,
                LastName = lastName,
                Email = email,
                Company = company,
                Phone = phone,
                Status = 'Open - Not Contacted'
            );
            insert newLead;
            return newLead.Id;
        } catch (Exception e) {
            throw new AuraHandledException('Error creating lead: ' + e.getMessage());
        }
    }
}
