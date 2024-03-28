<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        h2 {
            color: #333;
            text-align: center;
        }
        form {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        p {
            margin: 10px 0;
        }
        input[type="checkbox"],
        input[type="radio"] {
            margin-right: 5px;
        }
        input[type="submit"] {
            display: block;
            width: 100%;
            margin-top: 10px;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<h2>Quiz</h2>
<form action="/question/submitQuiz" method="post">
    <%-- Assume questions is a List<Question> attribute --%>
    <% List<com.online.quiz.model.Question> questions = (List<com.online.quiz.model.Question>) request.getAttribute("questions");
        for (com.online.quiz.model.Question question : questions) {
    %>
    <p><%= question.getQuestionText() %></p>
    <% if (question.isMultichoice()) { %>
        <%-- For multi-choice questions, use checkboxes --%>
        <input type="hidden" name="questionId" value="<%= question.getId() %>">
        <input type="checkbox" name="selectedOptions<%= question.getId() %>" value="<%= question.getOption1() %>"> <%= question.getOption1() %><br>
        <input type="checkbox" name="selectedOptions<%= question.getId() %>" value="<%= question.getOption2() %>"> <%= question.getOption2() %><br>
        <input type="checkbox" name="selectedOptions<%= question.getId() %>" value="<%= question.getOption3() %>"> <%= question.getOption3() %><br>
        <input type="checkbox" name="selectedOptions<%= question.getId() %>" value="<%= question.getOption4() %>"> <%= question.getOption4() %><br>
    <% } else { %>
        <%-- For single-choice questions, use radio buttons --%>
        <input type="hidden" name="questionId" value="<%= question.getId() %>">
        <input type="radio" name="selectedOptions<%= question.getId() %>" value="<%= question.getOption1() %>"> <%= question.getOption1() %><br>
        <input type="radio" name="selectedOptions<%= question.getId() %>" value="<%= question.getOption2() %>"> <%= question.getOption2() %><br>
        <input type="radio" name="selectedOptions<%= question.getId() %>" value="<%= question.getOption3() %>"> <%= question.getOption3() %><br>
        <input type="radio" name="selectedOptions<%= question.getId() %>" value="<%= question.getOption4() %>"> <%= question.getOption4() %><br>
    <% }
        }
    %>
    <input type="hidden" name="quizId" value="${quizId}">
   <input type="hidden" name="username" value="${userId }"> 
    <input type="submit" value="Submit">
</form>
</body>
</html>
