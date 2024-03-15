@isTest
private class AccountRatingSiteTest {
    @isTest
    private static void firstMethod()
    {
        Account acc = New Account();
        acc.Name = 'Test';
        acc.Rating = 'Hot';
        
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
        
        Test.startTest();
        INSERT acc;
        Test.stopTest();
        
        Account updatedRec = [SELECT ID, TickerSymbol FROM Account];
        System.assertEquals('C - Test', updatedRec.TickerSymbol);
    }
}