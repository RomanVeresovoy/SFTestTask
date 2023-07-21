@IsTest
private class DisplayTextControllerTest {
    private static final String TEST_TEXT = 'We laugh and play\n' + 'And sing\n' + 'All day';
    private static final List<String> EXPECTED_TEXT = new List<String>{'We laugh and play', 'And sing', 'All day'};
    private static final String ERROR_MESSAGE = 'Text was sorted incorrectly';

    @IsTest
    private static void getDataTest() {
        Test.startTest();
        List<DisplayTextController.TextWrapper> data = DisplayTextController.sortStrings(TEST_TEXT);
        Test.stopTest();

        Assert.areEqual(EXPECTED_TEXT.get(0), data.get(0).stringValue, ERROR_MESSAGE);
        Assert.areEqual(EXPECTED_TEXT.get(1), data.get(1).stringValue, ERROR_MESSAGE);
        Assert.areEqual(EXPECTED_TEXT.get(2), data.get(2).stringValue, ERROR_MESSAGE);
    }
}