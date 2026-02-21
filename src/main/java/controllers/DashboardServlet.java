package controllers;

import daos.StaffDAO;
import daos.VisitDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.Staff;
import models.Visit;

import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private VisitDAO visitDAO;
    private StaffDAO staffDAO;

    @Override
    public void init() {
        visitDAO = new VisitDAO();
        staffDAO = new StaffDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Get logged in staff
        HttpSession session = request.getSession(false);
        Staff loggedInStaff = (Staff) session.getAttribute("loggedInStaff");

        // If receptionist, load their registered patients
        if (loggedInStaff != null && "RECEPTIONIST".equals(loggedInStaff.getRole())) {
            List<Visit> visits = visitDAO.getVisitsByReceptionistAndStatus(
                    loggedInStaff.getStaffId(), "REGISTERED");
            
            // Create a list with formatted dates for display
            List<VisitDisplay> registeredPatients = new ArrayList<>();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm");
            for (Visit visit : visits) {
                VisitDisplay display = new VisitDisplay();
                display.setVisitId(visit.getVisitId());
                display.setPatientName(visit.getPatientName());
                display.setVisitStatus(visit.getVisitStatus());
                display.setCreatedAtFormatted(
                    visit.getCreatedAt() != null ? visit.getCreatedAt().format(formatter) : "-");
                registeredPatients.add(display);
            }
            request.setAttribute("registeredPatients", registeredPatients);
        }
        
        // If nurse, load patients who need vitals recorded (REGISTERED status)
        if (loggedInStaff != null && "NURSE".equals(loggedInStaff.getRole())) {
            List<Visit> visits = visitDAO.getVisitsByStatus("REGISTERED");
            
            List<VisitDisplay> patientsNeedingVitals = new ArrayList<>();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm");
            for (Visit visit : visits) {
                VisitDisplay display = new VisitDisplay();
                display.setVisitId(visit.getVisitId());
                display.setPatientName(visit.getPatientName());
                display.setVisitStatus(visit.getVisitStatus());
                display.setCreatedAtFormatted(
                    visit.getCreatedAt() != null ? visit.getCreatedAt().format(formatter) : "-");
                patientsNeedingVitals.add(display);
            }
            request.setAttribute("patientsNeedingVitals", patientsNeedingVitals);
        }
        
        // If doctor, load patients who need diagnosis (VITALS_RECORDED status)
        if (loggedInStaff != null && "DOCTOR".equals(loggedInStaff.getRole())) {
            List<Visit> visits = visitDAO.getVisitsByStatus("VITALS_RECORDED");
            
            List<VisitDisplay> patientsNeedingDiagnosis = new ArrayList<>();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm");
            for (Visit visit : visits) {
                VisitDisplay display = new VisitDisplay();
                display.setVisitId(visit.getVisitId());
                display.setPatientName(visit.getPatientName());
                display.setVisitStatus(visit.getVisitStatus());
                display.setCreatedAtFormatted(
                    visit.getCreatedAt() != null ? visit.getCreatedAt().format(formatter) : "-");
                patientsNeedingDiagnosis.add(display);
            }
            request.setAttribute("patientsNeedingDiagnosis", patientsNeedingDiagnosis);
        }
        
        // If pharmacist, load patients who need medication (DIAGNOSIS_RECORDED status)
        if (loggedInStaff != null && "PHARMACIST".equals(loggedInStaff.getRole())) {
            List<Visit> visits = visitDAO.getVisitsByStatus("DIAGNOSIS_RECORDED");
            
            List<VisitDisplay> patientsNeedingMedication = new ArrayList<>();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm");
            for (Visit visit : visits) {
                VisitDisplay display = new VisitDisplay();
                display.setVisitId(visit.getVisitId());
                display.setPatientName(visit.getPatientName());
                display.setVisitStatus(visit.getVisitStatus());
                display.setCreatedAtFormatted(
                    visit.getCreatedAt() != null ? visit.getCreatedAt().format(formatter) : "-");
                patientsNeedingMedication.add(display);
            }
            request.setAttribute("patientsNeedingMedication", patientsNeedingMedication);
        }

        // If admin, load statistics for dashboard overview
        if (loggedInStaff != null && "ADMIN".equals(loggedInStaff.getRole())) {
            request.setAttribute("totalVisits", visitDAO.getTotalVisitsCount());
            request.setAttribute("completedVisits", visitDAO.getCompletedVisitsCount());
            request.setAttribute("pendingVisits", visitDAO.getPendingVisitsCount());
            request.setAttribute("todayVisits", visitDAO.getTodayVisitsCount());
            request.setAttribute("totalPatients", visitDAO.getTotalPatientsCount());
            request.setAttribute("totalStaff", staffDAO.getTotalStaffCount());
            request.setAttribute("visitsRegistered", visitDAO.getVisitsBySpecificStatus("REGISTERED"));
            request.setAttribute("visitsVitalsRecorded", visitDAO.getVisitsBySpecificStatus("VITALS_RECORDED"));
            request.setAttribute("visitsDiagnosisRecorded", visitDAO.getVisitsBySpecificStatus("DIAGNOSIS_RECORDED"));
        }

        request.getRequestDispatcher("/views/dashboard.jsp")
                .forward(request, response);
    }

    // Inner class for display purposes
    public static class VisitDisplay {
        private int visitId;
        private String patientName;
        private String visitStatus;
        private String createdAtFormatted;

        public int getVisitId() { return visitId; }
        public void setVisitId(int visitId) { this.visitId = visitId; }
        public String getPatientName() { return patientName; }
        public void setPatientName(String patientName) { this.patientName = patientName; }
        public String getVisitStatus() { return visitStatus; }
        public void setVisitStatus(String visitStatus) { this.visitStatus = visitStatus; }
        public String getCreatedAtFormatted() { return createdAtFormatted; }
        public void setCreatedAtFormatted(String createdAtFormatted) { this.createdAtFormatted = createdAtFormatted; }
    }
}
