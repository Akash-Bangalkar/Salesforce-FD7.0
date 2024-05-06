global class QueryObjectsBatch implements Database.Batchable<SObject>, Database.Stateful {

    private List<String> objectNamesModified = new List<String>();
    private DateTime yesterday;

    global Database.QueryLocator start(Database.BatchableContext BC) {
        yesterday = System.now().addDays(-1);
        return Database.getQueryLocator('SELECT QualifiedApiName FROM EntityDefinition WHERE IsCustomObject = TRUE');
    }

    global void execute(Database.BatchableContext BC, List<EntityDefinition> scope) {
        for (EntityDefinition obj : scope) {
            try {
                String query = 'SELECT Id FROM ' + obj.QualifiedApiName + ' WHERE LastModifiedDate >= ' + yesterday.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'');
                List<SObject> records = Database.query(query);

                if (!records.isEmpty()) {
                    objectNamesModified.add(obj.QualifiedApiName);
                }
            } catch (Exception e) {
                System.debug('Error querying object ' + obj.QualifiedApiName + ': ' + e.getMessage());
            }
        }
    }

    global void finish(Database.BatchableContext BC) {
        // Display the list of modified object names
        System.debug('Objects modified or created in the last 24 hours: ' + objectNamesModified);
    }
}