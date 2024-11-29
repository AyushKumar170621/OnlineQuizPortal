<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Access Denied</title>
</head>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f2f2f2;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 600px;
    margin: 100px auto;
    padding: 20px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    text-align: center;
}

h1 {
    color: #d9534f; /* Bootstrap danger color */
}

p {
    font-size: 18px;
    color: #555;
}

a {
    display: inline-block;
    margin-top: 20px;
    padding: 10px 20px;
    background-color: #5bc0de; /* Bootstrap info color */
    color: white;
    text-decoration: none;
    border-radius: 5px;
}

a:hover {
    background-color: #31b0d5; /* Darker shade on hover */
}

</style>
<body>
    <div class="container">
        <h1>Access Denied</h1>
        <p>You do not have permission to access this page.</p>
        <a href="${pageContext.request.contextPath}/home">Return to Home</a>
    </div>
</body>
</html>
