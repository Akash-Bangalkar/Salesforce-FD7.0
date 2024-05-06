public with sharing class YourComponentController {
    @AuraEnabled(cacheable=true)
    public static List<SObject> fetchRecords(String objectName, String lastModified, String timeFrame, Integer numberOfDays) {
        // Initialize the reference date
        Date referenceDate = Date.today();

        // Adjust the reference date based on the selected time frame
        if (timeFrame == 'LAST_N_DAYS') {
            referenceDate = referenceDate.addDays(-numberOfDays);
        } else if (timeFrame == 'LAST_N_WEEKS') {
            referenceDate = referenceDate.addDays(-7 * numberOfDays);
        } else if (timeFrame == 'LAST_N_MONTHS') {
            referenceDate = referenceDate.addMonths(-numberOfDays);
        }

        // Use the reference date in the SOQL query
        String queryString = 'SELECT Id, Name, LastModifiedDate FROM ' + objectName +
            ' WHERE LastModifiedDate >= :referenceDate';

        if (lastModified == 'LastCreated') {
            queryString = 'SELECT Id, Name, CreatedDate FROM ' + objectName +
                ' WHERE CreatedDate >= :referenceDate';
        } else if (lastModified == 'Both') {
            queryString = 'SELECT Id, Name, LastModifiedDate, CreatedDate FROM ' + objectName +
                ' WHERE LastModifiedDate >= :referenceDate' +
                ' OR CreatedDate >= :referenceDate';
        }

        return Database.query(queryString);
    }
}