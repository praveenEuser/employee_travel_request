using { com.emptravelreq as etr } from '../db/etr-model';

service FinanceExp @(path : 'Finance_Expense', requires: 'authenticated-user') {

    entity TravelRequestsEntity @(restrict: [
      { grant: 'READ', to: ['FinanceRole'], where: 'employee.e_finance_ID = $user.FinanceID' }
    ]) as projection on etr.TravelRequests{
        *,
    } where status = 'Settled' or status = 'Approved' and requiresFinance = true

    actions {

            @restrict: [
                { grant: ['EXECUTE'], to: ['FinanceRole'] }
            ]


            @cds.odata.bindingparameter.name :'_praveen'
            @Common.SideEffects : {
                TargetProperties : ['_praveen/status']
            }

            action settleExpense() returns Boolean;
    };

    entity TravelExpensesEntity @(restrict: [
      { grant: 'READ', to: ['FinanceRole'], where: 'c_request.employee.e_finance_ID = $user.FinanceID' }
    ]) as projection on etr.TravelExpenses;

    entity EmployeeEntity as projection on etr.Employee;

    entity ManagerEntity as projection on etr.Manager;

    entity FinanceEntity as projection on etr.Finance;

    entity DepartmentEntity as projection on etr.Departments;

}
