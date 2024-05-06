public with sharing class DuplicateCustomer {
	public static void checkDuplicateEmail(List<Contact>conList, Map<Id,Contact>oldMap)
    {
        Set<String> ipEmail = New Set<String>();
        for(Contact con:conList)
        {
            if(con.Email!=NULL && oldMap==NULL) //Insert
            {
                ipEmail.add(con.Email);
            }
            else if(con.Email!=NULL && con.Email!=oldMap.get(con.Id).Email)
            {
                ipEmail.add(con.Email);
            }
        }
        
        Map<String,String> extEmail = New Map<String,String>();
        if(ipEmail.size()>0)
        {
            for(Contact con:[SELECT ID, Email, Name FROM Contact WHERE Email IN:ipEmail])
            {
                extEmail.put(con.Email, con.Name);
            }
        }
        
        if(extEmail!=NULL)
        {
            for(Contact con:conList)
            {
                if(extEmail.containsKey(con.Email))
                {
                    con.Email.addError('Email already registered - '+extEmail.get(con.Email));
                }
            }
        }
    }
}