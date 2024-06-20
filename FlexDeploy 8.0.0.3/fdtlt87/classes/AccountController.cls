public class AccountController {
	public static void duplicateAccount(List<Account> accList)
    {
        String accName;
        for(Account acc:accList)
        {
            accName = acc.Name;
        }
        
        List<Account> duplicateAc = [SELECT ID, Name, AccountNumber FROM Account WHERE Name = :accName];
        Map<String, String> dupRecord = New Map<String, String>(); //EMPTY MAP
        
        for(Account ac:duplicateAc)
        {
            dupRecord.put(ac.Name, ac.AccountNumber);
        }
        
        if(duplicateAc.size()>0)
        {
            for(Account acc:accList)
            {
                if(dupRecord.containsKey(acc.Name))
                {
                    acc.Name.addError('DUPLICATE ACCOUNT NAME - AC NO - ' + dupRecord.get(acc.Name));
                }
            }
        }
    }
}