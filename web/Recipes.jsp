<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<jsp:include page="nav.jsp" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recipe List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            /*padding: 20px;*/
            background-color: #f4f4f4;
        }
        
       .container {
            max-width: 800px;
            margin: auto;
        }
        .card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            padding: 10px;
        }
        .card img {
            border-radius: 10px 0 0 10px;
            width: 150px;
            height: 150px;
            object-fit: cover;
        }
        .card .content {
            padding: 0 20px;
        }
        h2 {
            margin-top: 0;
        }
        a{
            text-decoration: none;
            color:inherit;
        }
    </style>
</head>
<body>
    <div class="container">
   <h1>Recipes</h1>
    <%
        String searchParam = request.getParameter("search");
        if (searchParam == null) {
            searchParam = "";
        }
       
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/recipeapp";
            String username = "root";
            String password = "1030";
            Connection con = DriverManager.getConnection(url, username, password);
            Statement stmt = con.createStatement();
            String query = "SELECT * FROM Recipe WHERE RecipeTitle LIKE '%" + searchParam + "%'";
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
    %>
    <a class="card" href="recipeDetail?id=<%=rs.getInt("RecipeId")%>">
                    <img src="<%= rs.getString("RecipeImageURL") %>" alt="Recipe Image">
                    <div class="content">
                        <h2><%= rs.getString("RecipeTitle") %></h2>
                        <p>Description:</p>
                    </div>
                </a>
    <%
            }
            con.close();
        } catch (Exception e) {
            out.println("Error: " + e);
        }
    %>
</div>
</body>
</html>
