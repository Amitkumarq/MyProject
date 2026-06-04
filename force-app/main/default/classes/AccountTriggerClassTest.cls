@isTest
public class AccountTriggerClassTest{

    @TestSetup
    static void createData(){
        Account acc = new Account();
        acc.Name = 'Test Acc';
        acc.Industry = 'Agriculture';
        acc.OwnerShip = 'Public';
        acc.Type = 'Prospect';
        acc.Create_N_Contacts__c = 5;
        acc.Phone = '7451835227';
        acc.Website = 'www.abs.com';
        acc.Account_Type__c = 'Gold';
        insert acc;
    }
    
    @isTest
    public static void createRelatedConOppTest(){
        Account acc = new Account();
        acc.Name = 'Test Acc';
        acc.Account_Type__c = 'Silver';
        
        insert acc;

    }

    @isTest
    public static void handleBeforeUpdateActivitiesTest(){
        Account acc = [SELECT Id, Name, Industry,Ownership,Type FROM Account LIMIT 1];
        acc.Ownership = 'Private';
        
        try{
           Test.StartTest();
           update acc; 
        }catch(exception ex){
            system.debug('Error');
        }
        
       Test.StopTest();
    }   
    

    @isTest
    public static void handleAccountToContactSyncTest(){
        Account acc = [SELECT Id,Phone FROM Account LIMIT 1];
        acc.Phone = '6306587351';
        update acc;
    }

    @isTest
    public static void handleAfterUpdateActivitiesTest(){
        Account acc = [SELECT Id,Website FROM Account LIMIT 1];
        acc.Website = 'www.google.com';
        
        update acc;
        
    }

//     @isTest
//     public static void shareWithStandardUserTest(){
//         Account acc = [SELECT Id FROM Account LIMIT 1];

//         List<Profile> profiles = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
//         system.debug('line 65 >>'+profiles);

//         User newUser = new User(
//             FirstName = 'Jane',
//     LastName = 'Doe',
//     Email = 'jane.doe@example.com',
//     Username = 'jane.doe.' + System.currentTimeMillis() + '@yourdomain.com', // Must be unique
//     Alias = 'jdoe',
//     TimeZoneSidKey = 'America/Los_Angeles',
//     LocaleSidKey = 'en_US',
//     EmailEncodingKey = 'UTF-8',
//     ProfileId = profiles[0].Id,
//     LanguageLocaleKey = 'en_US'
// );

// // 3. Insert the record
// insert newUser;
// system.debug('line 81 >>'+newUser);

// //system.runAs(newUser){
//  AccountShare accShare = new AccountShare();
//                 accShare.AccountId = acc.Id;
//                 accShare.UserOrGroupId = newUser.Id;
//                 accShare.AccountAccessLevel = 'Edit';
//                 accShare.OpportunityAccessLevel = 'Edit';
//                 accShare.RowCause = Schema.AccountShare.RowCause.Manual;
//         Test.startTest();
//         insert accShare;
//         Test.stopTest();

// //}
        
//     }
}