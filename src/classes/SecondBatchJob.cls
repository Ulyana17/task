global with sharing class SecondBatchJob implements Database.Batchable<Contact>{
    public Iterable<Contact> start(Database.BatchableContext info){
        return new CustomIterable();
    }
    global void execute(Database.BatchableContext info, List<Contact> listContact){
        for(Contact contact : listContact)
        {
            contact.Is_Synced__c = true;
            contact.MailingAddress = contact.Account.BillingAddress;
        }
        try {
            update listContact;
        } catch(DmlException e)
        {
            System.debug('list does not update!');
        }
    }
    public void finish(Database.BatchableContext info){
    }
}