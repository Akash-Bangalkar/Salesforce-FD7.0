public class CaseAssignee {
	public static void changeOwner(List<Case> csList, Map<ID, Case> oldMap)
    {
        for(Case cs:csList)
        {
            if(cs.Priority == 'High')
            {
                if(oldMap == NULL)
                {
                    cs.OwnerId = '0052t0000013lQsAAI'; //AB
                }
                else if(cs.Priority != oldMap.get(cs.Id).Priority)
                {
                    cs.OwnerId = '0052t0000013lQsAAI'; //AB
                }
            }
            else if(cs.Priority == 'Medium')
            {
                if(oldMap == NULL)
                {
                    cs.OwnerId = '0052t0000014nk1AAA'; //Flex
                }
                else if(cs.Priority != oldMap.get(cs.Id).Priority)
                {
                    cs.OwnerId = '0052t0000014nk1AAA'; //Flex
                }
            }            
        }
    }
}