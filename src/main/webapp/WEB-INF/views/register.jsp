<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style><%@include file="../../css/styles.css"%></style>
</head>
<body>
    <div class="container">
    	<% if (request.getAttribute("successMessage") != null) { %>
        <div class="success-message">
            <%= request.getAttribute("successMessage") %>
        </div>
    <% } %>
    <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="error-message">
            <%= request.getAttribute("errorMessage") %>
        </div>
    <% } %>
        <h2><i class="fa-solid fa-users"></i> Register</h2>
        <form action="register" method="post">
            <div class="input-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="input-group">
             	<label for="fullName">Full Name:</label>
                <input type="text" id="fullName" name="fullName" required><br>
            </div>
            <button type="submit"><i class="fa-solid fa-user-plus"></i> Register</button>
        </form>
        <div class="login-link">
            <a href="/login">Login</a>
        </div>
    </div>
</body>
</html>
