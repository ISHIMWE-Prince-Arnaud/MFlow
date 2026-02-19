package controllers;

import daos.PharmacyDAO;
import daos.VisitDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Pharmacy;
import models.Staff;

import java.io.IOException;

@WebServlet("/pharmacy")
public class PharmacyServlet extends HttpServlet {
    private PharmacyDAO pharmacyDAO = new PharmacyDAO();
    private VisitDAO visitDAO = new VisitDAO();

    @Override
    public void init(){
        pharmacyDAO = new PharmacyDAO();
        visitDAO = new VisitDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        request.getRequestDispatcher("/views/pharmacy.jsp");
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
            request.getRequestDispatcher("/views/pharmacy.jsp");
        }

        visitDAO.updateStatus(visitId, "MEDICATION_RECORDED");
        request.getRequestDispatcher("/archive").forward(request,response);
    }
}