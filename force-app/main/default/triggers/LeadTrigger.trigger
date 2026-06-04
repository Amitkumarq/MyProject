trigger LeadTrigger on Lead (before insert, before update, before delete, after insert) {
    
    if(Trigger.isAfter && Trigger.isInsert){
        LeadTriggerHandler.handleActivityAfterCreate(Trigger.NEW);
    }
    
    if(Trigger.isupdate && Trigger.isBefore){
        for(Lead leadRecord: Trigger.NEW){
            leadRecord.Status = 'Working-Contacted';
            if(leadRecord.Industry=='Healthcare'){
                leadRecord.LeadSource='Purchased List';
                leadRecord.SICCode__c='1100';
                leadRecord.Primary__c='Yes';
            }
        }
    }
    
    if(Trigger.isDelete && Trigger.isBefore){
        LeadTriggerHandler.handleActivityBeforeDelete(Trigger.Old);
    }

    if(Trigger.isInsert && Trigger.isAfter){
        LeadTriggerHandler.handleAfterInsert(Trigger.new);
    }
}