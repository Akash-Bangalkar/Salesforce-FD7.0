public class CircularDependencyClassA {
    private static Boolean isMethodBCalled = false;

    public static void methodA() {
        if (!isMethodBCalled) {
            isMethodBCalled = true;
            CircularDependencyClassB.methodB();
            System.debug('Method A');
            isMethodBCalled = false;
        }
    }
}