public class ContactController {
	public static void changeEmail(List<Contact> conList, Map<ID, Contact> oldMap)
    {
        Set<ID> conId = New Set<ID>();
        String newEmail;
        for(Contact con:conList)
        {
            if(con.Email != oldMap.get(con.Id).Email)
            {
                conId.add(con.Id);
                newEmail = con.Email;
            }
        }
        
        List<Case> csList = New List<Case>();
        if(!conId.isEmpty())
        {
            for(Case cs:[SELECT ID, SuppliedEmail FROM Case WHERE ContactId IN :conId])
            {
                cs.SuppliedEmail = newEmail;
                csList.add(cs);
            }
        }
        
        if(!csList.isEmpty())
        {
            UPDATE csList;
        }
    }
    
    public static void uniqueValue(List<Contact> conList, Map<ID, Contact> oldMap)
    {
        
    }
}