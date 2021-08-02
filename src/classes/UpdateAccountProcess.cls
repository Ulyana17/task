global with sharing class UpdateAccountProcess {
    @InvocableMethod(label = 'Assign Tasks')
    global static void AssignTasks(List<Id> accIds)
    {
        List<Task> listTask = [SELECT Id, WhatId FROM Task WHERE WhatId IN : accIds];
        List<User> listUsers = [SELECT Id FROM User WHERE Alias = 'uyanu'];
        if(listTask.size() >= 3)
        {
            for(Task task : listTask) {
                task.OwnerId = listUsers.iterator().next().Id;
            }
        }

    }
}