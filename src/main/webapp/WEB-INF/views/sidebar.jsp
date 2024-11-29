<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SideBar</title>
</head>
<style>
	/* sidebar.css */
	.sidebar {
            width: 250px;
            background-color: #333;
            color: #fff;
            position: fixed;
            top: 50px; /* Adjust based on navbar height */
            left: 0;
            height: 100%;
            padding-top: 20px;
            display: flex;
            flex-direction: column;
            z-index: 0;
        }

        .sidebar a {
            color: #fff;
            padding: 15px 20px;
            text-decoration: none;
            display: block;
            transition: background 0.3s;
        }

        .sidebar a:hover {
            background-color: #555;
        }

        .sidebar h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
            color: #f1c40f;
        }
        .sidebar a.active {
	    background-color: #555; /* Highlight active link */
	    font-weight: bold;
	}
	
	
</style>
<body>
	<div class="sidebar">
	    <h2>Admin Panel</h2>
	    <a href="/admin/quiz" id="manageQuizLink">Manage Quiz</a>
	    <a href="/admin/users" id="manageUsersLink">Manage Users</a>
	    <a href="/admin/results" id="showResultsLink">Show All User Results</a>
	</div>
	
	<script>
	    // Get the current path from the URL
	    const currentPath = window.location.pathname;
	    
	    // Check the URL and apply the 'active' class to the corresponding link
	    if (currentPath.includes('/quiz')) {
	        document.getElementById('manageQuizLink').classList.add('active');
	    } else if (currentPath.includes('/users')) {
	        document.getElementById('manageUsersLink').classList.add('active');
	    } else if (currentPath.includes('/results')) {
	        document.getElementById('showResultsLink').classList.add('active');
	    }
	</script>

	
</body>
</html>