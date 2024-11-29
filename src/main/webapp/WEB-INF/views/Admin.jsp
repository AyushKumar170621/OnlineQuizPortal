<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Panel - Quiz App</title>
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        /* Page Layout */
        body {
            display: flex;
            min-height: 100vh;
        }

        /* Main Content */
         .main-content {
            margin-left: 250px; /* Sidebar width */
            width: 100%;
            padding: 70px 20px 20px; /* Adjusted for navbar height */
        }

        .main-content h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        /* Content Sections */
        .section {
            margin: 20px;
        }
        
        table,.form-container {
            width: 100%;
            border-collapse: collapse;
            margin:10px 0;
            background-color:#F3F3E0;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .button-group button {
            padding: 5px 10px;
            margin: 0 5px;
            cursor: pointer;
        }
        .toggle-icon {
            cursor: pointer;
            font-size: 24px;
            margin-left: 10px;
            vertical-align: middle;
            color: #3498db;
        }
        .form-container {
            display: none; /* Initially hidden */
            margin-top: 15px;
        }
        .btn {
		    padding: 10px 20px;
		    font-size: 16px;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		    transition: background-color 0.3s ease, transform 0.3s ease;
		}
		
		/* Edit button styling */
		.edit {
		    background-color: #f39c12; /* Orange color */
		    color: white;
		}
		
		.edit:hover {
		    background-color: #e67e22; /* Darker orange on hover */
		    transform: scale(1.05); /* Slight zoom effect on hover */
		}
		
		/* Submit button styling */
		.submit {
		    background-color: #27ae60; /* Green color */
		    color: white;
		}
		
		.submit:hover {
		    background-color: #2ecc71; /* Lighter green on hover */
		    transform: scale(1.05); /* Slight zoom effect on hover */
		}
        
    </style>
    <script>
        function showSection(sectionId) {
            document.querySelectorAll('.section').forEach(section => {
                section.classList.remove('active');
            });
            document.getElementById(sectionId).classList.add('active');
        }
        function toggleForm() {
            const formContainer = document.getElementById("addQuizForm");
            formContainer.style.display = formContainer.style.display === "none" ? "block" : "none";
        }
    </script>
</head>
<body>
	<jsp:include page="navbar.jsp" />
    <!-- Include the sidebar -->
    <jsp:include page="sidebar.jsp"/>

    <!-- Main Content -->
    <div class="main-content">
        <h1>Welcome to the Admin Panel</h1>

        <!-- Section: Manage Quiz Topics and Questions -->
	    <div id="manageQuizTopics" class="section">
	        <h2>Manage Quiz Topics 
	            <span class="toggle-icon" onclick="toggleForm()">+</span>
	        </h2>
	
	        <!-- Toggleable form for adding a new quiz topic -->
	        <div id="addQuizForm" class="form-container">
	            <form action="AddQuizTopicServlet" method="POST">
	                <label for="quizTopic">New Quiz Topic Name:</label><br>
	                <input type="text" id="quizTopic" name="quizTopic" required>
	                <input type="submit" value="Add Topic">
	            </form>
	        </div>
	
	        <!-- Table displaying existing quiz topics with edit and delete options -->
	        <table>
	            <thead>
	                <tr>
	                    <th>Quiz Topic</th>
	                    <th>Actions</th>
	                </tr>
	            </thead>
	            <tbody>
	                 <!-- Populate quiz topics dynamically using JSP scriptlet -->
	                <% 
	                    List<com.online.quiz.model.QuizTopic> quizTopics = (List<com.online.quiz.model.QuizTopic>) request.getAttribute("quizTopics"); 
	                    if (quizTopics != null) {
	                        for (com.online.quiz.model.QuizTopic topic : quizTopics) {
	                %>
	                            <tr>
	                                <td><%= topic.getTopicName() %></td>
	                                <td>
	                                    <button class="btn edit" onclick="location.href='quizTopic/<%= topic.getId() %>'">Edit</button>
	                                    <form action="DeleteQuizTopicServlet" method="POST" style="display:inline;">
	                                        <input type="hidden" name="topicId" value="<%= topic.getId() %>">
	                                        <button class="btn submit" type="submit">Delete</button>
	                                    </form>
	                                </td>
	                            </tr>
	                <% 
	                        }
	                    } else { 
	                %>
	                        <tr>
	                            <td colspan="2">No quiz topics available</td>
	                        </tr>
	                <% 
	                    } 
	                %>
	            </tbody>
	        </table>
	    </div>

        
    </div>

</body>
</html>
