const cds = require("@sap/cds");
const { SELECT, UPDATE } = require("@sap/cds/lib/ql/cds-ql");

module.exports = cds.service.impl(async function() {


    const { TravelRequestsEntity, EmployeeEntity, ManagerEntity, DepartmentsEntity } = this.entities

    this.on('managerApprove', async req => {
        const param = req.params?.[0];
        const reqID = param?.ID ?? param;
        const tx = cds.tx(req);

        const tr = await tx.run(SELECT.one.from(TravelRequestsEntity).where({ ID: reqID }));
        if (!tr) return req.error(404, 'Request not found');

        const empID = tr.employee_ID;

        
        const status = tr.status;


        if( status === 'Approved' || status === 'Pending Finance Approval'){
            return req.error(400, 'This travel request is already approved.');
        }

            const emp = await tx.run(SELECT.one.from(EmployeeEntity).where({ ID: empID }));
            if (!emp) return req.error(404, 'Employee not found');

            const mngID = emp.e_manager_ID;

            const mng = await tx.run(SELECT.one.from(ManagerEntity).where({ ID: mngID }));
            if (!mng) return req.error(404, 'Manager not found');

            const deptID = mng.m_department_ID;

            const dept = await tx.run(SELECT.one.from(DepartmentsEntity).where({ ID: deptID }));
            if (!dept) return req.error(404, 'Department not found');

            const est = Number(tr.estCost ?? 0);
            const used = Number(dept.usedBudget ?? 0);
            const total = Number(dept.budget ?? 0);

        // Decide final status
        let newStatus;
        if (tr.requiresFinance === false) {

            

            // console.log('DBG budget values (raw):', { estRaw: tr.estCost, usedRaw: dept.usedBudget, totalRaw: dept.budget });
            // console.log('DBG budget values (num):', { est, used, total, sum: used + est });

            if (Number.isNaN(est) || Number.isNaN(used) || Number.isNaN(total)) {
                return req.error(500, 'Invalid numeric budget values.');
            }

            const mtot = used + est;
            // console.log(mtot);
            // console.log(tot);

            

            if (mtot > total) {
                return req.error(400, `Insufficient department budget. Used (${used}) + Est (${est}) > Total (${total})`);
            }

            else {
                newStatus = 'Approved';
                

            }

        } else {
            newStatus = 'Pending Finance Approval';
        }
        
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


    // this.on('managerApprove', async req => {
    //     const param = req.params?.[0];
    //     const reqID = param?.ID ?? param;
    //     const tx = cds.tx(req);

    //     if (!reqID) return req.error(400, "Request ID is required.");

    //     // 1) Read travel request
    //     const tr = await tx.run(SELECT.one.from(TravelRequestsEntity).where({ ID: reqID }));
    //     if (!tr) return req.error(404, 'Request not found');

    //     // Employee → Manager
    //     const emp = await tx.run(SELECT.one.from(Employee)
    //         .where({ ID: tr.employee_ID })
    //         .columns("e_manager_ID"));

    //     //if (!emp) return req.error(404, "Employee not found");

    //     // Manager → Department
    //     const mgr = await tx.run(SELECT.one.from(Manager)
    //         .where({ ID: emp.e_manager_ID })
    //         .columns("m_department_ID"));

    //     //if (!mgr) return req.error(404, "Manager not found");

    //     const deptId = mgr.m_department_ID;

    //     // Department budget
    //     const dept = await tx.run(SELECT.one.from(Departments)
    //         .where({ ID: deptId })
    //         .columns("budget", "usedBudget"));

    //     //if (!dept) return req.error(500, "Department budget not configured");
        
    //     const status = tr.status;

    //     if (status === 'Approved' || status === 'Pending Finance Approval') {
    //     return req.error(400, "This travel request is already approved.");
    //     }

        

    //     // Decide final status
    //     let newStatus;
    //     if (tr.requiresFinance === false) {
    //         newStatus = 'Approved';            

    //         const est = Number(tr.estCost || 0);
    //         const used = Number(dept.usedBudget || 0);
    //         const total = Number(dept.budget || 0);

    //         if ((used + est) > total) {
    //             return req.error(400, `Insufficient department budget. Used (${used}) + Est (${est}) > Total (${total})`);
    //         }



    //     } else {
    //         newStatus = 'Pending Finance Approval';
    //     }

    //     // 3) Update travel request status
    //     await tx.update(TravelRequestsEntity)
    //     .set({ status: newStatus, rejectReason: "" })
    //     .where({ ID: reqID });

    //     return true;
    // });


    this.on('managerReject', async req => {
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

        return true;
    });






})