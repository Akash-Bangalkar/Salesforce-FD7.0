trigger AccTrigger on Account (before insert) {
	if(trigger.isBefore)
    {
        if(trigger.isInsert)
        {
            AccountRatingSite.setTickerSymbol(trigger.new);
        }
    }
}