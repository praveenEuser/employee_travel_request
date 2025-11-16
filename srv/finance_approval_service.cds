using { com.emptravelreq as etr } from '../db/etr-model';

service Finance @(path : 'Finance_Approval') {

    entity TravelRequestsEntity as projection on etr.TravelRequests{
        *,
    } where requiresFinance = true

    actions {
        @cds.odata.bindingparameter.name :'_praveen'
        @Common.SideEffects : {
            TargetProperties : ['_praveen/status', '_praveen/rejectReason']
        }

        action managerApprove(reqID : UUID @Common.Label : 'Travel Request ID') returns Boolean;

        @cds.odata.bindingparameter.name :'_reject'
        @Common.SideEffects : {
            TargetProperties : ['_reject/status', '_reject/rejectReason']
        }

        action managerReject(reqID : UUID @Common.Label : 'Travel Request ID', comments : String @Common.Label : 'Rejection Reason') returns Boolean;
    };

    entity TravelExpensesEntity as projection on etr.TravelExpenses;

    entity EmployeeEntity as projection on etr.Employee;

    entity ManagerEntity as projection on etr.Manager;

    

    

}
