// TestCircularDependency.cls
@isTest
public class TestCircularDependency {
    @isTest
    static void testCircularDependency() {
        Test.startTest();
        AccountClass.createAccountWithContact(); //circular dependency error
        Test.stopTest();
    }
}