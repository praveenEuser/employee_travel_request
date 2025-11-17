using TravelExp as service from '../../../srv/travel_expense_service';

annotate service.TravelRequestsEntity with @Capabilities.DeleteRestrictions.Deletable : false;

annotate service.TravelRequestsEntity with @Capabilities.InsertRestrictions.Insertable : false;

annotate service.TravelRequestsEntity with @Capabilities.UpdateRestrictions.Updatable : true;


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
                Value : mode,
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
            Label : 'status',
            Value : status,
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
            Label : 'destination',
            Value : destination,
        },
    ],
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

