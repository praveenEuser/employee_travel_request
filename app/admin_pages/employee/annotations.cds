using Admin as service from '../../../srv/admin_service';
annotate service.EmployeeEntity with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'e_name',
                Value : e_name,
            },
            {
                $Type : 'UI.DataField',
                Label : 'e_mail',
                Value : e_mail,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Manager ID',
                Value : e_manager_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Finance ID',
                Value : e_finance_ID,
            }

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
            Label : 'e_name',
            Value : e_name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'e_mail',
            Value : e_mail,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Manager Name',
            Value : m_name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Finance Manager Name',
            Value : f_name,
        },

    ],
);

annotate service.EmployeeEntity with {
    e_manager_ID @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'ManagerEntity',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : e_manager_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'm_name',
            },
        ],
    }
};

annotate service.EmployeeEntity with {
    e_finance_ID @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'FinanceEntity',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : e_finance_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'f_name',
            },
        ],
    }
};

