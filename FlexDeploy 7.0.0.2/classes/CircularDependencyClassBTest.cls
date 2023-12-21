@isTest
private class CircularDependencyClassBTest {
    @isTest
    static void testClassB() {
        CircularDependencyClassB.methodB();
    }
}