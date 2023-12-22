trigger CircularDependencyTrigger on Account (before insert) {
    CircularDependencyClassA.methodA();
}