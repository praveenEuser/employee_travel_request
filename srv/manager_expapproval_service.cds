using { com.emptravelreq as etr } from '../db/etr-model';

service ManagerExp @(path : 'Manager_Expense', requires: 'authenticated-user') {

    entity TravelRequestsEntity @(restrict: [
      { grant: 'READ', to: ['ManagerRole'], where: 'employee.e_manager_ID = $user.ManagerID' }
    ]) as projection on etr.TravelRequests{
        *,
    } where requiresFinance = false and status = 'Settled' or status = 'Approved'  

    actions {

            @restrict: [
                { grant: ['EXECUTE'], to: ['ManagerRole'] }
            ]

            @cds.odata.bindingparameter.name :'_praveen'
            @Common.SideEffects : {
                TargetProperties : ['_praveen/status']
            }

            action settleExpense() returns Boolean;
    };

    entity TravelExpensesEntity @(restrict: [
      { grant: 'READ', to: ['ManagerRole'], where: 'c_request.employee.e_manager_ID = $user.ManagerID' }
    ]) as projection on etr.TravelExpenses;

    entity EmployeeEntity as projection on etr.Employee;

    entity ManagerEntity as projection on etr.Manager;

    entity FinanceEntity as projection on etr.Finance;

    entity DepartmentEntity as projection on etr.Departments;



}
