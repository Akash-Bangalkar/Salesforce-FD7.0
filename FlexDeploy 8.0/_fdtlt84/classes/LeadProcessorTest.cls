@isTest
public class LeadProcessorTest {

    @isTest
    static void Mytest() {
        List<Lead> leadlist = new List<Lead>();
        for(Integer i=1;i<=200;i++) {
            Lead l = new Lead(LastName='Last Name'+i,Company = 'Company '+i,Status='Open - Not Contacted');
            leadlist.add(l);
        }
        insert leadlist;
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Database.executeBatch(lp);
        Test.stopTest();
        List<Lead> leadlist1 = [SELECT LeadSource FROM Lead];
        for(Lead l : leadlist1)
            System.assertEquals(l.LeadSource, 'Dreamforce');
    }
}