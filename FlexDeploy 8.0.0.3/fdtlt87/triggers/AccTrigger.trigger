trigger AccTrigger on Account (before insert) {
	if(trigger.isBefore)
    {
        if(trigger.isInsert)
        {
            AccountController.duplicateAccount(trigger.new);
        }
    }
}