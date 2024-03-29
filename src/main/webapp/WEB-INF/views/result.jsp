<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Score</title>
    <style><%@include file="../../css/style.css"%></style>
    <style>
        .score-info {
             margin: auto;
  			width: 50%;
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
            max-width: -webkit-fill-available;
        }
        scoreb{
        element.style {
    	margin: auto;
    	width: 30%;
    	text-align: center;
		}
    </style>
</head>
<body>
	<jsp:include page="navbar.jsp" />
    <div class="container">
        <h2><i class="fa-solid fa-square-poll-vertical"></i> Quiz Score</h2>
        <div class="score-info">
        	<div class="scoreb" >
	            <p>Hey <%= session.getAttribute("fname") %>,</p>
	            <p>Your Score: <%= request.getAttribute("score") %></p>
	            <p>Correct Answers: <%= request.getAttribute("correctAnswers") %></p>
	            <p>Wrong & unattempted: <%= request.getAttribute("incorrectAnswers") %></p>
            </div>
            <a href="/question/results" class="back-btn"><i class="fa-solid fa-circle-up"></i> Go to all previous records</a>
        </div>
        
    </div>
</body>
</html>
