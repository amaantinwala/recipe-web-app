<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<jsp:include page="nav.jsp" />
<!DOCTYPE html>
<html>
<head>
    <title>Recipe Details</title>
    
    <style>
       body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('./img/background.jpeg');
            color: #333;
        }


        
        
        .container {
            max-width: 800px;
            margin: 20px auto;
            text-align: center;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .recipe-details {
            margin-bottom: 20px;
            text-align: center;
        }

        .recipe-details h2 {
            margin-top: 0;
            color: #333;
        }

        .recipe-image {
            max-width: 30%;
            object-fit: cover;
            height: auto;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .health-list, .ingredients {
            margin-top: 20px;
        }

        .health-list h3, .ingredients h3 {
            margin-top: 0;
            color: #333;
        }

        .health-list ul, .ingredients ul {
            margin: 0;
            padding: 0;
            list-style: none;
        }

        .health-list li, .ingredients li {
            margin-bottom: 5px;
            font-size: 16px;
            padding: 8px 15px;
            background-color: #f2f2f2;
            border-radius: 20px;
            display: inline-block;
            margin-right: 10px;
            color: #333;
            /*display: inline-block;*/
            text-align: left;
        }
    </style>
</head>
<body>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Register JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Database credentials
        String dbUrl = "jdbc:mysql://localhost:3306/recipeapp";
        String dbUser = "root";
        String dbPass = "1030";

        // Get RecipeId from URL's query parameter
        String recipeId = request.getParameter("id");

        // Establish database connection
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

        // Query the database based on RecipeId
        String sql = "SELECT * FROM Recipe WHERE RecipeId = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, recipeId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String recipeTitle = rs.getString("RecipeTitle");
            String recipeDescription = rs.getString("description");
            String recipeImageURL = rs.getString("RecipeImageURL");
            String healthList = rs.getString("HealthList");
            String ingredients = rs.getString("ingredients");
%>

            
    

    <div class="container">
        <div class="recipe-details">
            <h2><%= recipeTitle %></h2>
            <p><%= recipeDescription %></p>
            <img src="<%= recipeImageURL %>" width="300" height="250"alt="Recipe Image" class="recipe-image">
        </div>

        <div class="health-list">
                <h3>Health Information</h3>
                <% 
                   String[] healthItems = healthList.substring(1, healthList.length() - 1).split(",");
                   for (String item : healthItems) { %>
                       <li><%= item.trim().replaceAll("^\"|\"$", "") %></li>
                <% } %>
            </div>
            <div class="ingredients">
                <h3>Ingredients</h3>
                <% 
                    String[] ingredientList = ingredients.substring(1, ingredients.length() - 1).split(",");
                   for (String ingredient : ingredientList) { %>
                       <li><%= ingredient.trim().replaceAll("^\"|\"$", "") %></li>
                <% } %>
            </div>
    </div>

<%
        } else {
%>
            <p>Recipe not found.</p>
<%
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        // Close resources
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
