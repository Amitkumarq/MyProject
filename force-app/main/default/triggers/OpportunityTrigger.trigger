trigger OpportunityTrigger on Opportunity (before Update,after update, after delete) {
    if(Trigger.isUpdate && Trigger.isAfter){
        OpportunityTriggerHandler.handleActivitiesAfterUpdate(Trigger.NEW);
        OpportunityTriggerHandler.handleDeleteTeamMemberAfterUpdate(Trigger.NEW,Trigger.oldMap);
        OpportunityTriggerHandler.addUserOfOpportunistsRole(Trigger.NEW,Trigger.oldMap);
    }
    
    if(Trigger.isUpdate && Trigger.isBefore){
        OpportunityTriggerHandler.handleOpportunityOnUpdate(Trigger.NEW, Trigger.oldMap);
    }
    
    if(Trigger.isDelete && Trigger.isAfter){
        OpportunityTriggerHandler.handleOpportunityAfterDelete(Trigger.Old);
    }
}