package filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

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

        // Allow login page and static resources
        if (path.endsWith("login") ||
                path.contains("/views/login.jsp") ||
                path.contains("/css/") ||
                path.contains("/images/")) {

            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);

        if (session != null &&
                session.getAttribute("loggedInStaff") != null) {

            chain.doFilter(request, response);

        } else {
            res.sendRedirect(context + "/login");
        }
    }
}
