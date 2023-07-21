public with sharing class DisplayTextController {
    private static final String SEPARATOR = '\n';

    @AuraEnabled(Cacheable = true)
    public static List<TextWrapper> sortStrings(String text) {
        List<String> strings = text.split(SEPARATOR);
        List<TextWrapper> textWrappers = new List<TextWrapper>();

        for(String str : strings) {
            textWrappers.add(new TextWrapper(str));
        }

        textWrappers.sort();

        return textWrappers;
    }

    @TestVisible
    private class TextWrapper implements Comparable {
        @AuraEnabled
        public String stringValue;
        public Integer length;

        public TextWrapper(String stringValue) {
            this.stringValue = stringValue;
            this.length = stringValue.length();
        }

        public Integer compareTo(Object objToCompare) {
            TextWrapper textWrapper = (TextWrapper)objToCompare;

            if (length == textWrapper.length) {
                return 0;
            }
            else if (length < textWrapper.length) {
                return 1;
            }
            else {
                return -1;
            }
        }
    }
}