public class AccountClass {
	public static void updateNextStep(List<Account> accList, Map<Id, Account> oldMap)
    {
        for(Account acc:accList)
        {
            if(acc.Active__c=='Yes' && acc.Active__c != oldMap.get(acc.Id).Active__c)
            {
                acc.NaicsCode = 'Y';
            }
        }
    }
}