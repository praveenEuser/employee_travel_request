namespace com.emptravelreq;

using { cuid,managed, sap.common.Currencies } from '@sap/cds/common';

entity  Manager : cuid {
    m_name : String;
    m_mail : String;
    m_department_ID : UUID;
    m_department : Association to Departments on m_department.ID = m_department_ID;

}

entity Finance : cuid {
    f_name : String;
    f_mail : String;
    f_department_ID : UUID;
    f_department : Association to Departments on f_department.ID = f_department_ID;
}

entity Employee : cuid {
    e_name : String;
    e_mail : String;
    e_manager_ID : UUID;
    e_manager : Association to Manager on e_manager.ID = e_manager_ID;
    e_finance_ID : UUID;
    e_finance : Association to Finance on e_finance.ID = e_finance_ID;
}

entity Departments : cuid {
    d_name      : String(100);
    budget      : Decimal(15,2);    // total budget
    usedBudget  : Decimal(15,2) default 0;
}

entity TravelRequests : cuid {
      employee_ID : UUID;
      employee : Association to Employee on employee.ID = employee_ID;
      purpose    : String(255);
      fromDate   : Date;
      toDate     : Date;
      destination: String(100);
      estCost    : Decimal(15,2);
      modes       : Composition of many TravelMode on modes.travelreq = $self;
      status     : String(50) default 'Draft';
      rejectReason        : String(2000); 
      requiresFinance: Boolean default false;
      
      expenses   : Composition of many TravelExpenses on expenses.c_request = $self;
}

entity TravelMode : cuid {
  travelreq :  Association to TravelRequests;
  mode          : String enum {
    bus;
    train;
    flight;
    car;
  };
}

entity TravelExpenses : cuid{
      category : String(50);
      amount   : Decimal(15,2);
      @mandatory
      bill     : LargeBinary @Core.MediaType: '*/*';
      c_request_ID : UUID not null;
      c_request       : Association to TravelRequests on c_request.ID = c_request_ID;
}
