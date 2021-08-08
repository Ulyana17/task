/**
 * Created by Мыша on 08.08.2021.
 */

trigger AccountTrigger on Account (before insert) {
    List<Id> listId = new List<Id>();
    if(Trigger.isBefore && Trigger.isInsert){
        AccountTriggerHandler.createAccount(listId);
    }
}