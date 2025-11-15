using { com.emptravelreq as etr } from '../db/etr-model';

service TravelReq @(path : 'Travel_Requests') {

    entity TravelRequestsEntity @(
        odata.draft.enabled : true
    ) as projection on etr.TravelRequests{
        @readonly status,
        *,
    };

    entity TravelExpensesEntity as projection on etr.TravelExpenses;

    entity EmployeeEntity as projection on etr.Employee;

    entity ManagerEntity as projection on etr.Manager;

    entity FinanceEntity as projection on etr.Finance;

    entity DepartmentEntity as projection on etr.Departments;

}
