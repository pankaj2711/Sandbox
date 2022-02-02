trigger NewTrainingTrigger on New_Training__c (After insert) {
    
    if(Trigger.isAfter)
    {
        if(Trigger.isInsert)
        {
          List<New_Training__c> newTrainings = Trigger.New;
          List<New_Training_Plan__c> trainingPlanToBeProcessed = new List<New_Training_Plan__c>();
          map<Id,Training_Plan__c> mapStoredTrainingPlan = new map<Id,Training_Plan__c>([SELECT Id, Topic_Name__c, Training_Name__c,Day__c FROM Training_Plan__c]); 

          for(New_Training__c obj : newTrainings)
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
          insert trainingPlanToBeProcessed;         
        
        }
        
    
    }

}