public class SheetApexPractice {

    // Create an Account with 5 employees (NumberOfEmployees = 5), 
    // createand then  the same number of associated Contacts as the Account's NumberOfEmployees.
    
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

// Create an Opportunity record where the Close Date is set to 10 days after the Created Date.
    public static void oppCreation(){
        Opportunity opp = new Opportunity();
        opp.Name = 'my test oppp';
        opp.StageName = 'prospecting';
        opp.CloseDate = System.today().addDays(10);
        insert opp;
    }

// Update the Opportunity stage to 'Close Lost' for records where 
//the stage is 'Negotiation/Review' and the created date is more than 5 days ago.
    public static void updateOppStage(){
        List<Opportunity> myOppList = [SELECT Id, StageName FROM Opportunity WHERE StageName IN ('Negotiation','Review')];
        List<Opportunity> oppToUpdate = new List<Opportunity>();
        for(Opportunity opp:myOppList){
            opp.StageName = 'Closed Lost';
            oppToUpdate.add(opp);
        }
        
        if(!oppToUpdate.isEmpty()){
            update oppToUpdate;
        }
    }
    
//Write an Apex method that calculates the total Quantity of all OpportunityLineItem records associated with an Opportunity. 
//Store the result in a custom field Total_Product_Quantity__c on the Opportunity object.

    public static void totalQuantityOppLineItem(){
        // this map will store the oppId(lookup) and count of oppLineItem Quantity
        Map<Id,Integer> oppLineMap = new Map<Id,Integer>(); 
        for(AggregateResult ar:[SELECT OpportunityId oppId, SUM(quantity) totalQty FROM OpportunityLineItem GROUP BY OpportunityId]){
            oppLineMap.put((Id) ar.get('oppId'), Integer.valueOf(ar.get('totalQty')));
        }
        
        List<opportunity> oppToUpdate = new List<opportunity>();
        for(opportunity opp: [SELECT Id,Total_product_Quantity__c FROM Opportunity WHERE Id In: oppLineMap.keySet()]){
            opp.Total_Product_Quantity__c = oppLineMap.get(opp.Id);
            oppToUpdate.add(opp);
        }
        
        if(!oppToUpdate.isEmpty()){
            system.debug('opp updated');
            update oppToUpdate;
        }
    }
    
}