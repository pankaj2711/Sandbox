({
    doInit: function(component, event, helper) {  
        component.set("v.sortAsc", true);
        helper.getTraineeList(component);
    },
    sortByName: function (component, event, helper) {
        helper.sortBy(component, "Trainee_Name__c");
    },
    sortByLocation: function (component, event, helper) {
        helper.sortBy(component, "Office_Location__c");
    },
    sortByEvaluation: function (component, event, helper) {
        helper.sortBy(component, "Evaluation_Performance__c");
    },
    sortByGenPerformance: function (component, event, helper) {
        helper.sortBy(component, "General_Awareness_Performance__c");
    },
    sortByCompetency1: function (component, event, helper) {
        helper.sortBy(component, "Competency_1__c");
    },
    sortByCompetency2: function (component, event, helper) {
        helper.sortBy(component, "Competency_2__c");
    },
    sortByTraining: function (component, event, helper) {
        helper.sortBy(component, "Training_Name__c");
    },
        sortByTraining: function (component, event, helper) {
        helper.sortBy(component, "Trailhead_Badges__c");
    },
})