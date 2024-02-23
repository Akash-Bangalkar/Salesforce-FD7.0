public class MetadataApiExample {

    // Replace with your Salesforce Metadata API endpoint
    private static final String METADATA_API_ENDPOINT = 'https://flexdeploy-dev-ed.develop.my.salesforce.com/services/data/v58.0/tooling/query/?q=SELECT+Id,+DeveloperName+FROM+CustomObject';

    // Replace with your Salesforce access token
    private static final String ACCESS_TOKEN = '0HyeRSZ3Li1BNqu2H5FbEPL13';

    public static void getModifiedMetadataFiles() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(METADATA_API_ENDPOINT);
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + ACCESS_TOKEN);

        HttpResponse response = new Http().send(request);

        if (response.getStatusCode() == 200) {
            // Parse the JSON response to extract metadata information
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());

            // Access the relevant information from the result
            List<Map<String, Object>> records = (List<Map<String, Object>>) result.get('records');
            for (Map<String, Object> record : records) {
                String metadataId = (String) record.get('Id');
                String metadataName = (String) record.get('DeveloperName');
                System.debug('Metadata Id: ' + metadataId + ', Name: ' + metadataName);
            }
        } else {
            System.debug('Error: ' + response.getStatusCode() + ' ' + response.getStatus());
            System.debug('Response Body: ' + response.getBody());
        }
    }
}