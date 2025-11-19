const cds = require("@sap/cds");
const { SELECT } = require("@sap/cds/lib/ql/cds-ql");
const { sendMail } = require("./mail");   // <-- ADD THIS


module.exports = cds.service.impl(async function() {


    const { TravelRequestsEntity, ManagerEntity, EmployeeEntity } = this.entities;

    this.before(['CREATE','UPDATE'], 'TravelRequestsEntity', req => {

        const { status } = req.data

        if (status === 'Draft') {
            req.data.status = 'Submitted';
        } 
    });

    this.before(['CREATE','UPDATE'], 'TravelRequestsEntity', req =>{

        const {fromDate, toDate, estCost, requiresFinance} = req.data

        if(new Date(fromDate) > new Date(toDate)){
            req.error(400, 'Travel start date cannot be later than end date.');
        }

        if(estCost <= 0){
            req.error(400, 'Estimated cost must be greater than zero.');
        }


        if(estCost > 20000){
            req.data.requiresFinance = true;
        }
        else{
            req.data.requiresFinance = false;
        }

    });

    
    this.after("CREATE", "TravelRequestsEntity", async (data, req) => {
        // data = created Travel Request row
        const tx = cds.tx(req);

        try {
        // 1) Get employee
        const emp = await tx.run(
            SELECT.one.from(EmployeeEntity).where({ ID: data.employee_ID })
        );
        if (!emp) {
            console.warn("⚠ Employee not found for travel request:", data.ID);
            return;
        }

        // 2) Get manager
        const mgr = await tx.run(
            SELECT.one.from(ManagerEntity).where({ ID: emp.e_manager_ID })
        );
        if (!mgr) {
            console.warn("⚠ Manager not found for employee:", emp.ID);
            return;
        }

        const employeeMail = emp.e_mail;
        const managerMail  = mgr.m_mail;
        const employeeName = emp.e_name || "Employee";
        const managerName  = mgr.m_name || "Manager";

        if (!managerMail) {
            console.warn("⚠ No manager email maintained. Cannot send submission mail.");
            return;
        }

        // 3) Send mail: To Manager, CC Employee, ReplyTo Employee
        await sendMail({
            to: managerMail,
            cc: employeeMail || undefined,
            replyTo: employeeMail || undefined,
            subject: `New Travel Request Submitted by ${employeeName} (${data.ID})`,
            html: `
            <p>Hi ${managerName},</p>

            <p>${employeeName} has submitted a new <b>Travel Request</b> and it is waiting for your approval.</p>

            <p><b>Request ID:</b> ${data.ID}</p>
            <p><b>Purpose:</b> ${data.purpose}</p>
            <p><b>Destination:</b> ${data.destination}</p>
            <p><b>From:</b> ${data.fromDate}</p>
            <p><b>To:</b> ${data.toDate}</p>
            <p><b>Estimated Cost:</b> ${data.estCost}</p>

            <p>Please review and approve/reject in the Travel Request app.</p>

            <p>Regards,<br/>Travel App</p>
            `
        });

        } catch (err) {
        console.error("❌ Failed to send submission email:", err.message);
        // Do NOT throw: creation of request should still succeed
        }
  });
    



});
