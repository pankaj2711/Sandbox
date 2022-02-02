({
    doInit : function(component, event, helper) {
        helper.fetchTrainingNames(component,event);		
    },
    
    handelTrainingName :function(component, event, helper) {
        component.set('v.New_Training_Plan__c',null);
        component.set('v.Trainer_Name',null);
        component.set('v.Training_Start_Date',null);
        component.set('v.No_Of_Days',null);
        component.set('v.Days_Completed',null);
        component.set('v.Total_Evaluation_Completed',null);
        component.set('v.Total_Evaluation_Scheduled',null);
        if(component.get('v.selectedValue') == 'Please Select training')
            return;
        else
        {          
            var allTrainingRecords= component.get('v.trainings');
            component.set('v.flag',true);
            for(var i=0;i<allTrainingRecords.length;i++)
            {
                if(allTrainingRecords[i].Id == component.get('v.selectedValue'))
                {
                    component.set('v.Trainer_Name',allTrainingRecords[i].Trainer_Name__c);
                    component.set('v.Training_Start_Date',allTrainingRecords[i].Start_Date__c);
                    component.set('v.Total_Trainees',allTrainingRecords[i].Number_of_Trainee__c);
                }
            }
            helper.fetchTrainingRecords(component,event);
        }	
    },
    
    callTrainineeComp : function(component, event, helper){
        var evt = $A.get("e.force:navigateToComponent");
        var navService = component.find("navService");
        var trainingName = component.get('v.selectedValue');
        evt.setParams({
            componentDef  : "c:CurrentTraineeDetails" ,
            componentAttributes  : {
                Training_Name : trainingName
            }     
        });
        evt.fire();
    }
})