sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "sap/ui/model/json/JSONModel",
  "sap/m/MessageToast"
], (BaseController, JSONModel, MessageToast) => {
  "use strict";

  return BaseController.extend("com.etr.travelreqdashboard.travelrequestdashboard.controller.App", {
      onInit() {

         var oModel = new JSONModel({
        tiles: [
          {
            title: "Travel Request",
            subtitle: "Travel Request",
            icon: "sap-icon://request",
            url: "/travel_req_pages/travel_requests/webapp/index.html"
          },
          {
            title: "Travel Expenses",
            subtitle: "Travel Expenses",
            icon: "sap-icon://travel-expense-report",
            url: "/travel_req_pages/travel_expense/webapp/index.html"
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