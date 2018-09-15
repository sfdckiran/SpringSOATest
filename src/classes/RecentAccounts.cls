/*
 * Server side controller for RecentAccounts component
*/
public class RecentAccounts {

    public class AccountWrapper{
        @AuraEnabled
        public string message='';
        @AuraEnabled
        public List<Account> accountsList;
    }
    
    
    @AuraEnabled
    public static AccountWrapper getAccounts(){//To return newly created accounts
        AccountWrapper response = new AccountWrapper();
        response.accountsList = new List<Account>();
        try{
        for(Account account : [SELECT ID,Name,AccountNumber,AccountSource,Industry FROM Account ORDER BY CreatedDate DESC LIMIT 10]){
            response.accountsList.add(account);
        }
        }
        catch(Exception e){
            system.debug(e.getMessage());
            response.message = e.getMessage();
        }
        return response;
    }
}