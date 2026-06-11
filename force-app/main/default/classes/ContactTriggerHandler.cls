public class ContactTriggerHandler {
    public static void handleEmailChange(List<Contact> newConRecord,Map<Id, Contact> oldMap){
        List<Email_History__c> EhList = new List<Email_History__c>();
        for (Contact con : newConRecord) {
            if (con.Email != null && con.Email != oldMap.get(con.Id).Email) {
                Email_History__c Ehistory = new Email_History__c();
                Ehistory.New_Email__c = con.Email;
                Ehistory.Old_Email__c = oldMap.get(con.Id).Email;
                Ehistory.Contact__c = con.Id;
                Ehistory.Changed_On__c = Datetime.now();
                EhList.add(Ehistory);
            }

            if (!EhList.isEmpty()) {
                insert EhList;
            }
        }
    }
    // public static void handleContactValidation(List<Contact> newConRecord){
    //     try{
    //         for(Contact con:newConRecord){
    //             if(con.AccountId == null){
    //                 con.addError('Parent Account is Mandatory for Contact creation');
    //             }
    //         }
    //     }catch(Exception e){
    //         System.debug(LoggingLevel.ERROR, 'Unknown Exception in fetchingContacts: ' + e.getMessage());
    //     }
    // }

    // // Do not allow Contact association if Max Contacts Allowed value is exceeded on the Account record
    // public static void handleMaxContactAllowed(List<Contact> newConRecord){
    //     Set<Id> accId = new Set<Id>();
    //     for(Contact con:newConRecord){
    //         if(con.AccountId != null) accId.add(con.AccountId);
    //     }

    //     if(accId.isEmpty()) return;

    //     //This map is holding Id ----> maxContactAllowed
    //     Map<Id,Integer> maxContactAllowedMap = new Map<Id,Integer>();
    //     for(Account acc : [SELECT Id, maxContactAllowed__c FROM Account WHERE Id IN: accId]){
    //         maxContactAllowedMap.put(acc.Id,(Integer) acc.maxContactAllowed__c);
    //     }

    //     // This map is Holding Id ----> "count of Contacts" on a Related Account
    //     Map<Id, Integer> currentCountMap = new Map<Id, Integer>();
    // 	for (Account acc : [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :accId]) {
    //     		currentCountMap.put(acc.Id, acc.Contacts.size());
    // 		}

    //     for(Contact con:newConRecord){
    //    		Integer maxCount = maxContactAllowedMap.get(con.AccountId);
    //     	Integer currentCount = currentCountMap.containsKey(con.AccountId)? currentCountMap.get(con.AccountId): 0;

    //     	if (maxCount != null && currentCount >= maxCount) {
    //         	con.addError('Max Contacts Allowed limit exceeded for this Account.');
    //     	}
    //     }
    // }

    // public static void shareContactToPublicGroup(List<Contact> newConRecord){
    //     Id PublicGroup = [  SELECT Id FROM Group WHERE DeveloperName = 'Contact_Innovators' Limit 1].Id;

    //     List<ContactShare> ShareRecordsToInsert = new List<ContactShare>();

    //     for(Contact con: newConRecord){
    //         ContactShare shareRecord = new ContactShare();
    //         shareRecord.ContactId = con.Id;
    //         shareRecord.UserOrGroupId = PublicGroup;
    //         shareRecord.ContactAccessLevel = 'Edit';
    //         shareRecord.RowCause = Schema.ContactShare.RowCause.Manual;
    //         ShareRecordsToInsert.add(shareRecord);
    //     }

    //     if(!ShareRecordsToInsert.isEmpty()){
    //         insert ShareRecordsToInsert;
    //     }
    // }

    // public static void handleDuplicateOnCreation(List<Contact> newConRecord){
    //     List<Contact> existingContacts = [SELECT Id, Email, Phone FROM Contact];

    //     for(Contact con:newConRecord){
    //         for(Contact excon:existingContacts){
    //             if(con.Email == excon.email || con.Phone == excon.Phone){
    //                 con.addError('Duplicate email or Phone found');
    //             }
    //         }
    //     }
    // }

    // public static void sendEmail(List<Contact> newConRecord, Map<Id,Contact> oldMap){

    //     // Store Contacts where Email Or Phone Changed.
    //     List<Contact> storeConRecord = new List<Contact>();
    //     for(Contact con:newConRecord){
    //         if(con.AccountId != null){
    //             if(con.Email != oldMap.get(con.Id).Email || con.Phone != oldMap.get(con.Id).Phone){
    //                 storeConRecord.add(con);
    //             }
    //         }
    //     }
    //     if(storeConRecord.isEmpty()) return;

    //     // Now Collect AccountId And Query for account with Owner Email
    //     Set<Id> accIds = new Set<Id>();
    //     for(Contact con: storeConRecord){
    //         accIds.add(con.AccountId);
    //     }

    //     Map<Id,Account> accountMap = new Map<Id,Account>([
    //             SELECT Id, Owner.Email, Owner.Name
    //         	FROM Account
    //         	WHERE Id IN :accIds
    //         ]);

    //     Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();

    //     for(Contact con: storeConRecord){
    //         Account acc = accountMap.get(con.AccountId);
    //         message.toAddresses = new String[] { acc.Owner.Email };
    //         message.subject = 'Related Contact\'s Email Or Phone Changed';
    //         message.plainTextBody = 'This is the message body.';
    //         Messaging.SingleEmailMessage[] messages =

    //         new List<Messaging.SingleEmailMessage> {message};
    //         Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);

    //         if (results[0].success) {
    //             System.debug('The email was sent successfully.');
    //         }
    //         else {
    //             System.debug('The email failed to send: '+ results[0].errors[0].message);
    //         }
    //     }
    // }

    // public static void handleBeforeCreation(List<Contact> newConRecord){
    //     // Collecting AccountId From Contact Object.
    //     Set<Id> accIds = new Set<Id>();
    //     for(Contact con:newConRecord){
    //         if(con.AccountId!=null){
    //             accIds.add(con.AccountId);
    //         }
    //     }

    //     if (accIds.isEmpty()) return;

    //     // Storing Billing Address of Account Object.
    //     Map<Id,Account> accRec = new Map<Id,Account>([SELECT Id, BillingStreet, BillingCity, BillingState,BillingCountry, BillingPostalCode
    //                                                   FROM Account
    //                                                   WHERE Id IN: accIds]);

    //     for(Contact con:newConRecord){
    //         if(accRec.containsKey(con.AccountId)){
    //             Account acc = accRec.get(con.AccountId);
    //             con.MailingStreet = acc.BillingStreet;
    //             con.MailingCity = acc.BillingCity;
    //             con.MailingState = acc.BillingState;
    //             con.MailingCountry = acc.BillingCountry;
    //             con.MailingPostalCode = acc.BillingPostalCode;
    //         }
    //     }
    // }

    // public static void updateContactCount(List<Contact> newConRecord) {
    // 	Set<Id> accIds = new Set<Id>();
    // 	for (Contact con : newConRecord) {
    //     	if (con.AccountId != null) accIds.add(con.AccountId);
    // 	}

    // 	if (accIds.isEmpty()) return;

    // 	// Fetch accounts with their related contacts
    // 	List<Account> accToUpdate = new List<Account>();
    // 	for (Account acc : [SELECT Id, (SELECT Id FROM Contacts)
    //                         FROM Account
    //                         WHERE Id IN :accIds]) {
    //     	acc.number_of_contacts__c = acc.Contacts.size();
    //     	accToUpdate.add(acc);
    // 	}

    // 	if (!accToUpdate.isEmpty()) update accToUpdate;
    // }
}