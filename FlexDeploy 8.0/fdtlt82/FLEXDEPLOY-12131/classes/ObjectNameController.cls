public with sharing class ObjectNameController {
    @AuraEnabled(cacheable=true)
    public static List<String> getObjectNames() {
        List<String> objectNames = new List<String>();

        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        for (String sObjName : gd.keySet()) {
            objectNames.add(sObjName);
        }

        objectNames.sort();
        
        return objectNames;
    }
}