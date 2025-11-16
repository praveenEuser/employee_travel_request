const cds = require("@sap/cds");
const { SELECT } = require("@sap/cds/lib/ql/cds-ql");

module.exports = cds.service.impl(async function() {


    const { TravelRequestsEntity } = this.entities

    this.on('managerApprove', async req => {
        const { reqID } = req.data;
        const tx = cds.tx(req);

        const tr = await tx.run(SELECT.one.from(TravelRequestsEntity).where({ ID: reqID }));
        if (!tr) return req.error(404, 'Request not found');

        
        const status = tr.status;

        if( status === 'Approved' || status === 'Pending Finance Approval'){
            return req.error(400, 'This travel request is already approved.');
        }

        // Decide final status
        let newStatus;
        if (tr.requiresFinance === false) {
            newStatus = 'Approved';
        } else {
            newStatus = 'Pending Finance Approval';
        }
            // Always clear rejectReason info
            await tx.run(
                UPDATE(TravelRequestsEntity)
                .set({
                status: newStatus,
                rejectReason: '',
                })
                .where({ ID: reqID })
            );

            return true;
    });


    this.on('managerReject', async req => {
        const { reqID, comments } = req.data;
        const tx = cds.tx(req);

        if (!comments || !comments.trim()) {
            return req.error(400, 'Reject Reason is required.');
        }

        const tr = await tx.run(SELECT.one.from(TravelRequestsEntity).where({ ID: reqID }));
        if (!tr) return req.error(404, 'Request not found');

        const status = tr.status;

        if( status === 'Rejected'){
            return req.error(400, 'This travel request is already Rejected.');
        }

        await tx.run(
            UPDATE(TravelRequestsEntity)
            .set({
            status: 'Rejected',
            rejectReason: comments,
            })
            .where({ ID: reqID })
        );

        return true;
    });






})