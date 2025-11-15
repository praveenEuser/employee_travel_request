using Admin as service from '../../../srv/admin_service';
annotate service.DepartmentsEntity with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'd_name',
                Value : d_name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'budget',
                Value : budget,
            },
            {
                $Type : 'UI.DataField',
                Label : 'usedBudget',
                Value : usedBudget,
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
            Label : 'd_name',
            Value : d_name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'budget',
            Value : budget,
        },
        {
            $Type : 'UI.DataField',
            Label : 'usedBudget',
            Value : usedBudget,
        },
    ],
);

