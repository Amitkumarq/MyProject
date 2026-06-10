public with sharing class CaseController {
    @AuraEnabled(cacheable=true)
    public static List<Case> getCasesInSequence() {
        return [
            SELECT Id, Origin, Reason, Priority, Subject
            FROM Case
            ORDER BY CreatedDate
            LIMIT 10
        ];
    }
}
