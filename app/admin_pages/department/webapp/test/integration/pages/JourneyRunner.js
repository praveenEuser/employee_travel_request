sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/etr/department/department/test/integration/pages/DepartmentsEntityList",
	"com/etr/department/department/test/integration/pages/DepartmentsEntityObjectPage"
], function (JourneyRunner, DepartmentsEntityList, DepartmentsEntityObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/etr/department/department') + '/test/flp.html#app-preview',
        pages: {
			onTheDepartmentsEntityList: DepartmentsEntityList,
			onTheDepartmentsEntityObjectPage: DepartmentsEntityObjectPage
        },
        async: true
    });

    return runner;
});

