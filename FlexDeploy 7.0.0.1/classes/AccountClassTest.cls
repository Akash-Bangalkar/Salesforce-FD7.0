@isTest
private class AccountClassTest {
    @isTest(SeeAllData=True)
	private static void firstMethod()
    {
        List<Account> accList = [SELECT ID, Active__c, NaicsCode FROM Account];
        
        for(Account acc:accList)
        {
            acc.Active__c = 'Yes';
        }
        
        Test.startTest();
        Update accList;
        Test.stopTest();
    }
}