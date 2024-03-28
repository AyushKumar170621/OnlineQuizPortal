<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Score</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
            text-align: center;
        }
        .score-info {
            margin-bottom: 20px;
        }
        .score-info p {
            margin: 5px 0;
        }
        .back-btn {
            display: block;
            width: 100%;
            padding: 10px;
            margin-top: 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            text-align: center;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Quiz Score</h2>
        <div class="score-info">
            <p>Hey <%= request.getAttribute("name") %>,</p>
            <p>Your Score: <%= request.getAttribute("score") %></p>
            <p>Correct Answers: <%= request.getAttribute("correctAnswers") %></p>
            <p>Incorrect or unattempted Answers: <%= request.getAttribute("incorrectAnswers") %></p>
        </div>
        <a href="/results" class="back-btn">Back to Quiz</a>
    </div>
</body>
</html>
