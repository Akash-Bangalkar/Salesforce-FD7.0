@RestResource(urlMapping='/api/Account/*')
global with sharing class MyFirstRestAPIClass
{
    @HttpGet
    global static Account doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String AccNumber = 'CD439877'; //req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name, Phone, Website FROM Account WHERE AccountNumber = :AccNumber ];
        return result;
    }
}