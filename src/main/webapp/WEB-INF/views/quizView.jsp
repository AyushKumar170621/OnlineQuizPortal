<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style><%@include file="../../css/style.css"%></style>
    <style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        padding: 20px;
        line-height: 1.6;
    }

    h2 {
        color: #333;
        margin-bottom: 20px;
    }

    form {
        max-width: 800px;
        background: #ACFADF;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    p {
        margin: 20px 0;
        font-size: 18px;
        color: #555;
    }

    input[type="checkbox"], input[type="radio"] {
        margin-right: 10px;
        transform: scale(1.2);
    }

    label {
        margin-bottom: 12px;
        display: block;
        cursor: pointer;
    }

    button[type="submit"] {
        display: block;
        width: 100%;
        margin-top: 20px;
        padding: 15px;
        background-color: #007bff;
        color: #fff;
        font-size: 18px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    button[type="submit"]:hover {
        background-color: #0056b3;
    }

    /* Custom Checkboxes and Radios */
    .custom-checkbox, .custom-radio {
        position: relative;
        padding-left: 28px;
        cursor: pointer;
        display: inline-block;
        color: #444;
        line-height: 18px;
    }

    .custom-checkbox input[type="checkbox"], .custom-radio input[type="radio"] {
        position: absolute;
        opacity: 0;
        cursor: pointer;
    }

    .checkmark {
        position: absolute;
        top: 0;
        left: 0;
        height: 20px;
        width: 20px;
        background-color: #eee;
        border-radius: 4px;
    }

    .custom-radio .checkmark {
        border-radius: 50%;
    }

    .custom-checkbox input:checked ~ .checkmark, .custom-radio input:checked ~ .checkmark {
        background-color: #007bff;
    }

    .custom-checkbox .checkmark:after, .custom-radio .checkmark:after {
        content: "";
        position: absolute;
        display: none;
    }

    .custom-checkbox input:checked ~ .checkmark:after {
        display: block;
    }

    .custom-checkbox .checkmark:after {
        left: 7px;
        top: 3px;
        width: 5px;
        height: 10px;
        border: solid white;
        border-width: 0 3px 3px 0;
        transform: rotate(45deg);
    }

    .custom-radio .checkmark {
        background-color: #fff;
        border: 2px solid #ddd;
    }

    .custom-radio input:checked ~ .checkmark {
        background-color: #fff;
        border: 2px solid #007bff;
    }

    .custom-radio .checkmark:after {
        top: 50%;
        left: 50%;
        width: 10px;
        height: 10px;
        border-radius: 50%;
        background: #007bff;
        transform: translate(-50%, -50%);
        display: none;
    }

    .custom-radio input:checked ~ .checkmark:after {
        display: block;
    }
</style>

</head>
<body>
    <h2><i class="fa-solid fa-stopwatch"> Quiz Timer</i></h2>
    <div id="timer"></div>
    <h2><i class="fa-solid fa-clipboard-question"></i> Quiz</h2>
    <form id="quizForm" class="container" action="/question/submitQuiz" method="post">
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
        <button type="submit"><i class="fa-solid fa-arrow-up-from-bracket"></i> Submit</button>
    </form>
   <script>
   document.addEventListener('DOMContentLoaded', function() {
        const countdownTime = 30 * 60 * 1000; // 30 minutes * 60 seconds * 1000 milliseconds

        

        // Function to update the timer display
        function updateTimerDisplay(remainingTime) {
            const minutes = Math.floor(remainingTime / 60000);
            const seconds = Math.floor((remainingTime % 60000) / 1000); // Fixed
            console.log("Minutes:", minutes);
            console.log("Seconds:", seconds);
            document.getElementById('timer').innerHTML ='<i class="fa-solid fa-hourglass-start"></i>'+' ' +'Time remaining: ' + minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
        }

        // Function to handle the timer expiration
        function timerExpired() {
            alert('Time is up! Submitting the quiz.');
            document.getElementById('quizForm').submit(); // Submit the form
        }

        // Start the countdown timer
        const startTime = Date.now();
        const timerInterval = setInterval(() => {
            const elapsedTime = Date.now() - startTime;
            const remainingTime = countdownTime - elapsedTime;
            if (remainingTime <= 0) {
                clearInterval(timerInterval);
                timerExpired();
            } else {
                updateTimerDisplay(remainingTime);
            }
        }, 1000);
   });
    </script>
</body>
</html>
