@isTest
private class DuplicateCustomerTest {
	@testsetup
    private static void testData()
    {
        List<Contact> conRec = New List<Contact>();
        
        Contact con1 = New Contact();
        con1.FirstName = 'Akash';
        con1.LastName = 'B';
        con1.Email = 'akash@gmail.com';
        conRec.add(con1);
        
        Contact con2 = New Contact();
        con2.FirstName = 'SFDC';
        con2.LastName = 'User';
        con2.Email = 'user@gmail.com';
        conRec.add(con2);
        
        Insert conRec;
    }
    
    @isTest
    private static void TestMethod1() //Insert Check
    {
        Contact con = New Contact();
        con.FirstName = 'Kelly';
        con.LastName = 'Smith';
        con.Email = 'akash@gmail.com';
        
        Insert(con);
    }
    
    @isTest
    private static void TestMethod2() //Update Check
    {
        List<Contact> conRec = New List<Contact>();
        for(contact con:[SELECT ID, Email FROM Contact WHERE Email='user@gmail.com'])
        {
            con.Email = 'akash@gmail.com';
            conRec.add(con);
        }
        
        Update conRec;
    }
}