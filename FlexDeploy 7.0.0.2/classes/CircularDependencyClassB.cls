public class CircularDependencyClassB {
    private static Boolean isMethodACalled = false;

    public static void methodB() {
        if (!isMethodACalled) {
            isMethodACalled = true;
            CircularDependencyClassC.methodC();
            System.debug('Method B');
            isMethodACalled = false;
        }
    }
}