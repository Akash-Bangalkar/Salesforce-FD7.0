public class FindMetadataFD {
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
        @AuraEnabled public DateTime LastModifiedDate;
        @AuraEnabled public String FormattedDate; // formatted date
        @AuraEnabled public String FileName; // added FileName

        public MetadataResult(String section, String action, String modifiedBy, DateTime lastModifiedDate, String fileName) {
            this.Section = section;
            this.Action = action;
            this.ModifiedBy = modifiedBy;
            this.LastModifiedDate = lastModifiedDate;
            this.FormattedDate = lastModifiedDate != null ? lastModifiedDate.format('MMM dd, yyyy, hh:mm a') : null;
            this.FileName = fileName;
        }
    }

    private static Map<String, String> fileTypeMapping = new Map<String, String>{
        'Apex Class' => 'ApexClass',
        'Apex Trigger' => 'ApexTrigger'
        // Add more mappings as needed
    };

    @AuraEnabled(cacheable=true)
    public static List<MetadataResult> getMetadataList(String timeRange, String selectedUser) {
        Set<String> fileTypes = getFileTypes(timeRange, selectedUser); // Fetch file types dynamically
        List<MetadataResult> metadataResults = new List<MetadataResult>();

        if (fileTypes.size() == 0) {
            // No file types specified, return an empty list
            return metadataResults;
        }

        for (String fileType : fileTypes) {
            String soqlQuery = 'SELECT Name, LastModifiedBy.Name, LastModifiedDate FROM ' + fileType;

            // Simplify the 'All Time' condition
            if (selectedUser != null) {
                soqlQuery += ' WHERE CreatedBy.Name = \'' + selectedUser + '\'';
            }

            if (!timeRange.equals('All Time')) {
                if (timeRange.equals('Last 1 Day')) {
                    soqlQuery += ' AND LastModifiedDate >= LAST_N_DAYS:1';
                } else if (timeRange.equals('Last 2 Days')) {
                    soqlQuery += ' AND LastModifiedDate >= LAST_N_DAYS:2';
                } else if (timeRange.equals('Last 1 Week')) {
                    soqlQuery += ' AND LastModifiedDate >= LAST_N_WEEKS:1';
                } else if (timeRange.equals('Last 1 Month')) {
                    soqlQuery += ' AND LastModifiedDate >= LAST_N_MONTHS:1';
                } else if (timeRange.equals('Last 6 Months')) {
                    soqlQuery += ' AND LastModifiedDate >= LAST_N_MONTHS:6';
                } else if (timeRange.equals('Last 1 Year')) {
                    soqlQuery += ' AND LastModifiedDate >= LAST_N_YEARS:1';
                }
            }

            soqlQuery += ' ORDER BY LastModifiedDate DESC';

            try {
                List<SObject> sObjects = Database.query(soqlQuery);

                for (SObject obj : sObjects) {
                    // Retrieve the LastModifiedBy's Name using the LastModifiedById field
                    Id lastModifiedById = (Id)obj.get('LastModifiedById');
                    String lastModifiedByName = lastModifiedById != null ? 
                        [SELECT Name FROM User WHERE Id = :lastModifiedById].Name : null;
                
                    metadataResults.add(new MetadataResult(fileType, 'Modified', lastModifiedByName, (DateTime)obj.get('LastModifiedDate'), (String)obj.get('Name')));
                }
                
            } catch (Exception e) {
                // Log detailed information about the exception
                System.debug('Exception Message: ' + e.getMessage());
                System.debug('Exception Type: ' + e.getTypeName());
                System.debug('Exception Stack Trace: ' + e.getStackTraceString());

                // Throw the exception with a generic message to the client
                throw new AuraHandledException('Error retrieving metadata list. Please check logs for details.');
            }
        }

        return metadataResults;
    }

    private static Set<String> getFileTypes(String timeRange, String selectedUser) {
        Set<String> fileTypes = new Set<String>();
    
        String soqlQuery = 'SELECT Section FROM SetupAuditTrail';
    
        if (timeRange.equals('All Time')) {
            if (selectedUser != null) {
                soqlQuery += ' WHERE CreatedBy.Name = \'' + selectedUser + '\'';
            }
        } else {
            if (timeRange.equals('Last 1 Day')) {
                soqlQuery += ' WHERE CreatedDate >= LAST_N_DAYS:1';
            } else if (timeRange.equals('Last 2 Days')) {
                soqlQuery += ' WHERE CreatedDate >= LAST_N_DAYS:2';
            } else if (timeRange.equals('Last 1 Week')) {
                soqlQuery += ' WHERE CreatedDate >= LAST_N_WEEKS:1';
            } else if (timeRange.equals('Last 1 Month')) {
                soqlQuery += ' WHERE CreatedDate >= LAST_N_MONTHS:1';
            } else if (timeRange.equals('Last 6 Months')) {
                soqlQuery += ' WHERE CreatedDate >= LAST_N_MONTHS:6';
            } else if (timeRange.equals('Last 1 Year')) {
                soqlQuery += ' WHERE CreatedDate >= LAST_N_YEARS:1';
            }
        }
    
        List<SetupAuditTrail> setupAuditTrailResults = Database.query(soqlQuery);
    
        for (SetupAuditTrail rec : setupAuditTrailResults) {
            // Use the mapping to get the API name
            String apiName = fileTypeMapping.get(rec.Section);
            if(apiName != null) {
                fileTypes.add(apiName);
            }
        }
    
        return fileTypes;
    }
}