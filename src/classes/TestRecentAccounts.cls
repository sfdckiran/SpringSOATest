@isTest
public class TestRecentAccounts {
	
    @isTest
    static void testGetAccounts(){
        Account account = new Account(Name='Test',AccountNumber='12345',Industry='Banking');
        insert account;
        Test.startTest();
        RecentAccounts.getAccounts();
        Test.stopTest();
    }
}