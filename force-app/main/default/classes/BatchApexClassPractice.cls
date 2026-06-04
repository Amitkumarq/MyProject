public with sharing class BatchApexClassPractice implements Database.Batchable<SObject>, Database.AllowsCallouts, Database.Stateful {
    public Integer count = 0;
    
    // Start Method used for querying the records
    public Database.QueryLocator start(Database.BatchableContext bc){
        System.debug('Start Method called');
        String baseQuery = 'SELECT Id, Name, StageName FROM Opportunity ';
        String filterQuery = 'WHERE StageName = \'Perception Analysis\' AND CloseDate < LAST_N_DAYS:7';
        String finalQuery = baseQuery + filterQuery;
        return Database.getQueryLocator(finalQuery);
    }
    
    // Execute Method used for processing the records in batches
    public void execute(Database.BatchableContext context, List<Opportunity> scope){
        //do all the hard work here
        for(Opportunity opp : scope){
            count++;
            System.debug(count);
        }
    }
    
    // Finish Method used for post processing logic after all batches are processed
    public void finish(Database.BatchableContext bc){
        //post processing logic here
        System.debug('Finish method called' + count);
    }
    
}