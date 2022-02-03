@isTest
public class CurrentTraineeList_Test {
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
        
        Trainee__c testTrainee = new Trainee__c(
            Name = 'Test Trainee',
            Office_Location__c = 'India-Udaipur');
        
        insert testTrainee;
        
        Trainee_Participate__c testTraineeParticipate = new Trainee_Participate__c(
            Training_Name__c = testNewTraining.Id,
            Trainee_Name__c = testTrainee.Id);
        
        insert testTraineeParticipate;
        
    }
    
    @isTest
    static void testFunctions()
    {
        List<Trainee_Participate__c> testtraineeParticpate1 = new List<Trainee_Participate__c>();
        List<Trainee_Participate__c> testtraineeParticpate2 = new List<Trainee_Participate__c>();
        New_Training__c testTraining =[SELECT Id FROM New_Training__c LIMIT 1];
        
        Test.startTest();
        testtraineeParticpate1 = CurrentTraineeList.GetCurrentTrainee(null);
        testtraineeParticpate2 = CurrentTraineeList.GetCurrentTrainee(testTraining.Id);
        Test.stopTest();
        
        System.assertEquals(1, testtraineeParticpate1.Size());
        System.assertEquals(1, testtraineeParticpate2.size());
    }
    
    
}