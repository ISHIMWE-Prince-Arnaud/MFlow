package controllers;

import daos.DiagnosisDAO;
import daos.VisitDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.Diagnosis;
import models.Staff;
import models.Visit;

import java.io.IOException;
import java.util.List;

@WebServlet("/doctor")
public class DoctorServlet extends HttpServlet {
    private DiagnosisDAO diagnosisDAO;
    private VisitDAO visitDAO;

    @Override
    public void init(){
        diagnosisDAO = new DiagnosisDAO();
        visitDAO = new VisitDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get list of visits that need diagnosis
        List<Visit> pendingVisits = visitDAO.getVisitsByStatus("VITALS_RECORDED");
        request.setAttribute("pendingVisits", pendingVisits);
        
        request.getRequestDispatcher("/views/doctor.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Input validation
        String visitIdParam = request.getParameter("visitId");
        String notes = request.getParameter("notes");
        String prescription = request.getParameter("prescription");

        int visitId;
        try {
            visitId = Integer.parseInt(visitIdParam);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid visit ID.");
            List<Visit> pendingVisits = visitDAO.getVisitsByStatus("VITALS_RECORDED");
            request.setAttribute("pendingVisits", pendingVisits);
            request.getRequestDispatcher("/views/doctor.jsp").forward(request, response);
            return;
        }

        if (notes == null || notes.trim().isEmpty()) {
            request.setAttribute("error", "Diagnosis notes are required.");
            List<Visit> pendingVisits = visitDAO.getVisitsByStatus("VITALS_RECORDED");
            request.setAttribute("pendingVisits", pendingVisits);
            request.getRequestDispatcher("/views/doctor.jsp").forward(request, response);
            return;
        }

        // Null-safe session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInStaff") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Staff doctor = (Staff) session.getAttribute("loggedInStaff");

        Diagnosis diagnosis = new Diagnosis();
        diagnosis.setVisitId(visitId);
        diagnosis.setDoctorId(doctor.getStaffId());
        diagnosis.setNotes(notes);
        diagnosis.setPrescription(prescription);

        boolean diagnosisRecorded = diagnosisDAO.create(diagnosis);

        if (!diagnosisRecorded){
            request.setAttribute("error", "Diagnosis Record Failed");
            List<Visit> pendingVisits = visitDAO.getVisitsByStatus("VITALS_RECORDED");
            request.setAttribute("pendingVisits", pendingVisits);
            request.getRequestDispatcher("/views/doctor.jsp").forward(request, response);
            return;
        }

        visitDAO.updateStatus(visitId, "DIAGNOSIS_RECORDED");
        response.sendRedirect(request.getContextPath() + "/doctor?diagnosed=true");
    }
}
