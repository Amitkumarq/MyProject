public with sharing class dependentWireController {
    @AuraEnabled(cacheable=true)
    public static List<Task> fetchTaskForAccount(String accountName) {
        try {
            return [
                SELECT Id, Subject, ActivityDate, Description, What.Name
                FROM Task
                WHERE What.Name = :accountName
            ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
