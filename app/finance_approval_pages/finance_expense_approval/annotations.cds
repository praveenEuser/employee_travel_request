using FinanceExp as service from '../../../srv/finance_expapproval_service';


annotate service.TravelRequestsEntity with @Capabilities.DeleteRestrictions.Deletable : false;




annotate service.TravelRequestsEntity with @(

    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'status',
                Value : status,
            },
            {
                $Type : 'UI.DataField',
                Label : 'destination',
                Value : destination,
            },
            {
                $Type : 'UI.DataField',
                Label : 'purpose',
                Value : purpose,
            },
            {
                $Type : 'UI.DataField',
                Label : 'fromDate',
                Value : fromDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'toDate',
                Value : toDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'estCost',
                Value : estCost,
            },
            {
                $Type : 'UI.DataField',
                Label : 'mode',
                Value : modes.mode,
            },
            {
                $Type : 'UI.DataField',
                Label : 'rejectReason',
                Value : rejectReason,
            },
            {
                $Type : 'UI.DataField',
                Label : 'requiresFinance',
                Value : requiresFinance,
            },
        ],
    },

    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'Travel Request Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Travel Expenses',
            Target: 'expenses/@UI.LineItem',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'status',
            Value : status,
        },
        {
            $Type : 'UI.DataField',
            Label : 'destination',
            Value : destination,
        },
        {
            $Type : 'UI.DataField',
            Label : 'purpose',
            Value : purpose,
        },
        {
            $Type : 'UI.DataField',
            Label : 'fromDate',
            Value : fromDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'toDate',
            Value : toDate,
        },
    ],
    UI.HeaderInfo:{
        TypeName : 'Travel Request',
        TypeNamePlural : 'Travel Requests',
        Title:{
            $Type : 'UI.DataField',
            Value : ID,
        }
    },
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'Finance_Expense.settleExpense',
            Label  : 'Settle Expense'
        },
    ]
);

annotate service.TravelExpensesEntity with @(
    
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Label : 'Category',
            Value : category,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Amount',
            Value : amount,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Bill Attachment',
            Value : bill,
        },  
    ],
    

    UI.HeaderInfo:{
        TypeName : 'Travel Expense',
        TypeNamePlural : 'Travel Expenses',
        Title:{
            $Type : 'UI.DataField',
            Value : category,
        },
    },
    UI.Facets:[
        {
            $Type : 'UI.CollectionFacet',
            Label: 'Travel Expense Information',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Travel Expense Information',
                    Target : '@UI.Identification',
                },
            ],
            
        },
    ],

    UI.Identification:[
        {
            $Type: 'UI.DataField',
            Label:'Category',
            Value : category,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Amount',
            Value : amount,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Bill Attachment',
            Value : bill,
        },
    ],
);

annotate service.TravelExpensesEntity with {
    ID @UI.Hidden;
    c_request_ID @UI.Hidden;
}

annotate service.TravelRequestsEntity with {
    employee @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'EmployeeEntity',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : employee_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'e_name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'e_mail',
            },
        ],
    }
};

