trigger InvoiceLineItemTrigger on InvoiceLineItem__c (after insert, after delete, after undelete, after update) {
    new InvoiceLineItemTriggerHandler().run();
}