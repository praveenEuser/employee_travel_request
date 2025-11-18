using { com.emptravelreq as etr } from '../db/etr-model';

service TravelExp @(path : 'Travel_Expense') {

    entity TravelRequestsEntity @(
        odata.draft.enabled : true
    ) as projection on etr.TravelRequests{
        @readonly status,
        @readonly employee_ID,
        @readonly destination,
        @readonly purpose,
        @readonly ID,
        @readonly fromDate,
        @readonly toDate,
        @readonly estCost,
        @readonly rejectReason,
        @readonly requiresFinance,
        *
    } where status = 'Approved' or status = 'Settled';

    entity TravelExpensesEntity as projection on etr.TravelExpenses;

    entity EmployeeEntity as projection on etr.Employee;

    entity ManagerEntity as projection on etr.Manager;

    entity FinanceEntity as projection on etr.Finance;

    entity DepartmentEntity as projection on etr.Departments;

    entity TravelModeEntity as projection on etr.TravelMode{
        @readonly mode,
        *
    };

}
