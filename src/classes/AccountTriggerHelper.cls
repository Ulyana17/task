global with sharing class AccountTriggerHelper {

    private static List<Id> accIds = new List<Id>();

    global static List<Id> beforeInsertAccount(Map<Id, Account> newAcc){
        for(Account acc : newAcc.values())
        {
            accIds.add(acc.Id);
        }
        AccountTriggerHandler.createAccount(accIds);
        return accIds;
    }

    global static List<Id> beforeUpdateMethod(Map<Id, Account> oldAcc, Map<Id, Account> newAcc){
        for(Account acc : newAcc.values())
        {
            if(acc.BillingCity != oldAcc.get(acc.Id).BillingCity ||
                    acc.BillingStreet != oldAcc.get(acc.Id).BillingStreet ||
                    acc.BillingState != oldAcc.get(acc.Id).BillingState ||
                    acc.BillingCountry != oldAcc.get(acc.Id).BillingCountry ||
                    acc.BillingGeocodeAccuracy != oldAcc.get(acc.Id).BillingGeocodeAccuracy ||
                    acc.BillingPostalCode != oldAcc.get(acc.Id).BillingPostalCode)
            {
                accIds.add(acc.Id);
            }
        }
        System.debug(accIds);
        AccountTriggerHandler.beforeUpdateMethod(accIds);
        return accIds;
    }
}