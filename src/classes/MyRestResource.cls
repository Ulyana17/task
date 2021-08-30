@RestResource(UrlMapping = '/Account/*')
global with sharing class MyRestResource {
    @HttpGet
    global static Account getAccount(){
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name FROM Account WHERE Id = : accountId];
        return result;
    }

    @HttpPost
    global static Id createAccount(String name){
        Account account = new Account(
                Name = name
        );
        insert account;
        return account.Id;
    }

    @HttpDelete
    global static void deleteAccount(){
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name FROM Account WHERE Id = : accountId];
        delete result;
    }

    @HttpPut
    global static Id upsertAccount(String name){
        Account account = new Account(
                Name = name
        );
        upsert account;
        return account.Id;
    }

    @HttpPatch
    global static Id updateAccount(){
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        Account account = [SELECT Id, Name FROM Account WHERE Id = : accountId];
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestBody.toString());
        for(String fieldName : params.keySet())
        {
            account.put(fieldName, params.get(fieldName));
        }
        update account;
        return account.Id;
    }
}