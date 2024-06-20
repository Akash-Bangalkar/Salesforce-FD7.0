trigger ConTrigger on Contact (before insert, before update, after update) {
	if(trigger.isBefore)
    {
		if(trigger.isInsert)
        {
            ContactRestrict.AccIDRestrict(trigger.new);
        }
    }
}