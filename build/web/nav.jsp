<%-- 
    Document   : nav
    Created on : Apr 25, 2024, 11:27:21 AM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
             .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            height:50px;
            background-color: #333;
            color: #fff;
        }
        
        .logo {
            font-size: 24px;
            font-weight: bold;
        }

        .nav-links {
            position: absolute;
            top: 20px;
            right: 20px;
        }

        .nav-links a {
            color: #fff;
            text-decoration: none;
            margin-right: 20px;
        }
        </style>
    </head>
    <body>
        <div class="header">
        <div class="logo">Recipe App</div>
        <div class="nav-links">
            <a href="RecipeSearch">Home</a>
            <a href="recipes">Recipes</a>
        </div>
    </div>
    </body>
</html>
