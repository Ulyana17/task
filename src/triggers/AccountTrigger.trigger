/**
 * Created by Мыша on 08.08.2021.
 */

trigger AccountTrigger on Account (before insert) {
    List<Id> ids = new List<Id>();
    for(Account acc : Trigger.new){
        ids.add(acc.Id);
    }
    if(Trigger.isBefore && Trigger.isInsert){
        AccountTriggerHandler.createAccount(ids);
    }
}