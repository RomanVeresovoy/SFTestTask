@IsTest
private class InvoiceLineItemServiceTest {
    private static final Integer NUMBER_OF_RECORDS = 200;
    private static final String NAME_OF_INVOICE = 'Test Invoice';

    @TestSetup
    private static void setup() {
        Invoice__c invoice = createInvoice(NAME_OF_INVOICE);
        insert invoice;

    }

    @IsTest
    private static void updateInvoicesAfterInsertTest() {
        Invoice__c invoice = getInvoice();

        Test.startTest();
        insert createInvoiceLineItems(invoice.Id);
        Test.stopTest();

        invoice = getInvoice();

        System.assertEquals(NUMBER_OF_RECORDS, invoice.AmountOfLineItems__c, 'The amount was calculated incorrectly after insertion records');
    }

    @IsTest
    private static void updateInvoicesAfterDeleteTest() {
        Invoice__c invoice = getInvoice();
        insert createInvoiceLineItems(invoice.Id);

        List<InvoiceLineItem__c> invoiceLineItems = getInvoiceLineItems();

        Test.startTest();
        delete invoiceLineItems;
        Test.stopTest();

        invoice = getInvoice();

        System.assertEquals(0, invoice.AmountOfLineItems__c, 'The amount was calculated incorrectly after deletion records');
    }

    @IsTest
    private static void updateInvoicesAfterUpdateTest() {
        Invoice__c invoice = getInvoice();
        insert createInvoiceLineItems(invoice.Id);

        List<InvoiceLineItem__c> invoiceLineItems = getInvoiceLineItems();

        for(InvoiceLineItem__c invoiceLineItem : invoiceLineItems) {
            invoiceLineItem.Invoice__c = null;
        }

        Test.startTest();
        update invoiceLineItems;
        Test.stopTest();

        invoice = getInvoice();

        System.assertEquals(0, invoice.AmountOfLineItems__c, 'The amount was calculated incorrectly after deletion records');
    }

    private static Invoice__c createInvoice(String name) {
        return new Invoice__c(
            Name = name
        );
    }

    private static InvoiceLineItem__c createInvoiceLineItem(String name, Id invoiceId) {
        return new InvoiceLineItem__c(
            Name = name,
            Invoice__c = invoiceId
        );
    }

    private static List<InvoiceLineItem__c> createInvoiceLineItems(Id invoiceId) {
        List<InvoiceLineItem__c> invoiceLineItems = new List<InvoiceLineItem__c>();

        for(Integer i = 0; i < NUMBER_OF_RECORDS; i++) {
            invoiceLineItems.add(createInvoiceLineItem('Test' + i, invoiceId));
        }

        return invoiceLineItems;
    }

    private static Invoice__c getInvoice() {
        return [SELECT Id, AmountOfLineItems__c FROM Invoice__c LIMIT 1];
    }

    private static List<InvoiceLineItem__c> getInvoiceLineItems() {
        return [SELECT Id, Invoice__c FROM InvoiceLineItem__c];
    }
}