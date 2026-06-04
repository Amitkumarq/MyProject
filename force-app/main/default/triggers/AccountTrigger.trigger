trigger AccountTrigger on Account (before update, after update, after insert, before insert) {
    
  if(Trigger.isBefore && Trigger.isUpdate){
    AccountTriggerClass.handleBeforeUpdateActivities(Trigger.new,Trigger.oldMap);
  }
  
  if(Trigger.isAfter && Trigger.isUpdate){
    AccountTriggerClass.accountToContactSync(Trigger.new, Trigger.oldMap);
    AccountTriggerClass.handleAfterUpdateActivities(Trigger.new,Trigger.oldMap);
  }

  if(Trigger.isAfter && Trigger.isInsert){
   // AccountTriggerClass.createRelatedConOpp(Trigger.new);
    AccountTriggerClass.handleAfterInsertActivities(Trigger.new);
    //AccountTriggerClass.shareWithStandardUser(Trigger.new);
  }
}