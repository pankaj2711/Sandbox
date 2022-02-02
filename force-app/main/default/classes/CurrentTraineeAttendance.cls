public with sharing class CurrentTraineeAttendance {

    @AuraEnabled       
    public static List<Trainee_Participate__c> CurrentAttendees(String trainingID){
         List<Trainee_Participate__c>  TraineeList = [SELECT Trainee_Name__c,Trainee_Name__r.Name
                                                      FROM Trainee_Participate__c WHERE Training_Name__c =:trainingID];
        return TraineeList;
    }
    @AuraEnabled
    public static List<New_Training__c> fetchTrainingNamesFromApex()
    {
        List<New_Training__c> trainingRecords = [Select Id,Name FROM New_Training__c];
        return trainingRecords;      
    }
    
    @AuraEnabled
    public static String insertAttendanceApex(Id trainingID, List<Id> absenteeIDS,List<Id> presentIDS,String AttendanceDate)
    {
        Date trainingAttendanceDate =  Date.valueOf(AttendanceDate);
        List<Attendance__c> lstAttendanceToBeProcessed = new List<Attendance__c>();
        if(absenteeIDS != null || !absenteeIDS.isEmpty())
        {
            for(Id absentee : absenteeIDS)
            {
                Attendance__c attendance = new Attendance__c(
                    Trainee_Name__c = absentee,
                    Training_Name__c = trainingID,
                    Present__c =False,
                    Date__c = trainingAttendanceDate
                );
                lstAttendanceToBeProcessed.add(attendance);
            }
        }
        if(presentIDS != null || !presentIDS.isEmpty())
        {
            for(Id present : presentIDS)
            {
                Attendance__c attendance = new Attendance__c(
                    Trainee_Name__c = present,
                    Training_Name__c = trainingID,
                    Date__c = trainingAttendanceDate
                );
                lstAttendanceToBeProcessed.add(attendance);
            }
        }
        insert lstAttendanceToBeProcessed;
        return 'Success';
		    
    }

}