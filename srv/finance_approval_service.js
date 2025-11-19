const cds = require("@sap/cds");
const { SELECT } = require("@sap/cds/lib/ql/cds-ql");

module.exports = cds.service.impl(async function() {

    const { TravelRequestsEntity } = this.entities
    
        this.on('financeApprove', async req => {
            const param = req.params?.[0];
            const reqID = param?.ID ?? param;
            const tx = cds.tx(req);
    
            const tr = await tx.run(SELECT.one.from(TravelRequestsEntity).where({ ID: reqID }));
            if (!tr) return req.error(404, 'Request not found');
            
            const status = tr.status;
    
    
            if( status === 'Approved'){
                return req.error(400, 'This travel request is already approved.');
            }
    
            // Decide final status
            let newStatus;
            if (tr.requiresFinance === true) {
                newStatus = 'Approved';
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

                try {
                // Load employee, manager, finance info
                const emp = await tx.run(
                    SELECT.one.from(EmployeeEntity).where({ ID: tr.employee_ID })
                );
                const mgr = await tx.run(
                    SELECT.one.from(ManagerEntity).where({ ID: emp.e_manager_ID })
                );
                const fin = await tx.run(
                    SELECT.one.from(FinanceEntity).where({ ID: emp.e_finance_ID })
                );

                const employeeMail = emp?.e_mail;
                const managerMail  = mgr?.m_mail;
                const financeMail  = fin?.f_mail;

                const employeeName = emp?.e_name || "Employee";
                const managerName  = mgr?.m_name || "Manager";
                const financeName  = fin?.f_name || "Finance Team";

                if (employeeMail && financeMail) {

                    await sendMail({
                    to: employeeMail,                // Employee receives final approved mail
                    cc: [managerMail, financeMail].filter(Boolean), // Manager + Finance (optional)
                    replyTo: financeMail,            // Replies go to Finance
                    subject: `Travel Request ${tr.ID} Approved by Finance`,
                    html: `
                        <p>Hi ${employeeName},</p>

                        <p>Your travel request <b>${tr.ID}</b> has been 
                        <b style="color:green;">Approved by Finance</b>.</p>

                        <p><b>Purpose:</b> ${tr.purpose}</p>
                        <p><b>Destination:</b> ${tr.destination}</p>
                        <p><b>From:</b> ${tr.fromDate}</p>
                        <p><b>To:</b> ${tr.toDate}</p>
                        <p><b>Estimated Cost:</b> ${tr.estCost}</p>

                        <p>You may now proceed with your travel or complete further steps if required.</p>

                        <p>Regards,<br/>Travel App</p>
                    `
                    });

                } else {
                    console.warn("⚠ Missing employee/finance email. Cannot send finance approval email.");
                }

                } catch (err) {
                    console.error("❌ Finance approval email failed:", err.message);
                }

    
                return true;
        });
    
    
        this.on('financeReject', async req => {
            const param = req.params?.[0];
            const reqID = param?.ID ?? param;
            const { comments } = req.data;
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

            try {
                // Load employee, manager, finance info
                const emp = await tx.run(
                    SELECT.one.from(EmployeeEntity).where({ ID: tr.employee_ID })
                );
                const mgr = await tx.run(
                    SELECT.one.from(ManagerEntity).where({ ID: emp.e_manager_ID })
                );
                const fin = await tx.run(
                    SELECT.one.from(FinanceEntity).where({ ID: emp.e_finance_ID })
                );

                const employeeMail = emp?.e_mail;
                const managerMail  = mgr?.m_mail;
                const financeMail  = fin?.f_mail;

                const employeeName = emp?.e_name || "Employee";
                const managerName  = mgr?.m_name || "Manager";
                const financeName  = fin?.f_name || "Finance Team";

                if (employeeMail && financeMail) {

                    await sendMail({
                        to: employeeMail,                                 // Employee gets main mail
                        cc: [managerMail, financeMail].filter(Boolean),   // CC manager + finance
                        replyTo: financeMail,                             // Replies go to finance
                        subject: `Travel Request ${tr.ID} Rejected by Finance`,
                        html: `
                            <p>Hi ${employeeName},</p>

                            <p>Your travel request <b>${tr.ID}</b> has been 
                            <b style="color:red;">Rejected by Finance</b>.</p>

                            <p><b>Reason for Rejection:</b></p>
                            <p style="background:#ffe5e5;padding:10px;border-left:4px solid red;">
                                ${comments}
                            </p>

                            <p><b>Purpose:</b> ${tr.purpose}</p>
                            <p><b>Destination:</b> ${tr.destination}</p>
                            <p><b>From:</b> ${tr.fromDate}</p>
                            <p><b>To:</b> ${tr.toDate}</p>
                            <p><b>Estimated Cost:</b> ${tr.estCost}</p>

                            <p>You may modify the request and submit again if required.</p>

                            <p>Regards,<br/>Travel App</p>
                        `
                    });

                } else {
                    console.warn("⚠ Missing employee/finance email. Cannot send finance rejection email.");
                }

            } catch (err) {
                console.error("❌ Finance rejection email failed:", err.message);
            }


            
    
            return true;
        });

})