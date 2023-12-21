public class RecentlyModifiedMetadata {

    // Define the REST API endpoint
    private static final String REST_API_ENDPOINT = '/services/data/v54.0/query/';

    // Method to query recently modified metadata
    public static void queryRecentlyModifiedMetadata() {
        String query = 'SELECT Id, CreatedDate, CreatedBy.Name, Display, Action, Section, Object, Fullname ' +
                       'FROM SetupAuditTrail ' +
                       'WHERE Action != \'Login\' ' +
                       'ORDER BY CreatedDate DESC LIMIT 10'; // Adjust the LIMIT as needed

        HttpRequest request = new HttpRequest();
        request.setEndpoint(URL.getOrgDomainUrl().toExternalForm() + REST_API_ENDPOINT + '?q=' + EncodingUtil.urlEncode(query, 'UTF-8'));
        request.setMethod('GET');

        // Set the OAuth token in the request headers
        request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());

        // Make the HTTP request
        Http http = new Http();
        HttpResponse response = http.send(request);

        // Process the response
        if (response.getStatusCode() == 200) {
            // Parse and handle the response JSON
            Map<String, Object> responseData = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> records = (List<Object>) responseData.get('records');

            // Process the records as needed
            for (Object record : records) {
                Map<String, Object> recordMap = (Map<String, Object>) record;
                System.debug('Metadata Change: ' + recordMap.get('Object') + ' - ' + recordMap.get('Fullname'));
            }
        } else {
            // Handle the error response
            System.debug('Error: ' + response.getStatusCode() + ' ' + response.getStatus());
            System.debug('Response Body: ' + response.getBody());
        }
    }
}