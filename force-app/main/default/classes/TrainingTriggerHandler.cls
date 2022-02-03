public class TrainingTriggerHandler {
    
    public static void preparedTrainingPlan(List<New_Training__c> lstNewTraining)
    {
        List<New_Training_Plan__c> trainingPlanToBeProcessed = new List<New_Training_Plan__c>();
        map<Id,Training_Plan__c> mapStoredTrainingPlan = new map<Id,Training_Plan__c>([SELECT Id, Topic_Name__c, Training_Name__c,Day__c FROM Training_Plan__c]); 
        
        if(!mapStoredTrainingPlan.isEmpty())
        {
            for(New_Training__c obj : lstNewTraining)
            {
                for(Training_Plan__c trainingPlanObj : mapStoredTrainingPlan.values())
                {
                    if(trainingPlanObj.Training_Name__c == obj.Training__c)
                    {
                        New_Training_Plan__c NewTrainingPlanobj = new New_Training_Plan__c(
                            
                            Training_Name__c = obj.Id,
                            Name= trainingPlanObj.Topic_Name__c,
                            Day__c = trainingPlanObj.Day__c
                        );
                        trainingPlanToBeProcessed.add(NewTrainingPlanobj );                                    
                    }                                    
                }                               
            }
            if(trainingPlanToBeProcessed != null || !trainingPlanToBeProcessed.isEmpty())
            {
                insert trainingPlanToBeProcessed;              
            }                      
        }
    }
}