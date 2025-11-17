sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/etr/financeexpapproval/financeexpenseapproval/test/integration/pages/TravelRequestsEntityList",
	"com/etr/financeexpapproval/financeexpenseapproval/test/integration/pages/TravelRequestsEntityObjectPage",
	"com/etr/financeexpapproval/financeexpenseapproval/test/integration/pages/TravelExpensesEntityObjectPage"
], function (JourneyRunner, TravelRequestsEntityList, TravelRequestsEntityObjectPage, TravelExpensesEntityObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/etr/financeexpapproval/financeexpenseapproval') + '/test/flp.html#app-preview',
        pages: {
			onTheTravelRequestsEntityList: TravelRequestsEntityList,
			onTheTravelRequestsEntityObjectPage: TravelRequestsEntityObjectPage,
			onTheTravelExpensesEntityObjectPage: TravelExpensesEntityObjectPage
        },
        async: true
    });

    return runner;
});

