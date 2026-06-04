public class LeadTriggerHandler {
    public static void handleActivityAfterCreate(List<Lead> leadRecord){
        List<Task> newTaskToInsert = new List<Task>();
        
        for(Lead leadRec: leadRecord){
            Task taskRecord = new Task();
            taskRecord.OwnerId = leadRec.OwnerId;
            taskRecord.WhoId = leadRec.Id;
            taskRecord.Subject = 'Follow up';
            taskRecord.Status = 'Not Started';
            newTaskToInsert.add(taskRecord);
        }
        
        if(!newTaskToInsert.isEmpty()){
            insert newTaskToInsert;
        }
    }
    
    public static void handleActivityBeforeDelete(List<Lead> leadRecord){
        for(Lead l:leadRecord){
            if(l.Status == 'Working-Contacted'){
                l.addError('You are not Allowed to Delete working contacted lead.');
            }
        }
    }

    public static void handleAfterInsert(List<Lead> newLeadRec){
        List<Id> leadIds = new List<Id>();
        for(Lead l:newLeadRec){
            leadIds.add(l.Id);
        }
        syncApiData(leadIds);
    }

    // calling the future methods to
    // update the Lead's Description field with the 
    // user's company name and email from the API response.
    @Future(Callout=true)
    public static void syncApiData(List<Id> leadIds){
        List<Lead> leadRec = [SELECT Id,Name, Description FROM Lead WHERE Id IN: leadIds];
        List<Lead> leadToUpdate = new List<Lead>();

        for(Lead l:leadRec){

            // build the Http req Method
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://jsonplaceholder.typicode.com/users/1');
            req.setMethod('GET');
            req.setHeader('Content-Type', 'application/json');

            // Instantiate a new Http object
            Http h = new Http();
            HttpResponse res = h.send(req);

            if(res.getStatusCode() == 200){
                Map<String, Object> userData = 
                    (Map<String, Object>) JSON.deserializeUntyped(res.getBody());

                String name  = (String) userData.get('name');
                String email = (String) userData.get('email');

                // 'company' is a nested object inside the response
                Map<String, Object> company = 
                    (Map<String, Object>) userData.get('company');
                String companyName = (String) company.get('name');

                l.Description = 'From Api' 
                                + 'User: ' + name
                                + ' | Email: ' + email
                                + ' | Company: ' + companyName;
                leadToUpdate.add(l);
            }else{
                System.debug('API call failed. Status: ' + res.getStatusCode());
            }

        }

        if(!leadToUpdate.isEmpty()){
            update leadToUpdate;
        }
    }
    
}