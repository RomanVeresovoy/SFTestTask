public inherited sharing class UtilTrigger {
    public static Map<Schema.SObjectField, List<SObject>> mapByUpdatedField(Map<Id, SObject> newSObjectById , Map<Id, SObject> oldSObjectById ) {
        SObjectType sobjectType = newSObjectById.values().get(0).getSObjectType();
        Map<String, Schema.SObjectField> sobjectsFields = sobjectType.getDescribe().fields.getMap();
        Map<Schema.SObjectField, List<SObject>> sobjectsByUpdateFields = new Map<Schema.SObjectField, List<SObject>>();

        for (Id recordId : newSObjectById.keySet()) {
            SObject newSObject = newSObjectById.get(recordId);
            SObject oldSObject = oldSObjectById.get(recordId);

            for (Schema.SObjectField field : sobjectsFields.values()) {

                if (!sobjectsByUpdateFields.containsKey(field)) {
                    sobjectsByUpdateFields.put(field, new SObject[]{});
                }

                if (newSObject.get(field) != oldSObject.get(field)) {
                    sobjectsByUpdateFields.get(field).add(newSObject);
                }
            }
        }

        return sobjectsByUpdateFields;
    }
}