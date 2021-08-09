trigger AccountTrigger on Account (before insert, before update) {
    List<Id> ids = new List<Id>();
    if(Trigger.isBefore) {
        if (Trigger.isInsert) {
            for(Account acc : Trigger.new){
                ids.add(acc.Id);
            }
            AccountTriggerHandler.createAccount(ids);
        }
        if (Trigger.isUpdate) {
            for(Account acc : Trigger.new){
                if(acc.BillingAddress != trigger.oldMap.get(acc.Id).BillingAddress)
                    ids.add(acc.Id);
            }
            AccountTriggerHandler.beforeUpdateMethod(ids);
        }
    }
}