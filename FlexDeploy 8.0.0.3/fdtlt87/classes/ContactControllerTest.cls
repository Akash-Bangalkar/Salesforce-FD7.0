@isTest
private class ContactControllerTest {
	@TestSetup
    private static void TestData()
    {
        //Insert Contact
        Contact con = New Contact();
        //con.Salutation = 'Mr.';
        con.FirstName = 'TestFirstName';
        con.LastName = 'TestLastName';
        
        INSERT con;
    }
    @isTest
    private static void FirstMethod()
    {
        //Insert Contact1
        Contact con1 = New Contact();
        con1.Salutation = 'Mr.';
        con1.LastName = 'Test1';
        
        //Insert Contact2
        Contact con2 = New Contact();
        con2.Salutation = 'Mrs.';
        con2.LastName = 'Test2';
        
        //Insert Contact3
        Contact con3 = New Contact();
        con3.Salutation = 'Dr.';
        con3.LastName = 'Test3';
        
        //Insert Contact4
        Contact con4 = New Contact();
        con4.Salutation = 'Prof.';
        con4.LastName = 'Test4';
        
        Test.startTest();
        INSERT con1; 
        INSERT con2; 
        INSERT con3; 
        INSERT con4;
        Test.stopTest();
        
        List<Contact> result = [SELECT ID FROM Contact WHERE Salutation != NULL];
        
        System.assertEquals(4,result.size());
    }
    
    @isTest
    private static void SecondMethod()
    {
        Contact conRec = [SELECT ID, Salutation FROM Contact LIMIT 1];
        
        conRec.Salutation = 'Dr.';
        
        Test.startTest();
        UPDATE conRec;
        Test.stopTest();
        
        List<Contact> result = [SELECT ID, AssistantName FROM Contact WHERE AssistantName = 'Doctor'];
        
        System.assertEquals(1,result.size());
    }
}