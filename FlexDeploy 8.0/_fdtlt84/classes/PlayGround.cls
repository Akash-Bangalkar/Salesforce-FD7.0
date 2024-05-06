public class PlayGround {
    public static void printList()
    {
        // Create an array to hold Group objects
        Group[] groupList = new List<Group>();
        
        // Create 1000 groups
        for(Integer i = 1000; i < 1999; i++) {
            // Create a Group for each queue
            Group newGroup = new Group();
            newGroup.Name = 'FlexDeploy_' + i;
            groupList.add(newGroup);
        }
        
        Insert groupList;
    }
}