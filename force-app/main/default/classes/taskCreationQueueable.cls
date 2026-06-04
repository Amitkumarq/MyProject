public with sharing class taskCreationQueueable implements Queueable{
    public List<Case> caseRecord;
    public taskCreationQueueable(List<case> caseList){
        caseRecord = caseList;
    }
    
    public void execute(QueueableContext qc){
        List<Task> tRec = new List<Task>();
        for(Case eachCase:caseRecord){
            Task t = new Task();
            t.WhatId = eachCase.Id;
            t.Subject = 'Follow up';
            t.Status = 'Not Started';
            t.Priority= 'High';
            t.ActivityDate = Date.today()+30;
            t.OwnerId = eachCase.OwnerId;
            tRec.add(t);
        }
        
        if(!tRec.isEmpty()){
            insert tRec;
        }
    }
}