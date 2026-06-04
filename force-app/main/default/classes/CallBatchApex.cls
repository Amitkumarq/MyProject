public with sharing class CallBatchApex implements Database.Batchable<SObject>, Database.AllowsCallouts, Database.Stateful {
    // private Integer count = 0;
    
    // // Start Method used for querying the records
    // public Database.QueryLocator start(Database.BatchableContext bc){
    //     System.debug('Start Method called');
    //     String baseQuery = 'SELECT Id, Name, StageName FROM Opportunity ';
    //     String filterQuery = 'WHERE StageName = \'Perception Analysis\' AND CloseDate < LAST_N_DAYS:7';
    //     String finalQuery = baseQuery + filterQuery;
    //     return Database.getQueryLocator(finalQuery);
    // }
    
    // // Execute Method used for processing the records in batches
    // public void execute(Database.BatchableContext context, List<Opportunity> scope){
    //     //do all the hard work here
    //     for(Opportunity opp : scope){
    //         count++;
    //         System.debug(count);
    //     }
    // }
    
    // // Finish Method used for post processing logic after all batches are processed
    // public void finish(Database.BatchableContext bc){
    //     //post processing logic here
    //     System.debug('Finish method called' + count);
    // }

    private Map<Id,String> accWebMap;
        // creating constructor to keep a copy of rec
    public CallBatchApex(Map<Id,String> accWebMap){
        this.accWebMap = accWebMap;
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([
            SELECT Id, Website__c, AccountId
            FROM Contact
            WHERE AccountId IN :accWebMap.keySet()
        ]);
    }

    public void execute(Database.BatchableContext bc, List<Contact> conList){
        List<Contact> contactsToUpdate = new List<Contact>();
        
        for (Contact con : conList) {
            if (accWebMap.containsKey(con.AccountId)) {
                con.Website__c = accWebMap.get(con.AccountId);
                contactsToUpdate.add(con);
            }
        }
        
        if (!contactsToUpdate.isEmpty()) {
            Database.update(contactsToUpdate, false); // false = partial success allowed
        }
    }

    public void finish(Database.BatchableContext bc) {
        AsyncApexJob job = [
            SELECT Id, Status, NumberOfErrors, TotalJobItems
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()
        ];
        System.debug('Batch finished. Status: ' + job.Status + 
                     ' | Errors: ' + job.NumberOfErrors + 
                     ' | Total Batches: ' + job.TotalJobItems);
    }
}