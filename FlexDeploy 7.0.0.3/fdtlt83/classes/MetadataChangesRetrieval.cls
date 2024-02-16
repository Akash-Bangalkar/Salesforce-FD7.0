public class MetadataChangesRetrieval {

    // Define your Salesforce Metadata API endpoint
    //private static final String METADATA_API_ENDPOINT = '/services/data/v59.0/tooling/query/?q=SELECT+Id,MetadataContainerId,MetadataType,Metadata,FullName,LastName,LastModifiedDate+FROM+MetadataComponentDependency';
    private static final String METADATA_API_ENDPOINT = '/services/data/v59.0/tooling/query/?q=SELECT+Id,DeveloperName,LastModifiedDate+FROM+CustomObject';

    // Your Salesforce instance URL
    private static final String INSTANCE_URL = 'https://flexdeploy-dev-ed.develop.my.salesforce.com';

    // Make a REST API callout to retrieve metadata changes
    public static void retrieveMetadataChanges() {
        // Set up the request
        HttpRequest request = new HttpRequest();
        request.setEndpoint(INSTANCE_URL + METADATA_API_ENDPOINT);
        request.setMethod('GET');

        // Set the necessary headers (you may need to adjust based on your org)
        request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');

        // Make the HTTP callout
        Http http = new Http();
        HttpResponse response = http.send(request);

        // Parse and process the response
        if (response.getStatusCode() == 200) {
            // Parse and process the response body (JSON) here
            String responseBody = response.getBody();
            System.debug('Metadata Changes Response: ' + responseBody);
        } else {
            // Handle errors here
            System.debug('Error retrieving metadata changes. Status code: ' + response.getStatusCode());
            System.debug('Error message: ' + response.getStatus());
        }
    }
}