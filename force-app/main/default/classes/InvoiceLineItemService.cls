public without sharing class InvoiceLineItemService {

    private Map<Schema.SObjectField, InvoiceLineItem__c[]> updatedFieldToInvoiceLineItems {
        get {
            if (updatedFieldToInvoiceLineItems == null) {
                updatedFieldToInvoiceLineItems = UtilTrigger.mapByUpdatedField(
                        (Map<Id, InvoiceLineItem__c>) Trigger.newMap,
                        (Map<Id, InvoiceLineItem__c>) Trigger.oldMap
                );
            }

            return updatedFieldToInvoiceLineItems;
        }
        private set;
    }

    public void updateInvoices(List<InvoiceLineItem__c> invoiceLineItems) {
        Set<Id> invoiceIds = new Set<Id>();

        for (InvoiceLineItem__c invoiceLineItem : invoiceLineItems) {
            if (invoiceLineItem.Invoice__c != null) {
                invoiceIds.add(invoiceLineItem.Invoice__c);
            }
        }

        update calculateAmountOfLineItems(invoiceIds);
    }

    public void updateInvoicesAfterUpdate(Map<Id, InvoiceLineItem__c> oldInvoiceLineItemsMap) {
        List<InvoiceLineItem__c> invoiceLineItemsWithChangedInvoice = updatedFieldToInvoiceLineItems.get(InvoiceLineItem__c.Invoice__c);

        if (invoiceLineItemsWithChangedInvoice.isEmpty()) return;

        Set<Id> invoiceIds = new Set<Id>();

        for (InvoiceLineItem__c invoiceLineItem : invoiceLineItemsWithChangedInvoice) {
            invoiceIds.add(invoiceLineItem.Invoice__c);
            invoiceIds.add(oldInvoiceLineItemsMap.get(invoiceLineItem.Id).Invoice__c);
        }

        update calculateAmountOfLineItems(invoiceIds);
    }

    private List<Invoice__c> calculateAmountOfLineItems(Set<Id> invoiceIds) {
        if (invoiceIds == null && invoiceIds.isEmpty()) return null;

        List<Invoice__c> invoices = getInvoices(invoiceIds);

        for (Invoice__c invoice : invoices) {
            invoice.AmountOfLineItems__c = invoice.InvoiceLineItems__r.size();
        }

        return invoices;
    }

    private List<Invoice__c> getInvoices (Set<Id> invoiceIds) {
        return [
            SELECT Id, AmountOfLineItems__c, (SELECT Id FROM InvoiceLineItems__r)
            FROM Invoice__c
            WHERE Id IN :invoiceIds
        ];
    }
}