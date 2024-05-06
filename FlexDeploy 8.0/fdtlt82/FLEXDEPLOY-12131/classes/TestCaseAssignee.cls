@isTest
private class TestCaseAssignee {
    @testSetup
	private static void TestData()
    {
        //Create Case Record 1
        Case csRecord = New Case();
        csRecord.Status = 'New';
        csRecord.Origin = 'Email';
        csRecord.Type = 'Other';
        csRecord.Priority = 'Low';
        csRecord.Subject = 'Test Priority Owner Assignee';
        
        INSERT csRecord;
        
        //Create Case Record 2
        Case csRecord1 = New Case();
        csRecord1.Status = 'New';
        csRecord1.Origin = 'Phone';
        csRecord1.Type = 'Other';
        csRecord1.Priority = 'Low';
        csRecord1.Subject = 'Test Priority Owner Assignee';
        
        INSERT csRecord1;
    }
    
    @isTest
    private static void FirstMethod()
    {
        //Create Case Record - High Priority
        Case csRecord = New Case();
        csRecord.Status = 'New';
        csRecord.Origin = 'Email';
        csRecord.Type = 'Other';
        csRecord.Priority = 'High';
        csRecord.SLAViolation__c = 'Yes';
        csRecord.Subject = 'Test High Priority Owner Assignee';
        
        test.startTest();
        INSERT csRecord;
        test.stopTest();
        
        Case csCheck = [SELECT ID, SLAViolation__c, OwnerId FROM Case WHERE SLAViolation__c = 'Yes'];
        ID OwnerId = csCheck.OwnerId;
        ID expID = '0052t0000013lQsAAI'; //AB
        System.assertEquals(expID, OwnerId);
    }
    
    @isTest
    private static void SecondMethod()
    {
        //Create Case Record - Medium Priority
        Case csRecord2 = New Case();
        csRecord2.Status = 'New';
        csRecord2.Origin = 'Email';
        csRecord2.Type = 'Other';
        csRecord2.Priority = 'Medium';
        csRecord2.SLAViolation__c = 'No';
        csRecord2.Subject = 'Test High Priority Owner Assignee';
        
        test.startTest();
        INSERT csRecord2;
        test.stopTest();
        
        Case csCheck2 = [SELECT ID, SLAViolation__c, OwnerId FROM Case WHERE SLAViolation__c = 'No'];
        ID OwnerId2 = csCheck2.OwnerId;
        ID expID2 = '0052t0000014nk1AAA'; //Flex
        System.assertEquals(expID2, OwnerId2);
    }
    
    @isTest
    private static void ThirdMethod()
    {
        //Update Case Record 1
        List<Case> csList1 = [SELECT ID, Priority, OwnerId FROM Case WHERE Origin = 'Phone'];
        
        for(Case cs:csList1)
        {
            cs.Priority = 'High';
        }
        
        test.startTest();
        UPDATE csList1;
        test.stopTest();
        
        List<Case> csCheck1 = [SELECT ID, OwnerId FROM Case WHERE Priority = 'High'];
        System.assertEquals(1, csCheck1.size());
    }
    
    @isTest
    private static void FourthMethod()
    {
        //Update Case Record 2
        List<Case> csList2 = [SELECT ID, Priority, OwnerId FROM Case WHERE Origin = 'Email'];
        
        for(Case cs:csList2)
        {
            cs.Priority = 'Medium';
        }
        
        test.startTest();
        UPDATE csList2;
        test.stopTest();
        
        List<Case> csCheck2 = [SELECT ID, OwnerId FROM Case WHERE Priority = 'Medium'];
        System.assertEquals(1, csCheck2.size());
    }
}