public with sharing class QueueablePracticeClass implements Queueable {
    public static void execute (QueueableContext qc) {
        System.debug('Queueable class executed');
        Id jobId = System.enqueueJob(new QueueableCaseTwo());
        System.debug('Job Id: '+ jobId);
    }
}