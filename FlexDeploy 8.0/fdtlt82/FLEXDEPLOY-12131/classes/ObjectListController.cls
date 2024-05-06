public with sharing class ObjectListController {
    @AuraEnabled(cacheable=true)
    public static List<String> getObjectList(String sortBy, String timeFrame, Integer duration) {
        Set<String> objectSet = new Set<String>();

        if (sortBy == 'LastModified' && timeFrame == 'LAST_N_DAYS') {
            addObjectNames(objectSet, 'Account', 'LastModifiedDate', duration);
            addObjectNames(objectSet, 'Contact', 'LastModifiedDate', duration);
            addObjectNames(objectSet, 'Opportunity', 'LastModifiedDate', duration);
        } else if (sortBy == 'LastCreated' && timeFrame == 'LAST_N_DAYS') {
            addObjectNames(objectSet, 'Account', 'CreatedDate', duration);
            addObjectNames(objectSet, 'Contact', 'CreatedDate', duration);
            addObjectNames(objectSet, 'Opportunity', 'CreatedDate', duration);
        } else if (sortBy == 'Both' && timeFrame == 'LAST_N_DAYS') {
            addObjectNames(objectSet, 'Account', 'LastModifiedDate', duration);
            addObjectNames(objectSet, 'Account', 'CreatedDate', duration);
            addObjectNames(objectSet, 'Contact', 'LastModifiedDate', duration);
            addObjectNames(objectSet, 'Contact', 'CreatedDate', duration);
            addObjectNames(objectSet, 'Opportunity', 'LastModifiedDate', duration);
            addObjectNames(objectSet, 'Opportunity', 'CreatedDate', duration);
        }

        return new List<String>(objectSet);
    }

    private static void addObjectNames(Set<String> objectSet, String objectApiName, String dateField, Integer duration) {
        String queryString = 'SELECT Id FROM ' + objectApiName + ' WHERE ' + dateField + ' = LAST_N_DAYS:' + duration;
        List<SObject> records = Database.query(queryString);

        for (SObject record : records) {
            objectSet.add(objectApiName);
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<ObjectDataWrapper> getObjectData(List<String> objectApiNames) {
        System.debug('Selected Objects: ' + objectApiNames);
        List<ObjectDataWrapper> objectDataList = new List<ObjectDataWrapper>();

        for (String objectApiName : objectApiNames) {
            List<String> recordNames = new List<String>();

            String queryString = 'SELECT Name FROM ' + objectApiName + ' LIMIT 5';
            List<SObject> records = Database.query(queryString);

            for (SObject record : records) {
                recordNames.add(String.valueOf(record.get('Name')));
            }

            objectDataList.add(new ObjectDataWrapper(objectApiName, recordNames));

            System.debug('Object Data List: ' + objectDataList);
            return objectDataList;
        }

        return objectDataList;
    }

    public class ObjectDataWrapper {
        @AuraEnabled public String objectApiName;
        @AuraEnabled public List<String> recordNames;

        public ObjectDataWrapper(String objectApiName, List<String> recordNames) {
            this.objectApiName = objectApiName;
            this.recordNames = recordNames;
        }
    }
}