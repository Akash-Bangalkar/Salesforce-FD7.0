public class PlayGround {
    public static void printList()
    {
        List<Case> intList = [SELECT FIELDS(STANDARD) FROM Case];
        System.debug(intList.size());
    }
}