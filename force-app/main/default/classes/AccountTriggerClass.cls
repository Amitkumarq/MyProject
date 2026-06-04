public class AccountTriggerClass {
    
    public static void createRelatedConOpp(List<Account> newAccRecord){
        List<Contact> conToInsert = new List<Contact>();
        List<Opportunity> oppToInsert = new List<Opportunity>();
        
        for(Account acc:newAccRecord){
            if(acc.Account_Type__c == 'Gold'){
                Contact con = new Contact();
                con.LastName = 'Akc';
                con.AccountId = acc.Id;
                
                conToInsert.add(con);
            }else{
                Opportunity opp = new Opportunity();
                opp.AccountId = acc.Id;
                opp.Name = acc.Name + 'x';
                opp.CloseDate = Date.Today();
                opp.StageName = 'Prospecting';
                
                oppToInsert.add(opp);
            }
        }
        
        if(!conToInsert.isEmpty()){
            insert conToInsert;
        }
        
        if(!oppToInsert.isEmpty()){
            insert oppToInsert;
        }
    }
    
    public static void accountToContactSync(List<Account> newAccRecord, Map<Id,Account> oldMap){
        // storing the ids of acc where phone field is changed.
        Map<Id,Account> accIdsMap = new Map<Id,Account>();
        for(Account acc:newAccRecord){
            if(acc.Phone != null){
                if(oldMap.get(acc.Id).Phone != acc.Phone){
                    accIdsMap.put(acc.Id,acc);
                }
            }
        }
        
        List<Contact> conList = [SELECT Id,AccountId, Phone FROM Contact WHERE AccountId IN: accIdsMap.keySet()];
        
        List<Contact> conToUpdate = new List<Contact>();
        // sync contacts where they are same in account as well as in related contact
        
        for(Contact con: conList){
            if(con.Phone == oldMap.get(con.AccountId).Phone){
                con.Phone = accIdsMap.get(con.AccountId).Phone;
                conToUpdate.add(con);
            }
        }

    //     List<Contact> contactList = new List<Contact>();
    //     List<Contact> conIds = [SELECT Id FROM Contact WHERE AccountId =: newAccRecord];
    //     for(Account acc:newAccRecord){
    //         if(acc.Create_N_Contacts__c != oldMap.get(acc.Id).Create_N_Contacts__c){
                
    //             for(Integer i=conIds.size() + 1; i<= (conIds.size() + acc.Create_N_Contacts__c);i++){
    //                 Contact con = new Contact();
    //                 con.AccountId = acc.Id;
    //                 con.firstName = 'Contact';
    //                 con.LastName = acc.Name +'k'+ ' ' + i;
    //                 contactList.add(con);
    //             }
    //         }
    //     }
        
        // if(!contactList.isEmpty()){
        //     insert contactList;
        // }

        if(!conToUpdate.isEmpty()){
            update conToUpdate;
        }
    }
    
    public static void handleAfterInsertActivities(List<Account> newAccRecord){
        for(Account acc:newAccRecord){
            if(acc.Create_N_Contacts__c != null){
                
                List<Contact> contactList = new List<Contact>();
                
                for(Integer i=1; i<= acc.Create_N_Contacts__c;i++){
                    Contact con = new Contact();
                    con.AccountId = acc.Id;
                    con.firstName = 'Contact';
                    con.LastName = acc.Name + ' ' + i;
                    contactList.add(con);
                }
                
                if(!contactList.isEmpty()){
                    insert contactList;
                }
            }
        }
    }
    
    public static void handleBeforeUpdateActivities(List<Account> newAccRecord, Map<Id,Account> oldMap){
        for(Account acc:newAccRecord){
            if(acc.Industry == 'Agriculture' && acc.Type == 'Prospect'){
                if(oldMap.get(acc.Id).OwnerShip != acc.Ownership && acc.Ownership == 'Private'){
                    acc.addError('You are not Allowed to update the Ownership');
                }
            }
        }
    }
    
    public static void handleAfterUpdateActivities(List<Account> newAccRecord, Map<Id,Account> oldMap){
        Map<Id,String> accWebMap = new Map<Id,String>();
        List<Id> accIds = new List<Id>();
        
        for(Account acc:newAccRecord){
            
            if(acc.Website != oldMap.get(acc.Id).Website && acc.Website != null){
                accIds.add(acc.Id);
                accWebMap.put(acc.Id,acc.Website);

            }
        }
        // calling async method from here.
        if(!accIds.isEmpty()){
            callAsyncApex(accIds);
        }
        
        if(!accWebMap.isEmpty()){
            // List <Contact> addConToUpdate = new List<Contact>();
            // List <Contact> conRecords = [select Id, firstName, website__c, AccountId FROM Contact Where AccountId In : accWebMap.keySet() ];
            // for(Contact con:conRecords){
            //     con.Website__c = accWebMap.get(con.AccountId);
            //     addConToUpdate.add(con);
            // }
            
            // if(!addConToUpdate.isEmpty()){
            //     update addConToUpdate;
            // }

            Id batchInstanceId = Database.executeBatch(new CallBatchApex(accWebMap),200);
            system.debug('batchInstaceId'+batchInstanceId);
        }

        
    }

    //Set OWD as Private for Account. Once an Account record is created, it should be automatically shared with any one user who belongs to Standard User profile.

    // public static void shareWithStandardUser(List<Account> newAccounts) {
    //     if (newAccounts == null || newAccounts.isEmpty()) {
    //         return;
    //     }
    //     List<Profile> profiles = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
    //     if (profiles.isEmpty()) {
    //         return;
    //     }
    //     List<User> targetUsers = [SELECT Id FROM User WHERE ProfileId = :profiles[0].Id AND IsActive = true  LIMIT 1];
    //     if (targetUsers.isEmpty()) {
    //         return;
    //     }
    //     Id targetUserId = targetUsers[0].Id;

    //     List<AccountShare> sharesToInsert = new List<AccountShare>();
    //     for (Account acc : newAccounts) {
    //         if (acc != null && acc.Id != null) {
    //             AccountShare accShare = new AccountShare();
    //             accShare.AccountId = acc.Id;
    //             accShare.UserOrGroupId = targetUserId;
    //             accShare.AccountAccessLevel = 'Edit';
    //             accShare.OpportunityAccessLevel = 'Edit';
    //             accShare.RowCause = Schema.AccountShare.RowCause.Manual;

    //             sharesToInsert.add(accShare);
    //         }
    //     }
    //     system.debug('Geeting share size' + sharesToInsert.size());
    //     if (!sharesToInsert.isEmpty()) {
    //         Database.SaveResult[] results = Database.insert(sharesToInsert, false);
    //         for (Database.SaveResult sr : results) {
    //             if (!sr.isSuccess()) {
    //                 for(Database.Error err : sr.getErrors()) {
    //                     System.debug('Error sharing Account: ' + err.getMessage());
    //                 }
    //             }
    //         }
    //     }
    // }

    // async apex reciving AccIds and performing DML operation seperately here.
    @Future
    public static void callAsyncApex(List<Id> accountIds){
        System.debug('Hello from async future apex ');
        List<Contact> conRecords = [SELECT Id, LeadSource FROM Contact WHERE AccountId IN:accountIds];
        List<Contact> addConToList = new List<Contact>();
        for(Contact con:conRecords){
            con.LeadSource='Web';
            addConToList.add(con);
        }
        
        if(!addConToList.isEmpty()){
            Update addConToList;
        }
    }
    
}