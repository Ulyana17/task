global with sharing class AccountTriggerHandler {

    @Future
    global static void createAccount(List<Id> newAcc){
        List<Task> listTask = new List<Task>();
        List<Account> listAccount = [SELECT Id, Name FROM Account WHERE Id IN : newAcc];
        for(Account acc : listAccount) {
            Task task = new Task();
            task.Subject = 'Negotiations with ' + acc.Name;
            task.WhatId = acc.Id;
            task.IsSynced__c = false;
            listTask.add(task);
        }
        insert listTask;
    }

}