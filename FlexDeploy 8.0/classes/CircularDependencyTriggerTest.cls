@isTest
private class CircularDependencyTriggerTest {
    @isTest
    static void testTrigger() {
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(Name = 'Test Account'));
        insert accounts;
    }
}