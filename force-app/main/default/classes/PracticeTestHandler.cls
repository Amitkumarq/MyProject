@isTest
private class PracticeTestHandler {
    @TestSetup
static void makeData(){
     Account acc = new Account(
            Name = 'Test Account',
            Create_N_Contacts__c = 5
        );
        insert acc;

    Opportunity opp = new Opportunity();
        opp.Name = 'my test oppp';
        opp.StageName = 'prospecting';
        opp.CloseDate = System.today().addDays(10);
        insert opp; 
}

    @isTest
    static void accCreationTest(){
        Account acc = [Select Id, Name, Create_N_Contacts__C From Account Limit 1];

        Test.startTest();
            SheetApexPractice.AccCreation();
        Test.stopTest();
    }

    @isTest
static void oppCreationTest() {
   	Test.startTest();
    SheetApexPractice.oppCreation();
    Test.stopTest();

    List<Opportunity> oppList = [SELECT Id, Name FROM Opportunity];
    Opportunity opp = oppList[0];

    Assert.areEqual(2, oppList.size(), 'Should have 2 Opps: 1 from setup + 1 from oppCreation()');
    Assert.isNotNull(opp.Id, 'Opportunity Id should not be null');
    Assert.isTrue(oppList.size() > 0, 'Opportunity list should not be empty');
    Assert.isFalse(oppList.isEmpty(), 'List should have records');
    Assert.areNotEqual(0, oppList.size(), 'Size should not be zero');
    }
}