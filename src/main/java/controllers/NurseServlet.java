package controllers;

import daos.VisitDAO;
import daos.VitalsDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.Staff;
import models.Visit;
import models.Vitals;

import java.io.IOException;
import java.util.List;

@WebServlet("/nurse")
public class NurseServlet extends HttpServlet {
    private VitalsDAO vitalsDAO;
    private VisitDAO visitDAO;

    @Override
    public void init(){
        vitalsDAO = new VitalsDAO();
        visitDAO = new VisitDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get list of visits that need vitals recorded
        List<Visit> pendingVisits = visitDAO.getVisitsByStatus("REGISTERED");
        request.setAttribute("pendingVisits", pendingVisits);
        
        request.getRequestDispatcher("/views/nurse.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Input validation
        String visitIdParam = request.getParameter("visitId");
        String temperatureParam = request.getParameter("temperature");
        String bloodPressure = request.getParameter("bloodPressure");
        String weightParam = request.getParameter("weight");

        int visitId;
        double temperature;
        double weight;

        try {
            visitId = Integer.parseInt(visitIdParam);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid visit ID.");
            List<Visit> pendingVisits = visitDAO.getVisitsByStatus("REGISTERED");
            request.setAttribute("pendingVisits", pendingVisits);
            request.getRequestDispatcher("/views/nurse.jsp").forward(request, response);
            return;
        }

        try {
            temperature = Double.parseDouble(temperatureParam);
            weight = Double.parseDouble(weightParam);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Temperature and weight must be valid numbers.");
            List<Visit> pendingVisits = visitDAO.getVisitsByStatus("REGISTERED");
            request.setAttribute("pendingVisits", pendingVisits);
            request.getRequestDispatcher("/views/nurse.jsp").forward(request, response);
            return;
        }

        if (bloodPressure == null || bloodPressure.trim().isEmpty()) {
            request.setAttribute("error", "Blood pressure is required.");
            List<Visit> pendingVisits = visitDAO.getVisitsByStatus("REGISTERED");
            request.setAttribute("pendingVisits", pendingVisits);
            request.getRequestDispatcher("/views/nurse.jsp").forward(request, response);
            return;
        }

        // Null-safe session check
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInStaff") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Staff nurse = (Staff) session.getAttribute("loggedInStaff");

        Vitals vitals = new Vitals();
        vitals.setVisitId(visitId);
        vitals.setNurseId(nurse.getStaffId());
        vitals.setTemperature(temperature);
        vitals.setBloodPressure(bloodPressure);
        vitals.setWeight(weight);

        boolean vitalsSaved = vitalsDAO.create(vitals);
        if (!vitalsSaved) {
            request.setAttribute("error", "Vitals not saved");
            List<Visit> pendingVisits = visitDAO.getVisitsByStatus("REGISTERED");
            request.setAttribute("pendingVisits", pendingVisits);
            request.getRequestDispatcher("/views/nurse.jsp").forward(request, response);
            return;
        }

        visitDAO.updateStatus(visitId, "VITALS_RECORDED");
        response.sendRedirect(request.getContextPath() + "/nurse?vitalsRecorded=true");
    }
}
