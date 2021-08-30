@IsTest
public with sharing class TestDataFactory {

    public static TestAccountFactory ACCOUNT = new TestAccountFactory();
    public static TestTaskFactory TASK = new TestTaskFactory();
    public static TestContactFactory CONTACT = new TestContactFactory();


    public with sharing class TestAccountFactory
    {
        public Account createDummyAccount(String name, Boolean needInsert)
        {
            Account account = new Account(
                    Name = name
            );
            if (needInsert)
                insert account;
            return account;
        }

        public List<Account> createDummyListOfAccounts(Integer count, String name, Boolean needInsert)
        {
            List<Account> accounts = new List<Account>();
            for(Integer i = 0; i <= count; i++)
            {
                accounts.add(createDummyAccount(name, false));
            }
            if (needInsert)
                insert accounts;
            return accounts;
        }

        public Map<Id, Account> createDummyMapOfAccounts(Integer count, String billingStreet, String name)
        {
            Map<Id, Account> accounts = new Map<Id, Account>();
            Account acc = new Account();
            for(Integer i = 0; i <= count; i++)
            {
                acc = createDummyAccount(name, false);
                acc.BillingStreet = billingStreet;
                accounts.put(acc.Id, acc);
            }
            return accounts;
        }

        public List<Id> getIds(List<Account> accs)
        {
            List<Id> accIds = new List<Id>();
            for(Account acc : accs)
            {
                accIds.add(acc.Id);
            }
            return accIds;
        }
    }

    public with sharing class TestTaskFactory
    {
        public Task createDummyTask(String subject, String whatId, Boolean isSynced, Boolean needInsert)
        {
            Task task = new Task(
                    Subject = subject,
                    WhatId = whatId,
                    IsSynced__c = isSynced
            );
            if (needInsert)
                insert task;
            return task;
        }

        public List<Task> createDummyListOfTasks(Integer count, String subject, String whatId, Boolean isSynced, Boolean needInsert)
        {
            List<Task> tasks = new List<Task>();
            for(Integer i = 0; i <= count; i++)
            {
                tasks.add(createDummyTask(subject, whatId, isSynced, false));
            }
            if (needInsert)
                insert tasks;
            return tasks;
        }
    }

    public with sharing class TestContactFactory
    {
        public Contact createDummyContact(Boolean processedByFuture, Boolean isSynced, Boolean needInsert)
        {
            Contact contact = new Contact(
                    Processed_By_Future__c = processedByFuture,
                    Is_Synced__c = isSynced
            );
            if (needInsert)
                insert contact;
            return contact;
        }

        public List<Contact> createDummyListOfContact(Integer count, Boolean processedByFuture, Boolean isSynced, Boolean needInsert)
        {
            List<Contact> contacts = new List<Contact>();
            for(Integer i = 0; i <= count; i++)
            {
                contacts.add(createDummyContact(processedByFuture, isSynced, false));
            }
            if (needInsert)
                insert contacts;
            return contacts;
        }
    }

}