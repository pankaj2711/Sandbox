({
    doInit: function(component, event, helper) {
        helper.fetchTrainingNames(component, event);
    },
    handlePresentAttendeesChange: function(component, event,helper) {
        var selectedOptionValue = event.getParam("value");
    },
    handelTrainingName: function(component, event, helper) {
        if (component.get('v.selectedValue') == 'Please Select training')
            return;
        else {
            helper.CurrentAttendeesHelperMethod(component, event);
        }
    },
    storeAttendance: function(component, event, helper) {
		var absenteeIds = component.get('v.values');
        var presentIds =[];
        var totalStudents = component.get('v.PresentAttendeesList');
        for(var i=0;i<totalStudents.length;i++)
        {
			if(!totalStudents[i]["value"].includes(absenteeIds))
            	presentIds.push(totalStudents[i]["value"]);	
        }
        component.set('v.presentIds',presentIds);
        helper.sendAttendance(component,event);
    }
})