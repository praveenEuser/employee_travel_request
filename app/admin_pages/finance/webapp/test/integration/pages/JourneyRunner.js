sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/etr/finance/finance/test/integration/pages/FinanceEntityList",
	"com/etr/finance/finance/test/integration/pages/FinanceEntityObjectPage"
], function (JourneyRunner, FinanceEntityList, FinanceEntityObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/etr/finance/finance') + '/test/flp.html#app-preview',
        pages: {
			onTheFinanceEntityList: FinanceEntityList,
			onTheFinanceEntityObjectPage: FinanceEntityObjectPage
        },
        async: true
    });

    return runner;
});

