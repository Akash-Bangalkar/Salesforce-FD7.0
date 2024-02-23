public with sharing class MetadataChangesController {
    @AuraEnabled(cacheable=true)
    public static List<String> getTimeRangeOptions() {
        // Implement logic to fetch time range options dynamically
        List<String> timeRanges = new List<String>{ 'Last 1 Day', 'Last 2 Days', 'Last 1 Week' };
        return timeRanges;
    }

    @AuraEnabled(cacheable=true)
    public static List<User> getUsers() {
        // Implement logic to fetch active users dynamically
        return [SELECT Id, Name FROM User WHERE IsActive = true LIMIT 10];
    }
}