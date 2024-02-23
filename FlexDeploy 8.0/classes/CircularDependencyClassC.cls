public class CircularDependencyClassC {
    private static Boolean isMethodACalled = false;

    public static void methodC() {
        if (!isMethodACalled) {
            isMethodACalled = true;
            CircularDependencyClassA.methodA();
            System.debug('Method C');
            isMethodACalled = false;
        }
    }
}