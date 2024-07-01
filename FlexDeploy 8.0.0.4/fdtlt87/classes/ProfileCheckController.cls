public with sharing class ProfileCheckController {
    @AuraEnabled(cacheable=true)
    public static Boolean hasAccess() {
        Id profileId = UserInfo.getProfileId();
        Profile profile = [SELECT Name FROM Profile WHERE Id = :profileId];
        // Check profile name
        if(profile.Name == 'System Administrator') {
            return true;
        } else {
            return false;
        }
    }
}