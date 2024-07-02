public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getActiveAccounts() {
        return [SELECT Id, Name, Industry, AnnualRevenue FROM Account WHERE Active__c = 'Yes'];
    }
}