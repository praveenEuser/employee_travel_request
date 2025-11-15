using Manager as service from '../../srv/manager_approval_service';
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
                Label : 'status',
                Value : status,
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
    ],
);

