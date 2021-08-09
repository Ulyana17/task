global with sharing class UpdateAccountProcess {
    @InvocableMethod(label = 'Assign Tasks')
    global static void AssignTasks(List<Id> accIds)
    {
        List<Task> listTask = [SELECT Id, WhatId FROM Task WHERE WhatId IN : accIds];
        List<Task> listToUpdate = new List<Task>();
        User listUsers = [SELECT Id FROM User WHERE Alias = 'suser'];
        if(listTask.size() >= 3)
        {
            for(Task task : listTask) {
                task.OwnerId = listUsers.Id;
                listToUpdate.add(task);
            }
        }
        try {
            update listToUpdate;
        } catch(DmlException e)
        {
            System.debug('list does not update!');
        }
    }
}