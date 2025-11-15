sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/etr/travelrequests/travelrequests/test/integration/pages/TravelRequestsEntityList",
	"com/etr/travelrequests/travelrequests/test/integration/pages/TravelRequestsEntityObjectPage",
	"com/etr/travelrequests/travelrequests/test/integration/pages/TravelExpensesEntityObjectPage"
], function (JourneyRunner, TravelRequestsEntityList, TravelRequestsEntityObjectPage, TravelExpensesEntityObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/etr/travelrequests/travelrequests') + '/test/flp.html#app-preview',
        pages: {
			onTheTravelRequestsEntityList: TravelRequestsEntityList,
			onTheTravelRequestsEntityObjectPage: TravelRequestsEntityObjectPage,
			onTheTravelExpensesEntityObjectPage: TravelExpensesEntityObjectPage
        },
        async: true
    });

    return runner;
});

