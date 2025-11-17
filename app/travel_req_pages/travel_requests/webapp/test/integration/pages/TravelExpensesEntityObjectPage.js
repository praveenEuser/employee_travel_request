sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'com.etr.travelrequests.travelrequests',
            componentId: 'TravelExpensesEntityObjectPage',
            contextPath: '/TravelRequestsEntity/expenses'
        },
        CustomPageDefinitions
    );
});