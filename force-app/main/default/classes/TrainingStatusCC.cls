public class TrainingStatusCC {
    @AuraEnabled
    public static List<New_Training__c> fetchTrainingNamesFromApex()
    {
        List<New_Training__c> trainingRecords = [Select Id,Name,Trainer_Name__c,Start_Date__c,Number_of_Trainee__c FROM New_Training__c];
        return trainingRecords;      
    }
    
    @AuraEnabled
    public static List<New_Training_Plan__c> fetchTrainingRecords(String recordId)
    {
        List<New_Training_Plan__c> trainingRecords = [Select Id,Name,Status__c,Completion_Date__c,Day__c FROM New_Training_Plan__c WHERE Training_Name__c = :recordId Order By Day__c];
        return trainingRecords;      
    }
    
}