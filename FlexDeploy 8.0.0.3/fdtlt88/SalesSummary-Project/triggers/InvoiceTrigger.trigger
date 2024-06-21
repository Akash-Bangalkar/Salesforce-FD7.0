trigger InvoiceTrigger on Invoice__c (before insert, before update) {
	if(trigger.isBefore)
    {
        if(trigger.isInsert)
        {
            InvoiceController.SummaryMonthSelection(trigger.new, trigger.oldMap);
        }
        else if(trigger.isUpdate)
        {
            InvoiceController.SummaryMonthSelection(trigger.new, trigger.oldMap);
        }
    }
}