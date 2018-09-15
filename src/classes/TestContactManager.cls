@isTest
public class TestContactManager {
	static Integer numberOfItems = 5;
    
    @testSetup
    static void prepareDataAndInsert(){
        List<Account> accounts = new List<Account>();
        
        for(Integer i=1;i<=numberOfItems;i++){
            Account account = new Account(Name = 'Test Account'+i);
            accounts.add(account);
        }
        
        insert accounts;
        List<Contact> contacts = new List<Contact>();
        	ID accountId = [SELECT ID FROM Account LIMIT 1].Id;
            
            for(Integer i=1;i<=numberOfItems;i++){
            Contact Contact = new Contact(LastName = 'Test Contact'+i,AccountId = accountId);
            contacts.add(Contact);
        }
        
        INSERT contacts;
        system.assertEquals(5, contacts.size());
    }
    
    @isTest
    static void testUpdate(){
        List<Account> accountId = [SELECT ID FROM Account];
        List<Contact> contactsToUpdate = new List<Contact>();
        
        for(Contact contact : [Select ID,AccountId FROM Contact]){
            contact.AccountId = accountId.get(4).Id;
            contactsToupdate.add(contact);
        }
        UPDATE contactsToupdate;
    }
    
    @isTest
    static void testDeleteAndUndelete(){
        List<Contact> contactsToDelete = new List<Contact>();
        
        for(Contact contact : [Select ID FROM Contact]){
            contactsToDelete.add(contact);
        }
        DELETE contactsToDelete;
        
        List<Contact> contactsToUnDelete = new List<Contact>();
        
        for(Contact contact : [Select ID FROM Contact WHERE IsDeleted = true ALL ROWS]){
            contactsToUnDelete.add(contact);
        }
        UNDELETE contactsToUnDelete;
        system.assertEquals(5, contactsToUnDelete.size());
    }
}