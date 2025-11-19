const cds = require("@sap/cds");
const { SELECT, UPDATE } = require("@sap/cds/lib/ql/cds-ql");

module.exports = cds.service.impl(async function() {


    const { TravelRequestsEntity, EmployeeEntity, ManagerEntity, DepartmentEntity, TravelExpensesEntity } = this.entities;

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

        const mngID = emp.e_manager_ID;

        const mng = await tx.run(SELECT.one.from(ManagerEntity).where({ ID: mngID }));
        if (!mng) return req.error(404, 'Manager not found');

        const deptID = mng.m_department_ID;

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

        if(est < check){
            const balance = check - est;
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
                .where({ ID : deptID })
        );

        try {
            const managerMail = mng?.m_mail;
            const employeeMail = emp?.e_mail;
            const managerName = mng?.m_name || "Your Manager";

            if (employeeMail) {
                await sendMail({
                to: employeeMail,
                cc: managerMail || undefined,
                replyTo: managerMail || undefined,
                subject: `Your Travel Expense for Request ${tr.ID} is Settled`,
                html: `
                    <p>Hi ${emp.e_name || "Colleague"},</p>
                    <p>Your travel expense has been <b>Settled</b>.</p>
                    <p>
                    <b>Destination:</b> ${tr.destination}<br/>
                    <b>Total Expense:</b> ${actualbudget}<br/>
                    <b>Estimated Cost:</b> ${est}
                    </p>
                    <p>Regards,<br/>Travel App</p>
                `
                });
            } else {
                console.warn("⚠ Missing employee email. Skipping settlement mail.");
            }
            } catch (err) {
            console.error("❌ Failed to send settlement email:", err.message);
            }

            return true;
    });



});