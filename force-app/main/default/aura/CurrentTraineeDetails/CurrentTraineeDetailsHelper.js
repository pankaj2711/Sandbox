({
    getTraineeList: function(component) {
        var trainingName = component.get('v.Training_Name');
        var action = component.get('c.GetCurrentTrainee');
        // Set up the callback    
        action.setParams({ trainingName: trainingName });
        action.setCallback(this, function(response) {
            var state = response.getState();
            var Trainee_detail = [];
            if (state === "SUCCESS") {
                //component.set('v.lstTrainee',response.getReturnValue());
                var result = response.getReturnValue();
                var record;
                for (var i = 0; i < result.length; i++) {
                    record = result[i];
                    var subData = {
                        "ID": record.Id,
                        "Trainee_Id" : record.Trainee_Name__c,
                        "Trainee_Name__c": record.Trainee_Name__r.Name,
                        "Trailhead_Profile__c": record.Trainee_Name__r.Trailhead_Profile__c,
                        "Trailhead_Badges__c": record.Trainee_Name__r.Trailhead_Badges__c,
                        "Office_Location__c": record.Trainee_Name__r.Office_Location__c,
                        "Evaluation_Performance__c" : record.Trainee_Name__r.Evaluation_Performance__c, 
                        "General_Awareness_Performance__c": record.Trainee_Name__r.General_Awareness_Performance__c,
                        "Competency_1__c": record.Trainee_Name__r.Competency_1__c,
                        "Competency_2__c": record.Trainee_Name__r.Competency_2__c,
                        "Training_Name__c": record.Training_Name__r.Name
                    };
                    const found = Trainee_detail.some(el => el.Trainee_Id === subData["Trainee_Id"]);
                    if (!found) 
                        Trainee_detail.push(subData);
                    else
                    {
                        var trainee_index = Trainee_detail.findIndex(obj => obj.Trainee_Id === subData["Trainee_Id"]);
                        //trainee_data.Training_Name__c = trainee_data.Training_Name__c +' , '+subData.Training_Name__c;       
                        Trainee_detail[trainee_index].Training_Name__c= Trainee_detail[trainee_index].Training_Name__c + ',' +subData["Training_Name__c"];
                    }
                }
                component.set('v.lstTrainee', Trainee_detail);
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
    
    sortBy: function (component, field) {
        var sortAsc = component.get("v.sortAsc"),
            sortField = component.get("v.sortField"),
            records = component.get("v.lstTrainee");
        sortAsc = field == sortField ? !sortAsc : true;
        records.sort(function (a, b) {
            var t1 = a[field] == b[field],
                t2 = a[field] > b[field];
            return t1 ? 0 : (sortAsc ? -1 : 1) * (t2 ? -1 : 1);
        });
        component.set("v.sortAsc", sortAsc);
        component.set("v.sortField", field);
        component.set("v.lstTrainee", records);
    },
})