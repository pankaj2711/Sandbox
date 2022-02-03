@isTest
public class TrainingStatusCC_Test {
    @testSetup 
    static void testData() 
    {
        Training_Plan__c test1 = new Training_Plan__c(
            Training_Name__C = 'Administrator',
            Day__c =1,
            Topic_Name__C = 'Test Topic 1');
        
        insert test1;
        
        Training_Plan__c test2 = new Training_Plan__c(
            Training_Name__C = 'Administrator',
            Day__c =2,
            Topic_Name__C = 'Test Topic 2');
        
        insert test2;
        
        New_Training__c testNewTraining = new New_Training__c(
            Name = 'Test Admin Training',
            Trainer_Name__c = 'Test Trainer',
            Start_Date__c= System.Today(),
            Training__C = 'Administrator');
        
        insert testNewTraining;
    }
    
    @isTest
    static void testFunctions()
    {
        List<New_Training__c> testNewTraining = new List<New_Training__c>();
        List<New_Training_Plan__c> testNewTrainingPlan = new List<New_Training_Plan__c>();
        Test.startTest();
        testNewTraining = TrainingStatusCC.fetchTrainingNamesFromApex();
        testNewTrainingPlan = TrainingStatusCC.fetchTrainingRecords(testNewTraining[0].Id);
        Test.stopTest();
        
        System.assertEquals(1, testNewTraining.Size());
        System.assertEquals(2, testNewTrainingPlan.size());
    }
    
}