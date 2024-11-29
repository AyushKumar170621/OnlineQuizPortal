<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style><%@include file="../../css/styles.css"%></style>
</head>
<body>
    <div class="container">
	<%if(request.getAttribute("errorMessage") != null)
	{%>
		<div id="errorMessage" class="error-message"><%= request.getAttribute("errorMessage") %> </div>
	<%}
	%>
	<% if (request.getAttribute("successMessage") != null) { %>
        <div class="success-message">
            <%= request.getAttribute("successMessage") %>
        </div>
    <% } %>
    
        <h2><i class="fa-solid fa-user"></i> Login</h2>
        <form action="login" method="post">
            <div class="input-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit"><i class="fa-solid fa-right-to-bracket"></i> Login</button>
        </form>
        <div class="register-link">
            <a href="/register">Register</a>
        </div>
    </div>
</body>
</html>
