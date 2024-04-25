package main;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet {
    
    // Database connection parameters
    private static final String URL = "jdbc:mysql://localhost:3306/recipeapp";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "1030";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve username and password from the POST request
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Perform authentication
        boolean isAuthenticated = authenticate(username, password);

        // Prepare response
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Check if authentication is successful
        if (isAuthenticated) {
            // Create a session for the user
            HttpSession session = request.getSession(true);
            session.setAttribute("isAuthenticated",isAuthenticated);
            // Set user attribute in session
            session.setAttribute("username", username);

            response.sendRedirect("RecipeSearch");
            
        } else {
            out.println("<h1>Login Failed</h1>");
            out.println("<p>Invalid username or password.</p>");
        }
    }

    // Function to authenticate user based on provided username and password
    private boolean authenticate(String username, String password) {
        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

            // Prepare SQL statement to retrieve user data
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);

            // Execute query
            ResultSet resultSet = statement.executeQuery();

            // Check if user exists and password matches
            boolean isAuthenticated = resultSet.next();

            // Close resources
            resultSet.close();
            statement.close();
            connection.close();

            return isAuthenticated;
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Authentication fails on database error
        }
        catch (Exception e) {
            e.printStackTrace();
            return false; // Authentication fails on database error
        }
    }
}
    