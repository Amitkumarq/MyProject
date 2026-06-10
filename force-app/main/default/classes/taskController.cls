public with sharing class taskController {
    @AuraEnabled(cacheable=true)
    public static List<Task> fetchTaskBySubject(String subjectString) {
        String searchKey = '%' + subjectString + '%';
        return [
            SELECT Id, Subject, Status, Description, Priority, ActivityDate
            FROM Task
            WHERE Subject LIKE :searchKey
        ];
    }
}
