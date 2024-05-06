public class CreateContacts {
    // Method to create contacts based on input number and account ID #1224
    public static void createContacts(Integer numOfContacts, Id accountId) {
        List<Contact> contactsToCreate = new List<Contact>();

        // Iterate based on input number to create contacts
        for (Integer i = 0; i < numOfContacts; i++) {
            Contact newContact = new Contact();
            newContact.FirstName = 'Contact' + String.valueOf(i + 1); // Naming contacts as Contact1, Contact2, etc.
            newContact.LastName = 'LastName';
            newContact.AccountId = accountId; // Assign provided account ID as parent ID
            contactsToCreate.add(newContact);
        }

        // Insert the list of contacts
        if (!contactsToCreate.isEmpty()) {
            insert contactsToCreate;
        }
    }
}
// Class End