sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/ui/model/json/JSONModel",
  "sap/m/MessageToast"
], (BaseController, JSONModel, MessageToast) => {
  "use strict";

  return BaseController.extend("com.etr.admindashboard.admindashboard.controller.App", {
      onInit() {

         var oModel = new JSONModel({
        tiles: [
          {
            title: "Managers",
            subtitle: "Manager Details",
            icon: "sap-icon://manager",
            url: "/admin_pages/manager/webapp/index.html"
          },
          {
            title: "Finance",
            subtitle: "Finance Team Details",
            icon: "sap-icon://leads",
            url: "/admin_pages/finance/webapp/index.html"
          },
          {
            title: "Employees",
            subtitle: "Employee details",
            icon: "sap-icon://employee",
            url: "/admin_pages/employee/webapp/index.html"
          },
          {
            title: "Departments",
            subtitle: "Department information",
            icon: "sap-icon://family-care",
            url: "/admin_pages/department/webapp/index.html"
          }
        ]
      });

      this.getView().setModel(oModel);

      },

      onTilePress: function (oEvent) {
      var oTile = oEvent.getSource();
      var sUrl = oTile.getBindingContext().getProperty("url");
      if (sUrl) {
        window.open(sUrl, "_blank");
      } else {
        MessageToast.show("No URL defined for this tile.");
      }
    }
  });
});