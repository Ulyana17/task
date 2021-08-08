trigger ShopTrigger on Shop__c (before insert) {
    if(Trigger.isBefore && Trigger.isInsert)
    {
        ShopTriggerHandler.HandleBeforeInsert(Trigger.new);
    }
}