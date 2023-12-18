@isTest
private class OpportunityNextStepTest {
    @testSetup
    private static void testData()
    {
        Opportunity opp = New Opportunity();
        opp.Name = 'Test Opp';
        opp.CloseDate = date.today() + 10;
        opp.StageName = 'Prospecting';
       	INSERT opp;
    }
    
	@isTest
    private static void firstMethod()
    {
        Opportunity opp = [SELECT ID, StageName, NextStep FROM Opportunity];
        
        opp.StageName = 'Closed Won';
        
        Test.startTest();
        UPDATE opp;
        Test.stopTest();
        
        Opportunity checkResult = [SELECT ID, NextStep FROM Opportunity];
        
        System.assertEquals('CLOSED', checkResult.NextStep);
    }
}