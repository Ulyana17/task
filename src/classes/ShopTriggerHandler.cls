global with sharing class ShopTriggerHandler {
    private static Boolean check = true;

    global static void HandleBeforeInsert(List<Shop__c> newShop){
        if(check)
        {
            
            check = false;
        }
    }
}