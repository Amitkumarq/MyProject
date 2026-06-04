public class CreateAccountAndAssociateContacts {
    
    public static void AccCreation(){
        
        Account acc = new Account(
            Name = 'Test Account',
            Create_N_Contacts__c = 5
        );
        insert acc;
        
        List<Contact> conRecord = new List<Contact>();
        
        System.debug('my debug ' + acc.Create_N_Contacts__c);
        
        for(Integer i = 1; i <= acc.Create_N_Contacts__c; i++){
            
            Contact con = new Contact();
            con.FirstName = 'Contact';
            con.LastName = 'userX' + i;
            con.AccountId = acc.Id;  
            con.Email = 'userx' + i + '@gmail.com';
            con.Phone = '98765' + i;
            
            conRecord.add(con);           
        }
        
        insert conRecord;
    }

    public static void oppCreation(){
        Opportunity opp = new Opportunity();
        opp.Name = 'my test oppp';
        opp.StageName = 'prospecting';
        opp.CloseDate = System.today().addDays(10);
        insert opp;
    }
}