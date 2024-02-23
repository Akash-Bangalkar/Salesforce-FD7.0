trigger ContentVersionTrigger on ContentVersion (after update) {
    List<FileChangeLog__c> fileChanges = new List<FileChangeLog__c>();

    for (ContentVersion cv : Trigger.new) {
        ContentVersion oldCV = Trigger.oldMap.get(cv.Id);

        if (cv.Title != oldCV.Title) {
            FileChangeLog__c changeLog = new FileChangeLog__c(
                OldFileName__c = oldCV.Title,
                NewFileName__c = cv.Title,
                Timestamp__c = System.now(),
                User__c = UserInfo.getUserId()
            );

            fileChanges.add(changeLog);
        }
    }

    insert fileChanges;
}