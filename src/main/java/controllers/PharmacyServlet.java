package controllers;

import daos.PharmacyDAO;
import daos.VisitDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.Pharmacy;
import models.Staff;
import models.Visit;

import java.io.IOException;
import java.util.List;

@WebServlet("/pharmacy")
public class PharmacyServlet extends HttpServlet {
    private PharmacyDAO pharmacyDAO;
    private VisitDAO visitDAO;

    @Override
    public void init(){
        pharmacyDAO = new PharmacyDAO();
        visitDAO = new VisitDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get list of visits that need medication
        List<Visit> pendingVisits = visitDAO.getVisitsByStatus("DIAGNOSIS_RECORDED");
        request.setAttribute("pendingVisits", pendingVisits);
        
        request.getRequestDispatcher("/views/pharmacy.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int visitId = Integer.parseInt(request.getParameter("visitId"));
        String medication = request.getParameter("medication");

        HttpSession session = request.getSession(false);
        Staff pharmacist = (Staff) session.getAttribute("loggedInStaff");

        Pharmacy pharmacy = new Pharmacy();
        pharmacy.setVisitId(visitId);
        pharmacy.setPharmacistId(pharmacist.getStaffId());
        pharmacy.setMedication(medication);

        boolean medicationSaved = pharmacyDAO.create(pharmacy);
        if (!medicationSaved) {
            request.setAttribute("error", "Medication Recording Failed");
            List<Visit> pendingVisits = visitDAO.getVisitsByStatus("DIAGNOSIS_RECORDED");
            request.setAttribute("pendingVisits", pendingVisits);
            request.getRequestDispatcher("/views/pharmacy.jsp").forward(request, response);
            return;
        }

        visitDAO.updateStatus(visitId, "COMPLETED");
        response.sendRedirect(request.getContextPath() + "/pharmacy");
    }
}
