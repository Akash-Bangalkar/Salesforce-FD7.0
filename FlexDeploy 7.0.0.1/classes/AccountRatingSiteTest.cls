@isTest
private class AccountRatingSiteTest {
	@isTest
    private static void firstMethod()
    {
        Account acc = New Account();
        acc.Name = 'Test';
        acc.Rating = 'Hot';
       // acc.External_ID__c = 'T-1';
        
        Test.startTest();
        INSERT acc;
        Test.stopTest();
        
        Account updatedRec = [SELECT ID, TickerSymbol FROM Account];
        System.assertEquals('H - Test', updatedRec.TickerSymbol);
    }
    
    @isTest
    private static void secondMethod()
    {
        Account acc = New Account();
        acc.Name = 'Test';
        acc.Rating = 'Warm';
      //  acc.External_ID__c = 'T-1';
        
        Test.startTest();
        INSERT acc;
        Test.stopTest();
        
        Account updatedRec = [SELECT ID, TickerSymbol FROM Account];
        System.assertEquals('W - Test', updatedRec.TickerSymbol);
    }
    
    @isTest
    private static void thirdMethod()
    {
        Account acc = New Account();
        acc.Name = 'Test';
        acc.Rating = 'Cold';
      //  acc.External_ID__c = 'T-1';
        
        Test.startTest();
        INSERT acc;
        Test.stopTest();
        
        Account updatedRec = [SELECT ID, TickerSymbol FROM Account];
        System.assertEquals('C - Test', updatedRec.TickerSymbol);
    }
}