@IsTest
private class MyFirstRestAPIClassTest {

    static testMethod void testGetMethod(){
        Account acc = new Account();
        acc.Name='Test';
        acc.AccountNumber ='12345';
        insert acc;
        
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/api/Account/12345';
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account acct = MyFirstRestAPIClass.doGet();
        System.assert(acct != null);
        System.assertEquals('Test', acct.Name);
        
    }
}