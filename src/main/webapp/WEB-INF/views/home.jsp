<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Topics</title>
    <style><%@include file="../../css/style.css"%></style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        .quiz-topic {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 5px;
            background-color:#9ddcd6ba;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .quiz-topic:hover {
            background-color: #f0f0f0;
        }

        .quiz-topic i {
            font-size: 24px; /* Makes the icon bigger */
            margin-right: 10px;
            flex-shrink: 0; /* Prevents the icon from shrinking */
        }

        .quiz-topic span {
            font-size: 20px; /* Bigger font for the topic name */
        }
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    <div class="container">
        <h2 style="margin-bottom: 20px;"><i class="fa-solid fa-rectangle-list" style="margin-right: 10px;"></i> Quiz Topics</h2>
        <% 
        List<com.online.quiz.model.QuizTopic> quizTopics = (List<com.online.quiz.model.QuizTopic>) request.getAttribute("quizTopics");
        for (com.online.quiz.model.QuizTopic quizTopic : quizTopics) { %>
            <div class="quiz-topic" onclick="redirectToQuiz('<%= quizTopic.getId() %>')"> 
            <% if(quizTopic.getTopicName().equals("Maps Quiz")){%> 
                <i class="fa-solid fa-map-location-dot"></i>
            <% } if(quizTopic.getTopicName().equals("Cricket Quiz")){%> 
                <i class="fa-solid fa-baseball-bat-ball"></i>
            <% } if(quizTopic.getTopicName().equals("Space Quiz")){%> 
                <i class="fa-solid fa-satellite"></i>
            <% } %>
                <span><%= quizTopic.getTopicName() %></span>
            </div>
        <% } %>
    </div>

    <script>
        function redirectToQuiz(topicId) {
            window.location.href = "question/" + topicId;
        }
    </script>
</body>
</html>
