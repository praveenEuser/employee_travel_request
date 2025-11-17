sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'com.etr.managerapproval.managerapproval',
            componentId: 'TravelRequestsEntityObjectPage',
            contextPath: '/TravelRequestsEntity'
        },
        CustomPageDefinitions
    );
});