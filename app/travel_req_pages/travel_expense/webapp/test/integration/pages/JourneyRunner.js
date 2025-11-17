sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/etr/travelexpense/travelexpense/test/integration/pages/TravelRequestsEntityList",
	"com/etr/travelexpense/travelexpense/test/integration/pages/TravelRequestsEntityObjectPage",
	"com/etr/travelexpense/travelexpense/test/integration/pages/TravelExpensesEntityObjectPage"
], function (JourneyRunner, TravelRequestsEntityList, TravelRequestsEntityObjectPage, TravelExpensesEntityObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/etr/travelexpense/travelexpense') + '/test/flp.html#app-preview',
        pages: {
			onTheTravelRequestsEntityList: TravelRequestsEntityList,
			onTheTravelRequestsEntityObjectPage: TravelRequestsEntityObjectPage,
			onTheTravelExpensesEntityObjectPage: TravelExpensesEntityObjectPage
        },
        async: true
    });

    return runner;
});

