using { com.emptravelreq as etr } from '../db/etr-model';

service Manager @(path : 'Manager_Approval') {

    entity TravelRequestsEntity as projection on etr.TravelRequests;

    entity TravelExpensesEntity as projection on etr.TravelExpenses;

    entity EmployeeEntity as projection on etr.Employee;

    entity ManagerEntity as projection on etr.Manager;

}
