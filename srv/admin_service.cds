using { com.emptravelreq as etr } from '../db/etr-model';


service Admin @(path : 'Admin_Service') {

    entity ManagerEntity @(
        odata.draft.enabled: true,
        restrict: [
            { grant: '*', to: ['AdminRole'] }
        ]
    )as projection on etr.Manager{
        @readonly m_department.d_name,
        *
    };
    
    entity FinanceEntity @(
        odata.draft.enabled: true,
        restrict: [
            { grant: '*', to: ['AdminRole'] }
        ]
    ) as projection on etr.Finance{
        @readonly f_department.d_name,
        *
    };

    entity EmployeeEntity @(
        odata.draft.enabled: true,
        restrict: [
            { grant: '*', to: ['AdminRole'] }
        ]
    ) as projection on etr.Employee{
        @readonly e_finance.f_name,
        @readonly e_manager.m_name,
        *
    };

    entity DepartmentsEntity @(
        odata.draft.enabled: true,
        restrict: [
            { grant: '*', to: ['AdminRole'] }
        ]
    ) as projection on etr.Departments{
        @readonly usedBudget,
        *,
    };

}
