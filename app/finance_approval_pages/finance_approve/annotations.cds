using Finance as service from '../../../srv/finance_approval_service';

annotate service.TravelRequestsEntity with @Capabilities.DeleteRestrictions.Deletable : false;

annotate service.TravelRequestsEntity with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
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
                Label : 'destination',
                Value : destination,
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
                Label : 'status',
                Value : status,
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
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
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
            Label : 'destination',
            Value : destination,
        },
        {
            $Type : 'UI.DataField',
            Label : 'estCost',
            Value : estCost,
        },
        {
            $Type : 'UI.DataField',
            Label : 'status',
            Value : status,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'Finance_Approval.financeApprove',
            Label : 'Approve',
            Inline : True
        },

        {
            $Type : 'UI.DataFieldForAction',
            Action : 'Finance_Approval.financeReject',
            Label : 'Reject',
            Inline : True
        },
    ],
    UI.HeaderInfo:{
        TypeName: 'Travel Request',
        TypeNamePlural : 'Travel Requests',
        Title:{
            Label : 'Travel Request ID',
            Value : ID
        },
    },

    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'Finance_Approval.financeApprove',
            Label  : 'Approve'
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'Finance_Approval.financeReject',
            Label  : 'Reject'
        }
    ]
);

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

