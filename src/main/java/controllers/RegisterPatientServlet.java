package controllers;

import daos.PatientDAO;
import daos.VisitDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Patient;
import models.Staff;
import models.Visit;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/register")
public class RegisterPatientServlet extends HttpServlet {
    private PatientDAO patientDAO;
    private VisitDAO visitDAO;

    @Override
    public void init(){
        patientDAO = new PatientDAO();
        visitDAO = new VisitDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/registerPatient.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dateOfBirth");
        String phone = request.getParameter("phone");

        //Create Patient
        Patient patient = new Patient();
        patient.setFullName(fullName);
        patient.setGender(gender);
        patient.setPhone(phone);
        if (dob!=null && !dob.isEmpty()) {
            patient.setDateOfBirth(LocalDate.parse(dob));
        }

        boolean patientCreated = patientDAO.create(patient);

        if(!patientCreated){
            request.setAttribute("error", "Patient not created");
            request.getRequestDispatcher("/views/registerPatient.jsp").forward(request, response);
            return;
        }

        //Get loggedIn receptionist
        HttpSession session = request.getSession(false);
        Staff receptionist = (Staff) session.getAttribute("loggedInStaff");

        //Create a visit
        Visit visit = new Visit();
        visit.setPatientId(patient.getPatientId());
        visit.setReceptionId(receptionist.getStaffId());
        visit.setVisitStatus("REGISTERED");

        boolean visitCreated = visitDAO.create(visit);

        if (!visitCreated) {
            request.setAttribute("error", "Visit not created");
            request.getRequestDispatcher("/views/registerPatient.jsp").forward(request, response);
            return;
        }

        //Patient registered and visit created — redirect back to register with success
        response.sendRedirect(request.getContextPath() + "/register?success=true");
    }
}
