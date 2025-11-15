using Admin as service from '../../../srv/admin_service';
annotate service.FinanceEntity with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'f_name',
                Value : f_name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'f_mail',
                Value : f_mail,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Department ID',
                Value : f_department_ID,
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
            Label : 'f_name',
            Value : f_name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'f_mail',
            Value : f_mail,
        },
    ],
);

annotate service.FinanceEntity with {
    f_department_ID @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'DepartmentsEntity',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : f_department_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'd_name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'budget',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'usedBudget',
            },
        ],
    }
};

