public without sharing class InvoiceLineItemTriggerHandler extends TriggerHandler {
    InvoiceLineItemService invoiceLineItemService = new InvoiceLineItemService();

    public override void afterInsert() {
        invoiceLineItemService.updateInvoices(Trigger.new);
    }

    public override void afterDelete() {
        invoiceLineItemService.updateInvoices(Trigger.old);
    }

    public override void afterUndelete() {
        invoiceLineItemService.updateInvoices(Trigger.new);
    }

    public override void afterUpdate() {
        invoiceLineItemService.updateInvoicesAfterUpdate((Map<Id, InvoiceLineItem__c>) Trigger.oldMap);
    }
}