public class InvoiceController {
	public static void SummaryMonthSelection(List<Invoice__c> invList, Map<ID, Invoice__c> oldMap)
    {
        Date invoiceDate;
        Boolean dateChange = FALSE;
        for(Invoice__c inv:invList)
        {
            if(inv.Invoice_Date__c != NULL && oldMap == NULL)
            {
                invoiceDate = inv.Invoice_Date__c;
                dateChange = TRUE;
            }
            else if(inv.Invoice_Date__c != NULL & inv.Invoice_Date__c != oldMap.get(inv.Id).Invoice_Date__c)
            {
                invoiceDate = inv.Invoice_Date__c;
                dateChange = TRUE;
            }
        }
        
        if(dateChange == TRUE)
        {
            List<ID> sumID = New List<ID>();
            
            List<Summary__c> summaryList = [SELECT ID, Start_Date__c, End_Date__c FROM Summary__c];
            for(Summary__c sum:summaryList)
            {
                if(invoiceDate >= sum.Start_Date__c && invoiceDate <= sum.End_Date__c)
                {
                    sumID.add(sum.Id);
                    BREAK;
                }
            }
            
            for(Invoice__c inv:invList)
            {
                if(sumID.size()>0)
                {
                    inv.Summary_Month__c = sumID[0];
                }
                else
                {
                    inv.Summary_Month__c.addError('Month Not Found');
                }
            }
        }
    }
}