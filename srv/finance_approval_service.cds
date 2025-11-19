using { com.emptravelreq as etr } from '../db/etr-model';

service Finance @(path : 'Finance_Approval', requires: 'authenticated-user') {

    entity TravelRequestsEntity @(restrict: [
      { grant: 'READ', to: ['FinanceRole'], where: 'employee.e_finance_ID = $user.FinanceID' }
    ]) as projection on etr.TravelRequests{
        *,
    } where requiresFinance = true

    actions {

        @restrict: [
            { grant: ['EXECUTE'], to: ['FinanceRole'] }
        ]

        @cds.odata.bindingparameter.name :'_praveen'
        @Common.SideEffects : {
            TargetProperties : ['_praveen/status', '_praveen/rejectReason']
        }

        action financeApprove() returns Boolean;

        @restrict: [
            { grant: ['EXECUTE'], to: ['FinanceRole'] }
        ]

        @cds.odata.bindingparameter.name :'_reject'
        @Common.SideEffects : {
            TargetProperties : ['_reject/status', '_reject/rejectReason']
        }

        action financeReject(comments : String @Common.Label : 'Rejection Reason') returns Boolean;
    };

    entity TravelExpensesEntity @(restrict: [
      { grant: 'READ', to: ['FinanceRole'], where: 'c_request.employee.e_finance_ID = $user.FinanceID' }
    ]) as projection on etr.TravelExpenses;

    entity EmployeeEntity as projection on etr.Employee;

    entity ManagerEntity as projection on etr.Manager;

    entity DepartmentEntity as projection on etr.Departments;

    

}
