trigger ContactTrigger on Contact (before insert, before update) {
	if(trigger.isBefore)
    {
        if(trigger.isInsert)
        {
            DuplicateCustomer.checkDuplicateEmail(trigger.new, trigger.oldMap);
        }
        else if(trigger.isUpdate)
        {
            DuplicateCustomer.checkDuplicateEmail(trigger.new, trigger.oldMap);
        }
    }
}