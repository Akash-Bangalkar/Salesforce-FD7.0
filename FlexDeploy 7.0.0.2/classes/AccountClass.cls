// AccountClass.cls
public class AccountClass {
    public static void createAccountWithContact() {
        Account account = new Account();
        account.Name = 'Test Account';
        insert account;

        Contact contact = new Contact();
        contact.LastName = 'Test LastName';
        contact.AccountId = account.Id;
        insert contact;
    }
}