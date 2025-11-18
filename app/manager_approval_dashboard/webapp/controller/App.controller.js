sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/ui/model/json/JSONModel",
  "sap/m/MessageToast"
], (BaseController, JSONModel, MessageToast) => {
  "use strict";
  return BaseController.extend("com.etr.managerapprovaldashboard.managerapprovaldashboard.controller.App", {
      onInit() {
      var oModel = new JSONModel({
        tiles: [
          {
            title: "Travel Request Approval",
            subtitle: "Employee Travel Request Approval",
            icon: "sap-icon://request",
            url: "/manager_approval_pages/manager_approval/webapp/index.html"
          },
          {
            title: "Travel Expense Settlement",
            subtitle: "Employee Travel Expense Settlement",
            icon: "sap-icon://travel-expense-report",
            url: "/manager_approval_pages/manager_expense_approval/webapp/index.html"
          },
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