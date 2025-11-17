sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'com.etr.financetravelreqapproval.financeapprove',
            componentId: 'TravelRequestsEntityList',
            contextPath: '/TravelRequestsEntity'
        },
        CustomPageDefinitions
    );
});