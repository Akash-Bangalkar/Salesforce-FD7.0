@isTest
private class CircularDependencyClassATest {
    @isTest
    static void testClassA() {
        CircularDependencyClassA.methodA();
    }
}