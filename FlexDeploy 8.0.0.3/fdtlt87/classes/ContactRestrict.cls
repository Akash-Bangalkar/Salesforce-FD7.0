public class ContactRestrict {
	public static void AccIDRestrict(List<Contact> conList)
    {
        List<Account> NewAc = New List<Account>();
        for(Contact con:conList)
        {
            if(con.AccountId == NULL)
            {
                Account acc = New Account();
                acc.Name = con.FirstName + con.LastName;
                
                NewAc.add(acc);
            }
        }
        
        if(!NewAc.isEmpty())
        {
            INSERT NewAc;
        }
    }
}