global with sharing class NewAccountProcess {

    @InvocableMethod(label = 'Create Task')
    global static void NewTask(List<String> accName){
        List<Task> listTask = new List<Task>();
        List<Account> listAcc = [SELECT Id, Name FROM Account WHERE Name IN : accName];
        for(String name : accName) {
            Task task = new Task();
            task.Subject = 'Negotiations with ' + name;
            task.WhatId = listAcc.iterator().next().Id;
            listTask.add(task);
        }
        insert listTask;
    }
}