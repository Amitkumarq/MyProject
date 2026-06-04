public class TaskTriggerHandler {
    public static void assignTaskToContact(List<Task> newTaskRec){
        Set<Id> conId = new Set<Id>();
        for(Task t:newTaskRec){
            if (t.WhoId != null && t.WhoId.getSObjectType() == Contact.sObjectType){
                conId.add(t.WhoId);
            }
        }
        
       List<contact> conList =[SELECT Number_Of_Tasks__c, (SELECT  Who.Id FROM TASKS) FROM Contact WHERE Id IN: conId];
        for(Contact c: conList){
			c.Number_Of_Tasks__c = c.tasks.size();
        }
        
        if(!conList.isEmpty()){
            update conList;
        }
    }
    
    public static void updateTaskIfPermissionChecked(List<Task> newTaskRec){
        // Store whoId of task related to contact
        Map<Id,Task> conIdMap = new Map<Id,Task>();
        for(Task t:newTaskRec){
            if(t.WhoId != null && t.WhoId.getSObjectType() == contact.sObjectType){
                conIdMap.put(t.WhoId,t);
            }
        }
        
        if(conIdMap.isEmpty()) return;
        
        List<Contact> conRec = [SELECT Id, permission__c FROM Contact WHERE Id In: conIdMap.keySet()];
        for(Contact c:conRec){
            if(c.permission__c == false){
                // here conIdMap.get(c.Id) will map to the related task and throw Error on task object.
                conIdMap.get(c.Id).addError('You don\'t have the permission to Modify Task');
            }
        }
    }
}