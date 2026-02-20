package controllers;

import daos.VisitDAO;
import daos.VitalsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Staff;
import models.Vitals;

import java.io.IOException;

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
        // Pass visitId from request attribute to JSP if present
        Object visitId = request.getAttribute("visitId");
        if (visitId != null) {
            request.setAttribute("visitId", visitId);
        }
        request.getRequestDispatcher("/views/nurse.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int visitId = Integer.parseInt(request.getParameter("visitId"));
        double temperature = Double.parseDouble(request.getParameter("temperature"));
        String bloodPressure = request.getParameter("bloodPressure");
        double weight = Double.parseDouble(request.getParameter("weight"));

        HttpSession session = request.getSession(false);
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
            request.getRequestDispatcher("/views/nurse.jsp").forward(request, response);
            return;
        }

        visitDAO.updateStatus(visitId, "VITALS_RECORDED");

        request.setAttribute("visitId", visitId);
        request.getRequestDispatcher("/doctor").forward(request, response);
    }
}
