public with sharing class OpportunityRecords {
    //today's opportunities
    @AuraEnabled(Cacheable = true)
    public static List<Opportunity> getCheckIn(){
        return [SELECT Name FROM Opportunity];
     }
}