public with sharing class CaseController {
    @AuraEnabled(cacheable=true)
    // method without parameter
    public static List<Case> getCasesInSequence() {
        return [
            SELECT Id, Origin, Reason, Priority, Subject
            FROM Case
            ORDER BY CreatedDate
            LIMIT 10
        ];
    }

    // class with parameter
    // public static List<Case> getCasesInSequence(string stringKey) {
    //     return [
    //         SELECT Id, Origin, Reason, Priority, Subject
    //         FROM Case
    //         WHERE Id = :stringKey
    //         ORDER BY CreatedDate
    //         LIMIT 10
    //     ];
    // }
}
