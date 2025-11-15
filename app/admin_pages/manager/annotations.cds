using Admin as service from '../../../srv/admin_service';
annotate service.ManagerEntity with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'm_name',
                Value : m_name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'm_mail',
                Value : m_mail,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Department ID',
                Value : m_department_ID,
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
            Label : 'm_name',
            Value : m_name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'm_mail',
            Value : m_mail,
        }
    ],
);

annotate service.ManagerEntity with {
    m_department_ID @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'DepartmentsEntity',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : m_department_ID,
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

