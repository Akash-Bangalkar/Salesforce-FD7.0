global class LeadProcessor implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id FROM Lead');
    }
    global void execute(Database.BatchableContext bc, List<Lead> leadrecords) {
        for(Lead l : leadrecords) {
            l.LeadSource = 'Dreamforce';
        }
        update leadrecords;
    }
    global void finish(Database.BatchableContext bc) {
        
    }
}