public class RelatedCount {
	public static void relatedCt(List<Account> accList, Map<ID, Account> oldMap)
    {
        Set<ID> accID = New Set<ID>();
        for(Account acc:accList)
        {
            if(acc.Active__c == 'Yes' && acc.Active__c != oldMap.get(acc.Id).Active__c)
            {
                accID.add(acc.Id);
            }
        }
        
        if(!accID.isEmpty())
        {
            List<Contact> conCount = [SELECT ID FROM Contact WHERE AccountID IN :accID];
            List<Opportunity> oppCount = [SELECT ID FROM Opportunity WHERE AccountID IN :accID];
            List<Case> csCount = [SELECT ID FROM Case WHERE AccountID IN :accID];
            
            for(Account acc:accList)
            {
                acc.Description = 'Total Contacts - ' + conCount.size() + '\nTotal Opportunities - ' + oppCount.size() +
                    			 '\nTotal Cases - ' + csCount.size();
            }
        }
    }
}