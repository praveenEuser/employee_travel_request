sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/etr/employee/employee/test/integration/pages/EmployeeEntityList",
	"com/etr/employee/employee/test/integration/pages/EmployeeEntityObjectPage"
], function (JourneyRunner, EmployeeEntityList, EmployeeEntityObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/etr/employee/employee') + '/test/flp.html#app-preview',
        pages: {
			onTheEmployeeEntityList: EmployeeEntityList,
			onTheEmployeeEntityObjectPage: EmployeeEntityObjectPage
        },
        async: true
    });

    return runner;
});

