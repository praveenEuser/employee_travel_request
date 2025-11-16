using Manager as service from '../../srv/manager_approval_service';

annotate service.TravelRequestsEntity with @Capabilities.DeleteRestrictions.Deletable : false;




annotate service.TravelRequestsEntity with @(

    UI.Identification#Empinfo1:[
        {
            $Type : 'UI.DataField',
            Label : 'Name',
            Value : employee.e_name,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Mail',
            Value : employee.e_mail,
        },
    ],

    UI.Identification#Travelinfo1 :[
            {
                $Type : 'UI.DataField',
                Label : 'Purpose',
                Value : purpose,
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
                Value : mode,
            },
            
    ],

    UI.FieldGroup#Travelinfo2: {
        Data: [
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
        ]
    },
    
    UI.FieldGroup#Travelinfo3: {
        Data: [
            {
                $Type : 'UI.DataField',
                Label : 'Status',
                Value : status,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Rejected Reason',
                Value : rejectReason,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Finance Approval Required',
                Value : requiresFinance,
            },
        ]
    },

    UI.Facets : [
        {
        $Type: 'UI.CollectionFacet',
        Label: 'Employee Information',
        ID: 'EmployeeInfo1',
        Facets: [
            {
                $Type: 'UI.ReferenceFacet',
                Label: 'Employee Information',
                Target: '@UI.Identification#Empinfo1'
            },
        ]
        },
        {
            $Type: 'UI.CollectionFacet',
            Label: 'Travel Request Information',
            ID: 'EmployeeInfo2',
            Facets: [
                {
                    $Type: 'UI.ReferenceFacet',
                    Label: 'Purpose of Travel',
                    Target: '@UI.Identification#Travelinfo1'
                },
                {
                    $Type: 'UI.ReferenceFacet',
                    Label: 'Duration',
                    Target: '@UI.FieldGroup#Travelinfo2'
                },
                {
                    $Type: 'UI.ReferenceFacet',
                    Label: 'Statuses',
                    Target: '@UI.FieldGroup#Travelinfo3'
                },
            ]
        },
    ],
    UI.LineItem : [
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
            Value : mode,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Finance Approval Required',
            Value : requiresFinance,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Status',
            Value : status,
        },

        {
            $Type : 'UI.DataFieldForAction',
            Action : 'Manager_Approval.managerApprove',
            Label : 'Approve',
            Inline : True
        },

        {
            $Type : 'UI.DataFieldForAction',
            Action : 'Manager_Approval.managerReject',
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
        Action : 'Manager_Approval.managerApprove',
        Label  : 'Approve'
    },
    {
        $Type : 'UI.DataFieldForAction',
        Action : 'Manager_Approval.managerReject',
        Label  : 'Reject'
    }
]

);

