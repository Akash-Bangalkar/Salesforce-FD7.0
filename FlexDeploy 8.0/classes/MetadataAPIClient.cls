public class MetadataAPIClient {
    private String clientId = '3MVG9pRzvMkjMb6kIn5kIZdU6oe_Fow3WXlYkAOiCUAMM43Hgd.0J26h6BO6XbTgwgGe_lYLyBlyJxetY3J8N';
    private String clientSecret = '4BB12F55B24B6C62F0D5F53ABCDB5894A45D5A2C57F7AB253996F1EA89F4532A';
    private String username = 'flexdeploy7@sfdc.source';
    private String password = 'Admin@12345';
    private String securityToken = 'KkvEebGRugHkMD1ILcvC5DFr';
    private String instanceUrl = 'https://flexdeploy-dev-ed.develop.my.salesforce.com/';

    public static void main(String[] args) {
        MetadataAPIClient metadataClient = new MetadataAPIClient();
        metadataClient.retrieveRecentChanges();
    }
    
    
    public void retrieveRecentChanges() {
        // Authenticate and get the access token
        String accessToken = getAccessToken();

        // Construct the Metadata API request URL
        String metadataUrl = instanceUrl + '/services/data/v58.0/metadata/retrieveRecent';

        // Make the Metadata API request
        HttpRequest request = new HttpRequest();
        request.setEndpoint(metadataUrl);
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + accessToken);

        Http http = new Http();
        HttpResponse response = http.send(request);

        // Handle the response
        if (response.getStatusCode() == 200) {
            // Successfully retrieved recent changes, handle the response as needed
            String responseBody = response.getBody();
            System.debug(responseBody);
        } else {
            // Handle errors
            System.debug('Error: ' + response.getStatusCode() + ', ' + response.getStatus());
            System.debug('Response Body: ' + response.getBody());
        }
    }

    private String getAccessToken() {
        // Authenticate and get the access token
        String authUrl = instanceUrl + '/services/oauth2/token';
        String requestBody = 'grant_type=password&client_id=' + clientId + '&client_secret=' + clientSecret +
                             '&username=' + username + '&password=' + password + securityToken;

        HttpRequest request = new HttpRequest();
        request.setEndpoint(authUrl);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setBody(requestBody);

        Http http = new Http();
        HttpResponse response = http.send(request);

        // Parse and return the access token
        Map<String, Object> authResult = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        return (String) authResult.get('access_token');
    }
}