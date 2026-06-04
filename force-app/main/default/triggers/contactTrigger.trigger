trigger contactTrigger on Contact (before insert, before update, before delete,
after insert,  after update,  after delete, after undelete) {
    
    //     if(Trigger.isInsert && Trigger.isBefore){
        //         ContactTriggerHandler.handleContactValidation(Trigger.New);
        //         ContactTriggerHandler.handleDuplicateOnCreation(Trigger.New);
        //         ContactTriggerHandler.handleMaxContactAllowed(Trigger.New);
        //         ContactTriggerHandler.handleBeforeCreation(Trigger.New);
    //     }
    
    //     if(Trigger.isAfter){
        //         if(Trigger.isInsert || Trigger.isUpdate){
            //             ContactTriggerHandler.shareContactToPublicGroup(Trigger.NEW);
            //             ContactTriggerHandler.sendEmail(Trigger.New,Trigger.oldMap);
            //             ContactTriggerHandler.updateContactCount(Trigger.New);
        //         }
    //     }
    
}