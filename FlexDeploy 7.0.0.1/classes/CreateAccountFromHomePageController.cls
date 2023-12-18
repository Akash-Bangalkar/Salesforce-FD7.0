public class CreateAccountFromHomePageController {
    public Account Account { get; set; }

    public CreateAccountFromHomePageController(ApexPages.StandardController controller) {
        // Initialize a new Account record when the page loads
        Account = new Account();
    }

    public PageReference saveAccount() {
        try {
            // Insert the new Account record
            insert Account;
            // Redirect to the newly created Account's detail page
            PageReference accountDetailPage = new PageReference('/' + Account.Id);
            accountDetailPage.setRedirect(true);
            return accountDetailPage;
        } catch (DmlException ex) {
            // Handle any potential exceptions (e.g., validation rules, unique field constraints).
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: ' + ex.getMessage()));
            return null;
        }
    }
}