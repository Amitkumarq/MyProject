public class CaseTriggerHandler {
    public static void handleCaseBeforeDeletion(List<Case> oldCaseRec){
        Id currentUserId = UserInfo.getProfileId();
        Id systemAdminId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id;
        
        for(Case c:oldCaseRec){
            if(currentUserId != systemAdminId){
                c.addError('You are not an admin not allowed to delete this case');
            }
        }
    }
    
    public static void createTaskQueuable(List<Case> caseRec){
        List<Case> caseList = new List<Case>();
        for(Case c:caseRec){
            if(c.Status == 'escalated'){
                caseList.add(c);
            }
        }
        
        if(!caseList.isEmpty()){
            System.enqueueJob(new taskCreationQueueable(caseList));
        }
    }
}