trigger OppTrigger on Opportunity (before update) {
	if(trigger.isBefore) //ISBEFORE
    {
        if(trigger.isUpdate) //ISUPDATE
        {
            OpportunityNextStep.updateNextStep(trigger.new, trigger.oldMap);
        }
    }
}