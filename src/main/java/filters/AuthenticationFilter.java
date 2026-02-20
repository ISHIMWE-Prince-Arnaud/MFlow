package filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import models.Staff;

import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI();
        String context = req.getContextPath();

        // Allow login, logout and static resources
        if (path.endsWith("/login") ||
                path.endsWith("/logout") ||
                path.contains("/views/login.jsp") ||
                path.contains("/css/") ||
                path.contains("/images/")) {

            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);

        if (session == null ||
                session.getAttribute("loggedInStaff") == null) {

            res.sendRedirect(context + "/login");
            return;
        }

        Staff staff = (Staff) session.getAttribute("loggedInStaff");
        String role = staff.getRole();

        // Role-based access control
        if (!isAuthorized(role, path)) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }

        chain.doFilter(request, response);
    }

    private boolean isAuthorized(String role, String path) {

        if (path.endsWith("/dashboard")) {
            return true; // everyone can access dashboard
        }

        switch (role) {
            case "RECEPTION":
                return path.endsWith("/register");

            case "NURSE":
                return path.endsWith("/nurse");

            case "DOCTOR":
                return path.endsWith("/doctor");

            case "PHARMACIST":
                return path.endsWith("/pharmacy");

            case "ADMIN":
                return path.contains("/archive");

            default:
                return false;
        }
    }
}