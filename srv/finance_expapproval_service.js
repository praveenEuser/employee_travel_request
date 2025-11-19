const cds = require("@sap/cds");
const { SELECT, UPDATE } = require("@sap/cds/lib/ql/cds-ql");

module.exports = cds.service.impl(async function() {


    const { TravelRequestsEntity, EmployeeEntity, ManagerEntity, DepartmentEntity, TravelExpensesEntity, FinanceEntity } = this.entities;

    this.on('settleExpense', async req => {
        const param = req.params?.[0];
        const reqID = param?.ID ?? param;
        const tx = cds.tx(req);

        const tr = await tx.run(SELECT.one.from(TravelRequestsEntity).where({ ID: reqID }));
        if (!tr) return req.error(404, 'Request not found');

        

        const empID = tr.employee_ID;
        
        const status = tr.status;

        if(status === 'Settled'){
            return req.error(404, 'This Expense is already Settled');
        }

        const expenses = await tx.run(SELECT.from(TravelExpensesEntity).where({ c_request_ID: reqID }).columns('amount'));
        if (!expenses) return req.error(404, 'Amount not found');

        let totalExpense = 0;
        expenses.map(e => totalExpense += Number(e.amount || 0));

        const emp = await tx.run(SELECT.one.from(EmployeeEntity).where({ ID: empID }));
        if (!emp) return req.error(404, 'Employee not found');

        const finID = emp.e_finance_ID;

        const fin = await tx.run(SELECT.one.from(FinanceEntity).where({ ID: finID }));
        if (!fin) return req.error(404, 'Finance not found');

        const deptID = fin.f_department_ID;

        const dept = await tx.run(SELECT.one.from(DepartmentEntity).where({ ID: deptID }));
        if (!dept) return req.error(404, 'Department not found');

        const est = Number(tr.estCost ?? 0);
        const actualbudget = Number(totalExpense ?? 0);
        const used = Number(dept.usedBudget ?? 0);
        const total = Number(dept.budget ?? 0);

        const check = used + actualbudget;

        console.log(check);

        let newStatus;

        

        if (check > total){
            return req.error(400, `Insufficient department budget. Used (${used}) + Actual Budget (${actualbudget}) > Total (${total})`);
        }
        else {
            newStatus = 'Settled'
        }

        if(est < totalExpense){
            const balance = totalExpense - est;
            req.warn(`Balance exceeds estimate by ${balance}`);
        }
        
        await tx.run(
                UPDATE(TravelRequestsEntity)
                .set({
                status: newStatus,
                })
                .where({ ID: reqID })
        );
        await tx.run(
                UPDATE(DepartmentEntity)
                .set({
                usedBudget: check,
                })
                .where({ ID: deptID })
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
                to: employeeMail,                                   // Employee notified
                cc: [managerMail, financeMail].filter(Boolean),     // Manager + Finance (optional)
                replyTo: financeMail,                               // Replies go to Finance
                subject: `Travel Expense for Request ${tr.ID} Settled by Finance`,
                html: `
                    <p>Hi ${employeeName},</p>

                    <p>Your travel expense for request <b>${tr.ID}</b> has been 
                    <b style="color:green;">Settled by Finance</b>.</p>

                    <p>
                    <b>Purpose:</b> ${tr.purpose}<br/>
                    <b>Destination:</b> ${tr.destination}<br/>
                    <b>From:</b> ${tr.fromDate}<br/>
                    <b>To:</b> ${tr.toDate}<br/>
                    <b>Estimated Cost:</b> ${est}</b><br/>
                    <b>Final Settled Amount:</b> ${actualbudget}
                    </p>

                    <p>If you have any queries, please reply to this email. Your reply will go directly to ${financeName}.</p>

                    <p>Regards,<br/>Travel App</p>
                `
                });
            } else {
                console.warn("⚠ Missing employee/finance email. Cannot send finance settlement email.");
            }

            } catch (err) {
                console.error("❌ Finance settlement email failed:", err.message);
            }
        

        return true;
    });



});