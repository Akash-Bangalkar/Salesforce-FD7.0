@isTest
private class AccountControllerTest {
	@TestSetup
    private static void TestData()
    {
        Account acc = New Account();
        acc.Name = 'TestAccount';
        acc.Site = 'FlexDeploy';
        
        INSERT acc;
    }
    
    @isTest
    private static void FirstMethod()
    {
        Account accList = [SELECT ID, Name, Rating, Ownership FROM Account LIMIT 1];
        
        accList.Ownership = 'Public';
        
        Test.startTest();
        UPDATE accList;
        Test.stopTest();
        
        List<Account> result = [SELECT ID, Name, Rating, Ownership FROM Account WHERE Rating = 'Hot'];
        
        System.assertEquals(1,result.size());
    }
    
    @isTest
    private static void SecondMethod()
    {
        Account accList = [SELECT ID, Name, Rating, Ownership FROM Account LIMIT 1];
        
        accList.Ownership = 'Private';
        
        Test.startTest();
        UPDATE accList;
        Test.stopTest();
        
        List<Account> result = [SELECT ID, Name, Rating, Ownership FROM Account WHERE Rating = 'Cold'];
        
        System.assertEquals(1,result.size());
    }
    
    @isTest
    private static void ThirdMethod()
    {
        Account accList = [SELECT ID, Name, Rating, Ownership FROM Account LIMIT 1];
        
        accList.Ownership = 'Other';
        
        Test.startTest();
        UPDATE accList;
        Test.stopTest();
        
        List<Account> result = [SELECT ID, Name, Rating, Ownership FROM Account WHERE Rating = 'Warm'];
        
        System.assertEquals(1,result.size());
    }
}