public class OpportunityTriggerHandler {
    
    public static void handleDeleteTeamMemberAfterUpdate(List<Opportunity> newOppRecords, Map<id,Opportunity> oldMap){
        List <Id> closedLostOppIds = new List<Id>();
        for(Opportunity opp: newOppRecords){
            Opportunity oldOpp = oldMap.get(opp.Id);
            if(opp.StageName == 'Closed Lost' && oldOpp.StageName != 'Closed Lost'){
                closedLostOppIds.add(opp.Id);
            }
        }
        
        if(!closedLostOppIds.isEmpty()){
            List<OpportunityTeamMember> teamMemberToDelete = [SELECT Id FROM OpportunityTeamMember WHERE OpportunityId IN : closedLostOppIds];
            
            if(!teamMemberToDelete.isEmpty()){
                delete teamMemberToDelete;
            }
        }
    }
    
    public static void handleActivitiesAfterUpdate(List<Opportunity> newRecord){
        
        List<Task> taskListToInsert  = new List<Task>();
        
        for(Opportunity opp:newRecord){
            if(opp.stageName == 'closed won'){
                
                Task taskRecord = new Task();
                taskRecord.Priority='High';
                taskRecord.Status='Not Started';
                taskRecord.Subject='Split Revenue';
                taskRecord.OwnerId = opp.OwnerId;
                taskRecord.WhatId=opp.Id;
                
                taskListToInsert.add(taskRecord);
            }
        }
        if(!taskListToInsert.isEmpty()){
            insert taskListToInsert;
        }
    }
    
    public static void handleOpportunityOnUpdate(List<opportunity> newOppRecord, Map<Id,opportunity> oldMap){
        for(opportunity opp:newOppRecord){
            if(opp.stageName != oldMap.get(opp.Id).stageName){
                opp.Amount = opp.Probability*opp.ExpectedRevenue;
            }
        }
    }
    
    public static void handleOpportunityAfterDelete(List<Opportunity> oldOppRecord){
		List<Task> taskList = new List<Task>();
        for(Opportunity opp:oldOppRecord){
            Task t = new Task();
            t.Subject = 'Opportunity Deleted';
            t.Description = 'Opportunity ' + opp.Name + ' is deleted';
            t.OwnerId = opp.OwnerId;
            taskList.add(t);
        }
        
        if(!taskList.isEmpty()){
            insert taskList;
        }
        
    }
    
    public static void addUserOfOpportunistsRole(List<Opportunity> newOppRecord, Map<Id,Opportunity> oldMap){
        List<OpportunityTeamMember> listOppMember = new List<OpportunityTeamMember>();
        
        List<User> opportunist = [SELECT Id ,Name FROM User WHERE UserRole.Name = 'Opportunists'];
        
        for(Opportunity opp: newOppRecord){
            if(opp.StageName == 'Needs Analysis' && oldMap.get(opp.Id).StageName != opp.StageName){
                for(User userRec: opportunist){  
                	OpportunityTeamMember oppMember = new OpportunityTeamMember();
                    oppMember.OpportunityId = opp.Id;
                    oppMember.UserId = userRec.Id;
                    oppMember.OpportunityAccessLevel = 'Edit';
                    listOppMember.add(oppMember);
                }
            }
        }
        if(!listOppMember.isEmpty()){
            insert listOppMember;
        }
    }
}