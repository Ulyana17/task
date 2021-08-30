@isTest
private with sharing class TestBatchs {

    @IsTest
    static void test()
    {
        List<Task> tasks = [SELECT Id, Account_Owner__c FROM Task WHERE IsSynced__c = FALSE];
        Test.startTest();
        FirstBatchJob fbj = new FirstBatchJob();
        Id batchJob = Database.executeBatch(fbj);
        Test.stopTest();
        System.assertEquals(0, [SELECT COUNT() FROM Task WHERE IsSynced__c = FALSE]);
        for(Task task : tasks)
        {
            System.assertEquals(null, task.Account_Owner__c, 'The account owner name is null');
        }

    }

    @IsTest
    static void testForSecondBatch()
    {
        Test.startTest();
        SecondBatchJob sbj = new SecondBatchJob();
        Id batchJob = Database.executeBatch(sbj);
        Test.stopTest();

    }
}