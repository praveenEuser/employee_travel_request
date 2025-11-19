using { com.emptravelreq as etr } from '../db/etr-model';

service TravelReq @(path : 'Travel_Requests', requires: 'authenticated-user') {

    entity TravelRequestsEntity @(
        odata.draft.enabled : true,
        restrict: [
            { grant: '*', to: ['EmployeeRole'], where: 'employee_ID = $user.EmployeeID' }
        ]
    ) as projection on etr.TravelRequests{
        @readonly status,
        @readonly requiresFinance,
        @reaonly rejectReason,
        *,
    };

    entity TravelExpensesEntity @(restrict: [
      { grant: '*', to: ['EmployeeRole'], where: 'c_request.employee_ID = $user.EmployeeID'  }
    ]) as projection on etr.TravelExpenses;

    entity EmployeeEntity @(restrict: [
      { grant: 'READ', to: ['EmployeeRole'], where: 'ID = $user.EmployeeID' }
    ]) as projection on etr.Employee;

    entity ManagerEntity as projection on etr.Manager;

    entity FinanceEntity as projection on etr.Finance;

    entity DepartmentEntity as projection on etr.Departments;

    entity TravelModeEntity as projection on etr.TravelMode{
        *
    };

}
