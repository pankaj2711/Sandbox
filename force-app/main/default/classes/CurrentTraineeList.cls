public class CurrentTraineeList {
    @AuraEnabled
    public static List<Trainee_Participate__c> GetCurrentTrainee(String trainingName)
    {
        
        String trainingNameQuery;
        List<Trainee_Participate__c>  lstTrainee ;
        if(String.isEmpty(trainingName))
        {
            lstTrainee = [SELECT Id, Training_Name__r.Name,Trainee_Name__r.Name,Trainee_Name__r.Office_Location__c,
                          Trainee_Name__r.Trailhead_Profile__c, Trainee_Name__r.Trailhead_Badges__c,Trainee_Name__r.Competency_1__c,Trainee_Name__r.Competency_2__c,Trainee_Name__r.General_Awareness_Performance__c,Trainee_Name__r.Evaluation_Performance__c 
                          FROM Trainee_Participate__c WHERE Training_Name__c in :[Select Id FROM New_Training__c WHERE End_Date__c = null] And Trainee_Name__r.Active__c = True Order By Trainee_Name__r.Name ];  
        }
        else
        {
            lstTrainee = [SELECT Id, Training_Name__r.Name,Trainee_Name__r.Name,Trainee_Name__r.Office_Location__c,
                          Trainee_Name__r.Trailhead_Profile__c, Trainee_Name__r.Trailhead_Badges__c,Trainee_Name__r.Competency_1__c,Trainee_Name__r.Competency_2__c 
                          FROM Trainee_Participate__c WHERE Training_Name__c =:trainingName And Trainee_Name__r.Active__c = True Order By Trainee_Name__r.Name];  
        }
        
        return lstTrainee;
    } 
}