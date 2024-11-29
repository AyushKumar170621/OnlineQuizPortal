<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Quiz Attempts Results</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        /* General Styling */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .content {
            margin-left: 250px; /* Adjust if there's a sidebar */
            padding: 70px 20px; /* Padding to avoid navbar overlap */
        }

        h2 {
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        th {
            background-color: #f2f2f2;
            text-align: left;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        .center {
            text-align: center;
        }
    </style>
</head>
<body>
<jsp:include page="navbar.jsp" />
   <!-- Include the sidebar -->
   <jsp:include page="sidebar.jsp"/>
<div class="content">
    <h2>Show All User Results</h2>
    <table>
        <tr>
            <th class="center">Attempt ID</th>
            <th class="center">User Name</th>
            <th class="center">Quiz Name</th>
            <th class="center">Attempted At</th>
            <th class="center">Score</th>
        </tr>
        
        <!-- Java Code to Dynamically Populate Rows -->
        <%
            List<com.online.quiz.model.QuizAttempts> attempts = (List<com.online.quiz.model.QuizAttempts>) request.getAttribute("attempts");
            if (attempts != null && !attempts.isEmpty()) {
                for (com.online.quiz.model.QuizAttempts attempt : attempts) {
        %>
                    <tr>
                        <td class="center"><%= attempt.getAttemptID() %></td>
                        <td class="center"><%= attempt.getUser().getFullName() %></td> <!-- Assuming Users model has getName() method -->
                        <td class="center"><%= attempt.getQuizTopic().getTopicName() %></td>
                        <td class="center"><%= attempt.getScore() %></td>
                        <td class="center"><%= attempt.getAttemptedAt() %></td>
                    </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="5" class="center">No quiz attempts found.</td>
            </tr>
        <%
            }
        %>
    </table>
</div>

</body>
</html>
