public class BulkAccCreation {
    public static void accCreation(){
        
	List<Account> accList = new List<Account>();
    
    for(integer i=0; i<10;i++){
        Account acc = new Account();
        acc.name = 'Account' + i;
        acc.BillingStreet = 'Street ' + i+1;
    	acc.BillingCity = 'Delhi';
    	acc.BillingState = 'Delhi';
    	acc.BillingCountry = 'India';
    	acc.BillingPostalCode = '11000' + i+1;
        accList.add(acc);
    	}
        insert accList;
        system.debug('Account created:' + accList.size());
    }
    
}