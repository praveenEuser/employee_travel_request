using { com.emptravelreq as etr } from '../db/etr-model';

service Manager @(path : 'Manager_Approval') {

    entity TravelRequestsEntity as projection on etr.TravelRequests

    actions {
        @cds.odata.bindingparameter.name :'_praveen'
        @Common.SideEffects : {
            TargetProperties : ['_praveen/status', '_praveen/rejectReason']
        }

        action managerApprove() returns Boolean;

        @cds.odata.bindingparameter.name :'_reject'
        @Common.SideEffects : {
            TargetProperties : ['_reject/status', '_reject/rejectReason']
        }

        action managerReject(comments : String @Common.Label : 'Rejection Reason') returns Boolean;
    }; 

    entity TravelExpensesEntity as projection on etr.TravelExpenses;

    entity EmployeeEntity as projection on etr.Employee;

    entity ManagerEntity as projection on etr.Manager;

    entity DepartmentsEntity as projection on etr.Departments;

    

    

}
