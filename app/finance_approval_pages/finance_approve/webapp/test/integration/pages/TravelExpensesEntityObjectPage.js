sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'com.etr.financetravelreqapproval.financeapprove',
            componentId: 'TravelExpensesEntityObjectPage',
            contextPath: '/TravelRequestsEntity/expenses'
        },
        CustomPageDefinitions
    );
});