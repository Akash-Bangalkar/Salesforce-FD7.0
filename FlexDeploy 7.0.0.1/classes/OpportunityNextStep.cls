public class OpportunityNextStep {
	public static void updateNextStep(List<Opportunity> oppList, MAP<ID, Opportunity> oldMap)
    {
		for(Opportunity opp:oppList)
        {
            if((opp.StageName=='Closed Won' || opp.StageName=='Closed Lost') && opp.StageName != oldMap.get(opp.Id).StageName)
            {
                opp.NextStep = 'CLOSED';
            }
        }    
    }
}