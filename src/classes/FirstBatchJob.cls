public with sharing class FirstBatchJob implements Database.Batchable<Task>{
    public Integer NumOfBatch = 0;
    private final String query = 'SELECT Id, IsSynced__c, Account_Owner__c FROM Task WHERE IsSynced__c = FALSE';

    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }

    public void execute(Database.BatchableContext BC, List<Task> listTask){
        for(Task task : listTask)
        {
            task.IsSynced__c = true;
            task.Account_Owner__c = task.Account.Owner.Name;
        }
        try {
            update listTask;
        } catch(DmlException e)
        {
            System.debug('list does not update!');
        }
        NumOfBatch++;
    }

    public void finish(Database.BatchableContext BC){
    }
}