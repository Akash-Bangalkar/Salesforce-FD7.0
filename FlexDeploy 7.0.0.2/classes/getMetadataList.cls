public class getMetadataList
{
	public static List<SetupAuditTrail> getList(String timeRange, String selectedUser)
	{
        String soqlQuery;

        // Construct the SOQL query based on selected time range
        if (timeRange.equals('All Time')) {
            soqlQuery = 'SELECT Section, Action, CreatedBy.Name, CreatedDate FROM SetupAuditTrail';
        } else {
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
        }

        // Add conditions for the selected user if provided
        if (selectedUser != null) {
            soqlQuery += ' AND CreatedBy.Name = \'' + selectedUser + '\'';
        }

        try {
            List<SetupAuditTrail> results = Database.query(soqlQuery);
            return results;
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