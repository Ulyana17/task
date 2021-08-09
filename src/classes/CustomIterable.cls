/**
 * Created by Мыша on 09.08.2021.
 */

public with sharing class CustomIterable implements Iterable<Contact>{
    public Iterator<Contact> iterator(){
        List<Contact> listContact = [SELECT Id, Is_Synced__c, MailingAddress FROM Contact WHERE Is_Synced__c = FALSE];
        return new CustomIterator(listContact);
    }
}