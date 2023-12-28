trigger OppTrigger on Opportunity (before update) {
	if(trigger.isBefore)
    {
        if(trigger.isUpdate)
        {
            OpportunityNextStep.updateNextStep(trigger.new, trigger.oldMap);
        }
    }
}