@IsTest
private with sharing class TestAccountTrigger {

    @TestSetup
    static void Setup()
    {
        List<Account> accs = TestDataFactory.ACCOUNT.createDummyListOfAccounts(10, 'Test Account', false);
        Account acc = TestDataFactory.ACCOUNT.createDummyAccount('Test', false);
    }

    @IsTest
    static void TestInsertAccount()
    {
        Account acc = [SELECT Id, Name FROM Account WHERE Name = 'Test'];
        Task expectedTask = TestDataFactory.TASK.createDummyTask('Negotiations with ' + acc.Name, acc.Id, true, false);
        Test.startTest();
        insert acc;
        Test.stopTest();
        Task actualValue = [SELECT Subject, WhatId, IsSynced__c FROM Task WHERE WhatId = : acc.Id];
        System.assertEquals(expectedTask.Subject, actualValue.Subject);
        System.assertEquals(expectedTask.WhatId, actualValue.WhatId);
        System.assertEquals(expectedTask.IsSynced__c, actualValue.IsSynced__c);
    }

    @IsTest
    static void TestInsertListOfAccounts()
    {
        List<Account> accs = [SELECT Id, Name FROM Account WHERE Name = 'Test Account'];
        Test.startTest();
        insert accs;
        Test.stopTest();
        List<Id> accIds = TestDataFactory.ACCOUNT.getIds(accs);
        List<Task> actualValue = [SELECT Subject, WhatId, IsSynced__c FROM Task WHERE WhatId IN : accIds];
        for(Task value : actualValue)
        {
            System.assertEquals('Negotiations with ' + accs.iterator().next().Name, value.Subject);
            System.assertEquals(accs.iterator().next().Id, value.WhatId);
            System.assertEquals(true, value.IsSynced__c);
        }

    }


    @IsTest
    static void TestUpdateAccount()
    {
        Account acc = [SELECT Id, Name FROM Account WHERE Name = 'Test'];
        Contact expectedValue = TestDataFactory.CONTACT.createDummyContact(false, true, true);
        Test.startTest();
        acc.BillingStreet = 'Starovilenskaya';
        update acc;
        Test.stopTest();
        Contact actualValue = [SELECT Is_Synced__c, Processed_By_Future__c FROM Contact WHERE AccountId = : acc.Id];
        System.assertEquals(expectedValue.Processed_By_Future__c, actualValue.Processed_By_Future__c);
        System.assertEquals(expectedValue.Is_Synced__c, actualValue.Is_Synced__c);
    }

    @IsTest
    static void TestUpdateListOfAccounts()
    {

    }
}