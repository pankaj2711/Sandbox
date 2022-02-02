({
    CurrentAttendeesHelperMethod: function(component, event) {
        var today = new Date();
        component.set('v.today', today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate());
        
        var action = component.get('c.CurrentAttendees');
        action.setParams({
            "trainingID" : component.get('v.selectedValue') 
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            var Trainee_Names = [];
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                var record;
                for (var i = 0; i < result.length; i++) {
                    record = result[i];
                    var subData = {
                        "value": record.Trainee_Name__c,
                        "label": record.Trainee_Name__r.Name
                    };
                    Trainee_Names.push(subData);
                }
                component.set('v.PresentAttendeesList', Trainee_Names);
            } else if (state === "ERROR") {
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
    
    fetchTrainingNames: function(component, event) {
        var action = component.get('c.fetchTrainingNamesFromApex');
        // Set up the callback    
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            var Training_Names = [];
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                var record;
                for (var i = 0; i < result.length; i++) {
                    record = result[i];
                    var subData = {
                        //"ID": record.Id,
                        "Training_Name__c": record.Name
                    };
                    
                    Training_Names.push(subData);
                }
                
                component.set('v.trainings', result);
                console.log(Training_Names);
            } else if (state === "ERROR") {
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
    sendAttendance : function(component,event)
    {
        var trainingID = component.get('v.selectedValue');
        var absenteeIds = component.get('v.values');
        var presentIds = component.get('v.presentIds');
        var action = component.get('c.insertAttendanceApex');
        action.setParams({
            "trainingID" : component.get('v.selectedValue'),
            "absenteeIDS": absenteeIds,
            "presentIDS" : presentIds,
            "AttendanceDate" : component.get('v.today')
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            var Training_Names = [];
            if (state === "SUCCESS") {
                this.showToast(component,event);
                $A.get('e.force:refreshView').fire();
                
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                        toastEvent.setParams({
                            "title": "Error!",
                            "message": errors[0].message,
                            "type"	: 'error'
                        });
                        toastEvent.fire();
                    }
                } else {
                    console.log("Unknown error");
                }
                
                
            }
        });
        $A.enqueueAction(action);
        
        
    },
    showToast : function(component, event, helper) 
    {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "The record has been updated successfully.",
            "mode"	: 'pester',
            "type"	: 'success'
        });
        toastEvent.fire();
        
    }
})