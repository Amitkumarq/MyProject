trigger taskTrigger on Task (After insert, Before update) {
    if(Trigger.isInsert && Trigger.isAfter){
        TaskTriggerHandler.assignTaskToContact(Trigger.New);
    }
    
    // Allow updating the Task record only if the parent Contact’s Account has the Permission checked
    if(Trigger.isUpdate && Trigger.isBefore){
		TaskTriggerHandler.updateTaskIfPermissionChecked(Trigger.New);
    }
}