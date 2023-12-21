// ContactClass.cls
public class ContactClass {
    public static void createContactWithAccount() {
        Contact contact = new Contact();
        contact.LastName = 'Test LastName';
        insert contact;

        Account account = new Account();
        account.Name = 'Test Account';
        account.Contact__c = contact.Id;
        insert account;
    }
}