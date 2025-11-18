using TravelReq as service from '../../../srv/travel_requests_service';
annotate service.TravelRequestsEntity with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'employee_ID',
                Value : employee_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Purpose',
                Value : purpose,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Travel Start Date',
                Value : fromDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Travel End Date',
                Value : toDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Destination',
                Value : destination,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Estimation Cost',
                Value : estCost,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Mode of Travel',
                Value : modes.mode,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Status',
                Value : status,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Finance Approval Required',
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
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Employee ID',
            Value : employee_ID,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Purpose',
            Value : purpose,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Travel Start Date',
            Value : fromDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Travel End Date',
            Value : toDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Destination',
            Value : destination,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Estimation Cost',
            Value : estCost,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Mode of Travel',
            Value : modes.mode,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Status',
            Value : status,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Finance Approval Required',
            Value : requiresFinance,
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
);

annotate service.TravelMode with {
    ID @UI.Hidden;
    mode @Common.Label : 'Mode of Transport';
    travelreq @UI.Hidden;
}


annotate service.TravelRequestsEntity with {
    employee_ID @Common.ValueList : {
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
        ],
    }
};

