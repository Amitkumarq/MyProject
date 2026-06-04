trigger CaseTrigger on Case (after update, before delete) {
    if(Trigger.isDelete && Trigger.isBefore){
        CaseTriggerHandler.handleCaseBeforeDeletion(Trigger.old);
    }
    
    if(Trigger.isAfter && Trigger.isUpdate){
        CaseTriggerHandler.createTaskQueuable(Trigger.new);
    }
}