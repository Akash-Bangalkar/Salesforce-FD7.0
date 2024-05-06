public with sharing class OpportunityController {
	public static void updateCloseDate(List<Opportunity>oppList, Map<Id,Opportunity>oldMap)
    {
        for(Opportunity opp:oppList)
        {
            if(opp.StageName=='Closed Won' && opp.StageName!=oldMap.get(opp.Id).StageName)
            {
                opp.CloseDate = Date.today();
                opp.NextStep = 'CLOSED';
            }
        }
    }
}