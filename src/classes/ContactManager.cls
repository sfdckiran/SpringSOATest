/*
 * Class that holds logic for contactTrigger
 */

public class ContactManager {
	
    public static void handleInsert(List<Contact> newContacts){
        Set<ID> accountIdsInScope = new Set<ID>();
    	Map<ID,Account> accountsInScope = new Map<ID,Account>();
    	Map<ID,Account> accountsMapToUpdate = new Map<ID,Account>();
    	
        for(Contact c : newContacts){
        	accountIdsInScope.add(c.AccountId);
    	}
    	
        for(Account account : [SELECT ID,Number_of_Contacts__c FROM Account WHERE ID IN :accountIdsInScope]){
        	accountsInScope.put(account.Id,account);
    	}
    	
        for(Contact c:newContacts){
        	Account account = accountsInScope.get(c.AccountId);
            if(account != null){
                account.Number_of_Contacts__c += 1;
        		accountsMapToUpdate.put(c.AccountId,account);
            }
        }
    	
        if(!accountsMapToUpdate.values().isEmpty()){
        	UPDATE accountsMapToUpdate.values();
     	}
    }
    
    public static void handleUpdate(List<Contact> newContacts,Map<ID,Contact> oldContacts){
        Set<ID> accountsId = new Set<ID>();
        Map<ID,Account> accountsInScope = new Map<ID,Account>();
    	Map<ID,Account> accountsMapToUpdate = new Map<ID,Account>();
        
        for(Contact contact : newContacts){
            if(contact.AccountId != oldContacts.get(contact.Id).AccountId){
                accountsId.add(contact.AccountId);
                accountsId.add(oldContacts.get(contact.Id).AccountId);
            }
        }
        
        for(Account account : [SELECT ID,Number_of_Contacts__c FROM Account WHERE ID IN : accountsId]){
            accountsInScope.put(account.Id,account);
        }
        
        for(Contact contact : newContacts){
            Account Oldaccount = accountsInScope.get(oldContacts.get(contact.Id).AccountId);
            Account newAccount = accountsInScope.get(contact.AccountId);
            if(Oldaccount != null && newAccount!=null){
                Oldaccount.Number_of_Contacts__c -= 1;
            	accountsMapToUpdate.put(Oldaccount.Id,Oldaccount);
            }
            
            if(newAccount!=null){
                newAccount.Number_of_Contacts__c += 1;
                accountsMapToUpdate.put(newAccount.Id,newAccount);
            }
        }
        
        if(!accountsMapToUpdate.values().isEmpty()){
            UPDATE accountsMapToUpdate.values();
        }
    }
    
    public static void handleDelete(List<Contact> contacts){
        Set<ID> accountsId = new Set<ID>();
        Map<ID,Account> accountsInScope = new Map<ID,Account>();
    	Map<ID,Account> accountsMapToUpdate = new Map<ID,Account>();
        
        for(contact c : contacts){
            accountsId.add(c.AccountId);
        }
        
        for(Account account : [SELECT ID,Number_of_Contacts__c FROM Account WHERE ID IN :accountsId]){
        	accountsInScope.put(account.Id,account);
    	}
        
        for(Contact c:contacts){
        	Account account = accountsInScope.get(c.AccountId);
        	if(account != null){
              account.Number_of_Contacts__c -= 1;
        		accountsMapToUpdate.put(c.AccountId,account);
    
        	}
      }
     
      if(!accountsMapToUpdate.values().isEmpty()){
        UPDATE accountsMapToUpdate.values();
     }
    }
    
    public static void handleUndelete(List<Contact> contacts){
        Set<ID> accountIdsInScope = new Set<ID>();
    	Map<ID,Account> accountsInScope = new Map<ID,Account>();
    	Map<ID,Account> accountsMapToUpdate = new Map<ID,Account>();
    	
        for(Contact c : contacts){
        	accountIdsInScope.add(c.AccountId);
    	}
    	
        for(Account account : [SELECT ID,Number_of_Contacts__c FROM Account WHERE ID IN :accountIdsInScope]){
        	accountsInScope.put(account.Id,account);
    	}
        
        for(Contact c:contacts){
        	Account account = accountsInScope.get(c.AccountId);
        	if(account !=null){
            	account.Number_of_Contacts__c += 1;
        		accountsMapToUpdate.put(c.AccountId,account);
        	}
        
    	}
    	
        if(!accountsMapToUpdate.values().isEmpty()){
        	UPDATE accountsMapToUpdate.values();
     	}
    }
}