package controllers;

import daos.VisitDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.ArchiveRecord;

import java.io.IOException;
import java.util.List;

@WebServlet("/archive")
public class ArchiveServlet extends HttpServlet {
    private VisitDAO visitDAO;

    @Override
    public void init(){
        visitDAO = new VisitDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ArchiveRecord> records = visitDAO.getArchivedRecords();
        request.setAttribute("records", records);
        request.getRequestDispatcher("/views/archive.jsp").forward(request, response);
    }
}
