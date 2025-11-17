sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'com.etr.travelexpense.travelexpense',
            componentId: 'TravelRequestsEntityObjectPage',
            contextPath: '/TravelRequestsEntity'
        },
        CustomPageDefinitions
    );
});