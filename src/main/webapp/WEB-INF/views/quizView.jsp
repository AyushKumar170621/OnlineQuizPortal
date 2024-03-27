<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz</title>
</head>
<body>
<h2>Quiz</h2>
<form action="submitQuiz" method="post">
    <%-- Assume questions is a List<Question> attribute --%>
    <% List<com.online.quiz.model.Question> questions = (List<com.online.quiz.model.Question>) request.getAttribute("questions");
        for (com.online.quiz.model.Question question : questions) {
    %>
    <p><%= question.getQuestionText() %></p>
    <% if (question.isMultichoice()) { %>
        <%-- For multi-choice questions, use checkboxes --%>
        <input type="checkbox" name="answer_<%= question.getId() %>" value="<%= question.getOption1() %>"> <%= question.getOption1() %><br>
        <input type="checkbox" name="answer_<%= question.getId() %>" value="<%= question.getOption2() %>"> <%= question.getOption2() %><br>
        <input type="checkbox" name="answer_<%= question.getId() %>" value="<%= question.getOption3() %>"> <%= question.getOption3() %><br>
        <input type="checkbox" name="answer_<%= question.getId() %>" value="<%= question.getOption4() %>"> <%= question.getOption4() %><br>
    <% } else { %>
        <%-- For single-choice questions, use radio buttons --%>
        <input type="radio" name="answer_<%= question.getId() %>" value="<%= question.getOption1() %>"> <%= question.getOption1() %><br>
        <input type="radio" name="answer_<%= question.getId() %>" value="<%= question.getOption2() %>"> <%= question.getOption2() %><br>
        <input type="radio" name="answer_<%= question.getId() %>" value="<%= question.getOption3() %>"> <%= question.getOption3() %><br>
        <input type="radio" name="answer_<%= question.getId() %>" value="<%= question.getOption4() %>"> <%= question.getOption4() %><br>
    <% }
        }
    %>
    <input type="submit" value="Submit">
</form>
</body>
</html>
