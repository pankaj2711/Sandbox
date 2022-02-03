@isTest
public class CurrentTraineeAttendance_Test {
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
        
        Trainee__c testTrainee1 = new Trainee__c(
            Name = 'Test Trainee1',
            Office_Location__c = 'India-Udaipur');
        
        insert testTrainee1;
        
        Trainee__c testTrainee2 = new Trainee__c(
            Name = 'Test Trainee2',
            Office_Location__c = 'India-Udaipur');
        
        insert testTrainee2;
        
        Trainee_Participate__c testTraineeParticipate1 = new Trainee_Participate__c(
            Training_Name__c = testNewTraining.Id,
            Trainee_Name__c = testTrainee1.Id);
        
        insert testTraineeParticipate1;
        
        Trainee_Participate__c testTraineeParticipate2 = new Trainee_Participate__c(
            Training_Name__c = testNewTraining.Id,
            Trainee_Name__c = testTrainee2.Id);
        
        insert testTraineeParticipate2;        
        
        Trainee_Participate__c testTraineeParticipate3 = new Trainee_Participate__c(
            Training_Name__c = testNewTraining.Id,
            Trainee_Name__c = testTrainee2.Id);
        
        try
        {
            insert testTraineeParticipate3;
        }
        catch(Exception e)
        {
            System.assertEquals(e.getMessage().contains('The selected trainee already in the selected training'),true );
        }
    }
    
    @isTest
    static void testFunctions()
    {
        List<New_Training__c> testTrainingList = new List<New_Training__c>();
        List<Trainee_Participate__c> testtraineeParticpate1 = new List<Trainee_Participate__c>();
        String result;
        Test.startTest();
        testTrainingList = CurrentTraineeAttendance.fetchTrainingNamesFromApex();
        testtraineeParticpate1 = CurrentTraineeAttendance.CurrentAttendees(testTrainingList[0].Id);
        result = CurrentTraineeAttendance.insertAttendanceApex(testTrainingList[0].Id, new List<Id>{testtraineeParticpate1[0].Trainee_Name__c}, 
                                                               new List<Id>{testtraineeParticpate1[1].Trainee_Name__c}, String.valueOf(System.today()));
        Test.stopTest();
        
        System.assertEquals('Success', result);
    }
    
    
}