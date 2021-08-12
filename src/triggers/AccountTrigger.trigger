trigger AccountTrigger on Account (before insert, before update) {
    List<Id> ids = new List<Id>();
    if(Trigger.isBefore) {
        if (Trigger.isInsert) {
            AccountTriggerHelper.beforeInsertAccount(Trigger.newMap);
        }
        if (Trigger.isUpdate) {
            AccountTriggerHelper.beforeUpdateMethod(Trigger.oldMap, Trigger.newMap);
        }
    }
}