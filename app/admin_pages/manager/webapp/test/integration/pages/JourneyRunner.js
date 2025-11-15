sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/etr/manager/manager/test/integration/pages/ManagerEntityList",
	"com/etr/manager/manager/test/integration/pages/ManagerEntityObjectPage"
], function (JourneyRunner, ManagerEntityList, ManagerEntityObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/etr/manager/manager') + '/test/flp.html#app-preview',
        pages: {
			onTheManagerEntityList: ManagerEntityList,
			onTheManagerEntityObjectPage: ManagerEntityObjectPage
        },
        async: true
    });

    return runner;
});

