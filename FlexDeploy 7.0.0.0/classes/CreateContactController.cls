public class CreateContactController {
    public Contact newContact { get; set; }
    public Id accountId { get; set; }

    public CreateContactController() {
        // Initialize a new Contact record when the component loads
        newContact = new Contact();
    }

    public void saveContact() {
        try {
            // Associate the Contact with the specified Account (if provided)
            if (accountId != null) {
                newContact.AccountId = accountId;
            }
            // Insert the new Contact record
            insert newContact;
            // Reset the Contact record to create a new one
            newContact = new Contact();
        } catch (DmlException ex) {
            // Handle any potential exceptions (e.g., validation rules, unique field constraints).
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error: ' + ex.getMessage()));
        }
    }
}