public class AccessTokenRefresh {

    private static final String CLIENT_ID = 'your_salesforce_org_client_id';
    private static final String CLIENT_SECRET = 'your_client_secret';
    private static final String REFRESH_TOKEN = 'your_refresh_token';

    public static String refreshAccessToken() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setBody('grant_type=refresh_token&client_id=' + CLIENT_ID + '&client_secret=' + CLIENT_SECRET + '&refresh_token=' + REFRESH_TOKEN);

        HttpResponse response = new Http().send(request);

        if (response.getStatusCode() == 200) {
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            return (String) result.get('access_token');
        } else {
            System.debug('Error refreshing access token: ' + response.getStatusCode() + ' ' + response.getStatus());
            System.debug('Response Body: ' + response.getBody());
            return null;
        }
    }
}