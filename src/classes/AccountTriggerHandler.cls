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

    @Future
    global static void beforeUpdateMethod(List<Id> newAcc){
        System.debug('future method!');
        System.debug(newAcc);
        List<Contact> listContacts = [SELECT Id, Is_Synced__c, Processed_By_Future__c FROM Contact WHERE AccountId IN : newAcc];
        System.debug(listContacts);
        System.enqueueJob(new QueueProcess(listContacts));
        for(Contact contact : listContacts)
        {
            contact.Is_Synced__c = false;
            contact.Processed_By_Future__c = true;
        }
        System.debug(listContacts);
        update listContacts;
    }

}