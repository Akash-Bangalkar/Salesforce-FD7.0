@isTest
private class OpportunityNextStepTest {
/*   
@testSetup static void testData()
    {
        Opportunity opp = New Opportunity();
        opp.Name = 'Test Opp';
        opp.CloseDate = date.today() + 10;
        opp.StageName = 'Prospecting';
        INSERT opp;
    }
*/  
    @isTest static void firstMethod()
    {
        ID oppId = TestDataAD.getOppId('Express Logistics SLA');
        
        Opportunity opp = TestDataAD.generateOpp('Express Logistics SLA');
        
        opp.StageName = 'Closed Won';
        
        Test.startTest();
        UPDATE opp;
        Test.stopTest();
        
        Opportunity checkResult = [SELECT ID, NextStep FROM Opportunity];
        
        System.assertEquals('CLOSED', checkResult.NextStep);
    }
}