public with sharing class QueueableCaseTwo implements Queueable{
    public static void execute (QueueableContext qc) {
        System.debug('QueueableCaseTwo executed');
    }
}