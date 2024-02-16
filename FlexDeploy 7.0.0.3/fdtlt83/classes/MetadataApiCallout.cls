public class MetadataApiCallout {
    public static void retrieveMetadata() {
        String clientId = '3MVG9pRzvMkjMb6kIn5kIZdU6oe_Fow3WXlYkAOiCUAMM43Hgd.0J26h6BO6XbTgwgGe_lYLyBlyJxetY3J8N';
        String clientSecret = '4BB12F55B24B6C62F0D5F53ABCDB5894A45D5A2C57F7AB253996F1EA89F4532A';
        String username = 'flexdeploy7@sfdc.source';
        String password = 'Admin@12345' + 'KkvEebGRugHkMD1ILcvC5DFr';

        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setBody('grant_type=password&client_id=' + clientId +
                    '&client_secret=' + clientSecret +
                    '&username=' + username +
                    '&password=' + password);

        Http http = new Http();
        HttpResponse res = http.send(req);

        // Parse the JSON response to get the access token
        Map<String, Object> authResult = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
        String accessToken = (String)authResult.get('access_token');

        // Use the access token to make a callout to Metadata API
        HttpRequest metadataReq = new HttpRequest();
        metadataReq.setEndpoint('https://instance.salesforce.com/services/data/v52.0/tooling/sobjects');
        metadataReq.setMethod('GET');
        metadataReq.setHeader('Authorization', 'Bearer ' + accessToken);

        HttpResponse metadataRes = http.send(metadataReq);
        System.debug(metadataRes.getBody());
    }
}