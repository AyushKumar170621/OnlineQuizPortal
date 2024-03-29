<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Quiz Portal</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        body {
            margin: 0;
            padding:0;
            font-family: Arial, sans-serif;
        }

        .navbar {
            overflow: hidden;
            background-color: #333;
        }

        .navbar a {
            float: left;
            display: block;
            color: #f2f2f2;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
        }

        .navbar a:hover {
            background-color: #ddd;
            color: black;
        }

        .active {
            background-color: #04AA6D;
        }
		.active-link{
			color:#D63484;
		}
        .navbar-right {
            float: right;
        }

        @media screen and (max-width: 600px) {
            .navbar a {
                float: none;
                display: block;
                text-align: left;
            }
            .navbar-right {
                float: none;
            }
        }
    </style>
</head>
<body>

<div class="navbar">
    <a class="active"><i class="fa-solid fa-brain"></i> Online Quiz Portal</a>
    <a href="/home" ><i class="fa-solid fa-house"></i> Home</a>
    <a href="/question/results"><i class="fa-solid fa-list"></i> Previous Attempts</a>
    <div class="navbar-right">
    	<a><i class="fa-solid fa-user-tie"></i> <%= session.getAttribute("fname") %></a>
        <a href="/logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
    </div>
</div>


</body>
</html>
