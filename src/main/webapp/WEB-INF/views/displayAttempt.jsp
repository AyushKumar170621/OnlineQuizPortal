<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Attempts</title>
    <style>
        /* CSS styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Quiz Attempts</h2>
        <table>
            <thead>
                <tr>
                    <th>Quiz Name</th>
                    <th>Score</th>
                    <th>Attempted At</th>
                </tr>
            </thead>
            <tbody>
                <% 
                Map<Integer,String > mp = (Map<Integer,String>) request.getAttribute("nameMap");
                for (com.online.quiz.model.QuizAttempts attempt : (List<com.online.quiz.model.QuizAttempts>)request.getAttribute("quizAttempts")) { %>
                    <tr>
                        <td><%= mp.get(attempt.getQuizID()) %></td>
                        <td><%= attempt.getScore() %></td>
                        <td><%= attempt.getAttemptedAt() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</body>
</html>
