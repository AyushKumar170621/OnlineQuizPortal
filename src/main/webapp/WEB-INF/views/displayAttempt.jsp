<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Attempts</title>
    <style><%@include file="../../css/style.css"%></style>
    <style>
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
            text-align:left;
        }
        tr:hover {
            background-color: #f9f9f9;
        }
        #timer {
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
            background-color: #007bff;
            color: #fff;
            padding: 10px;
            border-radius: 5px;
        }
       </style>
</head>
<body>
	<jsp:include page="navbar.jsp" />
    <div class="container">
        <h2>Quiz Attempts</h2>
        <table class="attempt-table">
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
