({
    fetchTrainingNames : function(component,event) {
        var action = component.get("c.fetchTrainingNamesFromApex");
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.trainings',response.getReturnValue());
                console.log(response.getReturnValue());
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });        
        $A.enqueueAction(action);	
    },
    
    fetchTrainingRecords : function(component,event) {
        var action = component.get("c.fetchTrainingRecords");
        action.setParams({ recordId : component.get('v.selectedValue') });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var response = response.getReturnValue();
                if(response.length>0)
                {
                    var No_Of_Days= response[response.length-1].Day__c;
                    var Days_Completed = 0;
                    var Total_Evaluation_Scheduled = 0;
                    var Total_Evaluation_Completed = 0;
                    component.set('v.No_Of_Days',No_Of_Days)
                    component.set('v.New_Training_Plan__c',response)
                    for(var i=response.length-1 ; i>=0 ;i--)
                    {
                        if(response[i].Status__c == 'Completed')
                        {
                            Days_Completed = response[i].Day__c
                        }
                        if(response[i].Name.includes('Evaluation'))
                        {
                            Total_Evaluation_Scheduled++;
                        }                    
                        if(response[i].Name.includes('Evaluation') && response[i].Status__c == 'Completed')
                        {
                            Total_Evaluation_Completed++;
                        }
                    }
                    component.set('v.Total_Evaluation_Completed',Total_Evaluation_Completed);
                    component.set('v.Total_Evaluation_Scheduled',Total_Evaluation_Scheduled)
                    component.set('v.Days_Completed',Days_Completed);
                    console.log('Days_Completed'+Days_Completed);
                }
                else
                {
                    component.set('v.noPlan',true);
                }
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });        
        $A.enqueueAction(action);	
    }
    
})