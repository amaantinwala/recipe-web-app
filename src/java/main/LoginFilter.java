/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package main;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class LoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        // Check if session exists and isAuthenticated attribute is set
        boolean isAuthenticated = session != null && session.getAttribute("isAuthenticated") != null &&
                (boolean) session.getAttribute("isAuthenticated");

        // If not authenticated and not trying to access the login page, redirect to login
        String requestURI = httpRequest.getRequestURI();
        if (!isAuthenticated && !requestURI.endsWith("/login")) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }

        // Allow the request to proceed to the next servlet or JSP
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code, if any
    }

    @Override
    public void destroy() {
        // Cleanup code, if any
    }
}