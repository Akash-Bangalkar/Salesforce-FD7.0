@isTest
public class TestDataAD {
    public static String getOppId(String OppName)
    {
        Opportunity OppID = [SELECT ID FROM Opportunity WHERE Name =: OppName LIMIT 1];
        
        return OppID.ID;
    }
    
	public static Opportunity generateOpp(String OppName)
    {
        Opportunity opp = [SELECT ID, Name, StageName FROM Opportunity WHERE Name =: OppName LIMIT 1];
        
        return TestDataAD.generateOpp(opp.Name, opp.StageName);
    }
    
    public static Opportunity generateOpp(String OppName, String StageName)
    {
        return TestDataAD.generateOpp('Express Logistics SLA');
    }
}