const cds = require("@sap/cds");
const { SELECT } = require("@sap/cds/lib/ql/cds-ql");

module.exports = cds.service.impl(async function() {


    const { TravelRequestsEntity } = this.entities;

    this.before(['CREATE','UPDATE'], 'TravelRequestsEntity', req => {

        const { status } = req.data

        if (status === 'Draft') {
            req.data.status = 'Submitted';
        } 
    });

    this.before(['CREATE','UPDATE'], 'TravelRequestsEntity', req =>{

        const {fromDate, toDate, estCost} = req.data

        if(new Date(fromDate) > new Date(toDate)){
            req.error(400, 'Travel start date cannot be later than end date.');
        }

        if(estCost <= 0){
            req.error(400, 'Estimated cost must be greater than zero.');
        }

    });

    



});
