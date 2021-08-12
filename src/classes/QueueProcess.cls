public with sharing class QueueProcess implements Queueable{

    private List<Contact> listContacts;

    public QueueProcess(List<Contact> listContacts){
        this.listContacts = listContacts;
    }

    public void execute(QueueableContext QB) {
        List<Contact> listToUpdate = new List<Contact>();
        for(Contact contact : listContacts)
        {
            contact.Is_Synced__c = false;
            contact.Processed_By_Future__c = true;
            listToUpdate.add(contact);
            System.debug('Queueble Job!');
        }
        System.debug(listToUpdate);
        update listToUpdate;
    }
}