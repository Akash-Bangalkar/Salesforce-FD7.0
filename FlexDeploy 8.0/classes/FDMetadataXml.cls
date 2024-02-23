public with sharing class FDMetadataXml {
    @AuraEnabled(cacheable=true)
    public static List<String> getUserNames() {
        List<String> userNames = new List<String>();
        
        // Fetch all active users
        List<User> users = [SELECT Id, Name FROM User WHERE IsActive = true ORDER BY Name];
        
        // Populate the list of user names
        for (User user : users) {
            userNames.add(user.Name);
        }
        
        return userNames;
    }

    public class MetadataResult {
        @AuraEnabled public String Section;
        @AuraEnabled public String Action;
        @AuraEnabled public String ModifiedBy;
        @AuraEnabled public DateTime CreatedDate;
        @AuraEnabled public String FormattedDate; // formatted date

        public MetadataResult(String section, String action, String modifiedBy, DateTime createdDate) {
            this.Section = section;
            this.Action = action;
            this.ModifiedBy = modifiedBy;
            this.CreatedDate = createdDate;
            this.FormattedDate = createdDate != null ? createdDate.format('MMM dd, yyyy, hh:mm a') : null;
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<MetadataResult> getMetadataList(String timeRange, String selectedUser) {
        String soqlQuery;

        if (timeRange.equals('All Time'))
        {
            soqlQuery = 'SELECT Section, Action, CreatedBy.Name, CreatedDate FROM SetupAuditTrail';
            
            // If All Time is selected, and a specific user is selected
            if (selectedUser != null) {
                soqlQuery += ' WHERE CreatedBy.Name = \'' + selectedUser + '\'' + 'ORDER BY CreatedDate DESC';
            }
            // If All Time is selected, and a specific user is null
            else if(selectedUser == null)
            {
                soqlQuery += ' ORDER BY CreatedDate DESC';
            }
        }
        else
        {
            soqlQuery = 'SELECT Section, Action, CreatedBy.Name, CreatedDate FROM SetupAuditTrail WHERE CreatedDate >= ';
            if (timeRange.equals('Last 1 Day')) {
                soqlQuery += 'LAST_N_DAYS:1';
            } else if (timeRange.equals('Last 2 Days')) {
                soqlQuery += 'LAST_N_DAYS:2';
            } else if (timeRange.equals('Last 1 Week')) {
                soqlQuery += 'LAST_N_WEEKS:1';
            } else if (timeRange.equals('Last 1 Month')) {
                soqlQuery += 'LAST_N_MONTHS:1';
            } else if (timeRange.equals('Last 6 Months')) {
                soqlQuery += 'LAST_N_MONTHS:6';
            } else if (timeRange.equals('Last 1 Year')) {
                soqlQuery += 'LAST_N_YEARS:1';
            }

            if (selectedUser != null) {
                soqlQuery += ' AND CreatedBy.Name = \'' + selectedUser + '\'' + 'ORDER BY CreatedDate DESC';
            }
        }

        try {
            List<SetupAuditTrail> results = Database.query(soqlQuery);

            List<MetadataResult> formattedResults = new List<MetadataResult>();
            for (SetupAuditTrail record : results)
            {
                formattedResults.add(new MetadataResult(
                    record.Section,
                    record.Action,
                    record.CreatedBy.Name,
                    record.CreatedDate
                ));
            }

            return formattedResults;
        } catch (Exception e) {
            // Log detailed information about the exception
            System.debug('Exception Message: ' + e.getMessage());
            System.debug('Exception Type: ' + e.getTypeName());
            System.debug('Exception Stack Trace: ' + e.getStackTraceString());

            // Throw the exception with a generic message to the client
            throw new AuraHandledException('Error retrieving metadata list. Please check logs for details.');
        }
    }
}