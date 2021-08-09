public with sharing class QueueProcess implements Queueable{
    public void execute(Queueable QB) {
        List<Contact> listContacts = [SELECT Id, Is_Synced__c, Processed_By_Queue__c FROM Contact];
        List<Contact> listToUpdate = new List<Contact>();
        for(Contact contact : listContacts)
        {
            contact.Is_Synced__c = false;
            contact.Processed_By_Future__c = true;
            listToUpdate.add(contact);
        }
        update listToUpdate;
    }
}