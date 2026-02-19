package controllers;

import daos.DiagnosisDAO;
import daos.VisitDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Diagnosis;
import models.Staff;

import java.io.IOException;

@WebServlet("/doctor")
public class DoctorServlet extends HttpServlet {
    private DiagnosisDAO diagnosisDAO = new DiagnosisDAO();
    private VisitDAO visitDAO = new VisitDAO();

    @Override
    public void init(){
        diagnosisDAO = new DiagnosisDAO();
        visitDAO = new VisitDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/doctor.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int visitId = Integer.parseInt(request.getParameter("visitId"));
        String notes = request.getParameter("notes");
        String prescription = request.getParameter("prescription");

        HttpSession session = request.getSession(false);
        Staff doctor = (Staff) session.getAttribute("loggedInStaff");

        Diagnosis diagnosis = new Diagnosis();
        diagnosis.setVisitId(visitId);
        diagnosis.setDoctorId(doctor.getStaffId());
        diagnosis.setNotes(notes);
        diagnosis.setPrescription(prescription);

        boolean diagnosisRecorded = diagnosisDAO.create(diagnosis);

        if (!diagnosisRecorded){
            request.setAttribute("error", "Diagnosis Record Failed");
            request.getRequestDispatcher("/views/doctor.jsp").forward(request, response);
            return;
        }

        visitDAO.updateStatus(visitId, "DIAGNOSIS_RECORDED");
        request.setAttribute("visitId", visitId);
        response.sendRedirect("/pharmacy");
    }
}
