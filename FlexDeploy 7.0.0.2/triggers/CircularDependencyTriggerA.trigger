trigger CircularDependencyTriggerA on Account (before insert) {
    CircularDependencyClassA.methodA();
}