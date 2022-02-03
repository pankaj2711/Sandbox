trigger NewTrainingTrigger on New_Training__c (After insert) {
    
    if(Trigger.isAfter)
    {
        if(Trigger.isInsert)
        {
             TrainingTriggerHandler.preparedTrainingPlan(Trigger.New);         
        }          
    }
}