using { com.emptravelreq as etr } from '../db/etr-model';

service ManagerExp @(path : 'Manager_Expense') {

    entity TravelRequestsEntity as projection on etr.TravelRequests{
        *,
    } where requiresFinance = false and status = 'Settled' or status = 'Approved'  

    actions {
            @cds.odata.bindingparameter.name :'_praveen'
            @Common.SideEffects : {
                TargetProperties : ['_praveen/status']
            }

            action settleExpense() returns Boolean;
    };

    entity TravelExpensesEntity as projection on etr.TravelExpenses;

    entity EmployeeEntity as projection on etr.Employee;

    entity ManagerEntity as projection on etr.Manager;

    entity FinanceEntity as projection on etr.Finance;

    entity DepartmentEntity as projection on etr.Departments;



}
