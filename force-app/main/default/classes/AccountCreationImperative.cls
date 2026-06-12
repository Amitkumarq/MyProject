public with sharing class AccountCreationImperative {
    @AuraEnabled
    public static Boolean createAccount(string accountName) {
        Boolean insertSucess = false;
        if (accountName != null) {
            Account acc = new Account(Name = accountName);

            insert acc;
            insertSucess = true;
        }
        return insertSucess;
    }
}
