public class getMetadataTypes {
	public List<String> getMetadataTypes() {
    List<String> metadataTypes = new List<String>();

    // Use Schema.describeSObjects() to get metadata types
    Schema.DescribeSObjectResult[] results = Schema.describeSObjects(new List<String>{'ApexClass', 'ApexTrigger', 'CustomObject' /* Add more as needed */});

    for (Schema.DescribeSObjectResult result : results) {
        String objectType = result.getName();
        metadataTypes.add(objectType);
    }

    return metadataTypes;
}
}