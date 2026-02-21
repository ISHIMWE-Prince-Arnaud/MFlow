package controllers;

import daos.VisitDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.VisitDetails;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/archive/details")
public class VisitDetailsServlet extends HttpServlet {
    private VisitDAO visitDAO;

    @Override
    public void init(){
        visitDAO = new VisitDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Validate visitId parameter
        String visitIdParam = request.getParameter("visitId");
        if (visitIdParam == null || visitIdParam.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing visitId parameter.");
            return;
        }

        int visitId;
        try {
            visitId = Integer.parseInt(visitIdParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid visitId parameter.");
            return;
        }

        try {
            VisitDetails visitDetails = visitDAO.getVisitDetails(visitId);
            if (visitDetails == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Visit not found.");
                return;
            }

            request.setAttribute("visitDetails", visitDetails);
            request.getRequestDispatcher("/views/viewDetails.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "A database error occurred. Please try again later.");
        }
    }
}
