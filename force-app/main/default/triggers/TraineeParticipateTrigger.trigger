trigger TraineeParticipateTrigger on Trainee_Participate__c (before insert) {

TraineeParticipateTriggerHandler handler = new TraineeParticipateTriggerHandler();

    if(Trigger.isBefore)
    {
        if(Trigger.isInsert)
        {      
            handler.checkTraineeAlloctedInTraining(Trigger.New);
        }
    }
}