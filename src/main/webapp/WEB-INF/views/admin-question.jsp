<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Questions</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        /* Styling for the page */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #333;
        }

        .question-container {
            border: 1px solid #ddd;
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 5px;
            background-color: #f9f9f9;
            position: relative;
        }

        .form-container, .question-container input[type="text"], .question-container .option {
            width: calc(100% - 30px);
            margin-top: 10px;
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .option-container {
            display: flex;
            align-items: center;
            margin-top: 5px;
        }

        .option-container label {
            flex: 1;
            margin-right: 10px;
        }

        .actions {
            position: absolute;
            right: 10px;
            top: 10px;
        }

        .btn {
            cursor: pointer;
            color: #0056b3;
            font-size: 1em;
            margin-left: 10px;
            border: none;
            background: none;
        }

        .btn:hover {
            color: #d63484;
        }

        .save-cancel-buttons {
            margin-top: 10px;
        }

        /* Styling for add question form */
        .form-container {
            display: none;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f2f2f2;
            margin-bottom: 20px;
        }

        .form-container input[type="text"], .form-container .option {
            width: calc(100% - 30px);
            padding: 8px;
            margin-top: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .checkbox {
            margin-left: 10px;
        }
        .main-content {
            margin-left: 250px; /* Sidebar width */
            padding: 70px 20px 20px; /* Adjusted for navbar height */
        }

        .main-content h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp" />
<!-- Include the sidebar -->
<jsp:include page="sidebar.jsp"/>
<div class="main-content">
	<h2>Manage Questions</h2>
	
	<!-- Add Question Form -->
	<button onclick="toggleAddQuestionForm()">+ Add New Question</button>
	<div class="form-container" id="addQuestionForm">
	    <h3>Add New Question</h3>
	    <label for="newQuestionText">Question Text:</label>
	    <input type="text" id="newQuestionText" placeholder="Enter question text" required>
	
	    <!-- Options with checkboxes for correct answer selection -->
	    <div class="option-container">
	        <label>Option 1:</label>
	        <input type="text" id="option1" placeholder="Enter option 1" required>
	        <input type="checkbox" id="answer1" class="checkbox"> Correct
	    </div>
	    <div class="option-container">
	        <label>Option 2:</label>
	        <input type="text" id="option2" placeholder="Enter option 2" required>
	        <input type="checkbox" id="answer2" class="checkbox"> Correct
	    </div>
	    <div class="option-container">
	        <label>Option 3:</label>
	        <input type="text" id="option3" placeholder="Enter option 3" required>
	        <input type="checkbox" id="answer3" class="checkbox"> Correct
	    </div>
	    <div class="option-container">
	        <label>Option 4:</label>
	        <input type="text" id="option4" placeholder="Enter option 4" required>
	        <input type="checkbox" id="answer4" class="checkbox"> Correct
	    </div>
	
	    <button class="btn" onclick="submitNewQuestion(<%=request.getAttribute("quizId") %>)">Submit</button>
	    <button class="btn" onclick="toggleAddQuestionForm()">Cancel</button>
	</div>
	<div id="question-list">
	    <%
	        List<com.online.quiz.model.Question> questions = (List<com.online.quiz.model.Question>) request.getAttribute("questions");
	        if (questions != null && !questions.isEmpty()) {
	            for (com.online.quiz.model.Question question : questions) {
	    %>
	                <div class="question-container" data-id="<%= question.getId() %>">
	                    <!-- Question Text and Options (Editable when Edit is clicked) -->
	                    <input type="text" value="<%= question.getQuestionText() %>" readonly />
	
	                    <!-- Options -->
	                    <div class="option-container">
	                        <label>Option 1:</label>
	                        <input type="text" value="<%= question.getOption1() %>" readonly />
	                        <input type="checkbox" id="editOption1<%=question.getId()%>" <%= question.getCorrectAnswer().contains(question.getOption1()) ? "checked" : "" %> disabled />
	                    </div>
	                    <div class="option-container">
	                        <label>Option 2:</label>
	                        <input type="text"  value="<%= question.getOption2() %>" readonly />
	                        <input type="checkbox" id="editOption2<%=question.getId()%>" <%= question.getCorrectAnswer().contains(question.getOption2()) ? "checked" : "" %> disabled />
	                    </div>
	                    <div class="option-container">
	                        <label>Option 3:</label>
	                        <input type="text" value="<%= question.getOption3() %>" readonly />
	                        <input type="checkbox" id="editOption3<%=question.getId()%>" <%= question.getCorrectAnswer().contains(question.getOption3()) ? "checked" : "" %> disabled />
	                    </div>
	                    <div class="option-container">
	                        <label>Option 4:</label>
	                        <input type="text" value="<%= question.getOption4() %>" readonly />
	                        <input type="checkbox" id="editOption4<%=question.getId()%>" <%= question.getCorrectAnswer().contains(question.getOption4()) ? "checked" : "" %> disabled />
	                    </div>
	
	                    <!-- Action Buttons -->
	                    <div class="actions">
	                        <button class="btn" onclick="editQuestion(this)">Edit</button>
	                        <button class="btn" onclick="deleteQuestion(<%= question.getId() %>)">Delete</button>
	                    </div>
	
	                    <!-- Save and Cancel Buttons (Hidden initially) -->
	                    <div class="save-cancel-buttons" style="display: none;">
	                        <button class="btn" onclick="saveQuestion(this, <%= question.getId() %>)">Save</button>
	                        <button class="btn" onclick="cancelEdit(this)">Cancel</button>
	                    </div>
	                </div>
	    <%
	            }
	        } else {
	    %>
	        <p>No questions available for this topic.</p>
	    <%
	        }
	    %>
	</div>
</div>

<script>
    // Toggle display of add question form
    function toggleAddQuestionForm() {
        const form = document.getElementById("addQuestionForm");
        form.style.display = form.style.display === "none" ? "block" : "none";
    }

    // Submit new question data
    function submitNewQuestion(quizID) {
        const questionText = document.getElementById("newQuestionText").value;
        const options = [
            document.getElementById("option1").value,
            document.getElementById("option2").value,
            document.getElementById("option3").value,
            document.getElementById("option4").value
        ];
        const correctAnswers = [];

        // Collect selected answers
        if (document.getElementById("answer1").checked) correctAnswers.push(document.getElementById("option1").value);
        if (document.getElementById("answer2").checked) correctAnswers.push(document.getElementById("option2").value);
        if (document.getElementById("answer3").checked) correctAnswers.push(document.getElementById("option3").value);
        if (document.getElementById("answer4").checked) correctAnswers.push(document.getElementById("option4").value);

        const data = {
            questionText: questionText,
            options: options,
            correctAnswer: correctAnswers.join(","),
            isMultichoice: correctAnswers.length > 1
        };

        // AJAX to send data to server (replace with your URL endpoint)
        fetch("/admin/addQuestion/"+quizID, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(data)
        })
        .then(response => response.json())
        .then(result => {
            if (result.success) {
                alert("Question added successfully!");
                toggleAddQuestionForm();
                location.reload(); // Reload page to show updated questions
            } else {
                alert("Failed to add question. Please try again.");
            }
        })
        .catch(error => console.error("Error:", error));
    }
</script>
<script>
    // Toggle edit mode for questions
    function editQuestion(button) {
        const container = button.closest('.question-container');
        const inputs = container.querySelectorAll('input[type="text"], input[type="checkbox"]');

        // Enable text fields and checkboxes
        inputs.forEach(input => {
            input.readOnly = false;
            if (input.type === "checkbox") {
                input.disabled = false;
            }
        });

        // Show save and cancel buttons
        container.querySelector('.save-cancel-buttons').style.display = 'block';
        container.querySelector('.actions').style.display = 'none';
    }

    function cancelEdit(button) {
        const container = button.closest('.question-container');
        const inputs = container.querySelectorAll('input[type="text"], input[type="checkbox"]');

        // Disable text fields and checkboxes
        inputs.forEach(input => {
            input.readOnly = true;
            if (input.type === "checkbox") {
                input.disabled = true;
            }
        });

        // Hide save and cancel buttons
        container.querySelector('.save-cancel-buttons').style.display = 'none';
        container.querySelector('.actions').style.display = 'block';
    }

    function saveQuestion(button, questionId) {
        const container = button.closest('.question-container');
        const inputs = container.querySelectorAll('input[type="text"], input[type="checkbox"]');
        const questionText = inputs[0].value;
        const options = [inputs[1].value, inputs[3].value, inputs[5].value, inputs[7].value];
        const optionsSel = [inputs[2].value, inputs[4].value, inputs[6].value, inputs[8].value];
        const correctAnswers = [];

        console.log(questionId);
        console.log((document.getElementById('editOption1'+questionId).checked));
        console.log((document.getElementById('editOption2'+questionId).checked));
        console.log((document.getElementById('editOption3'+questionId).checked));
        console.log((document.getElementById('editOption4'+questionId).checked));
     	// Collect selected answers
        if (document.getElementById('editOption1'+questionId).checked) correctAnswers.push(options[0]);
        if (document.getElementById('editOption2'+questionId).checked) correctAnswers.push(options[1]);
        if (document.getElementById('editOption3'+questionId).checked) correctAnswers.push(options[2]);
        if (document.getElementById('editOption4'+questionId).checked) correctAnswers.push(options[3]);
        
		console.log(optionsSel);
        const data = {
            questionText: questionText,
            options: options,
            correctAnswer: correctAnswers.join(","),
            isMultichoice: correctAnswers.length > 1
        };
        console.log(data.correctAnswer);
        console.log(data.options);
     // AJAX request to update data on the server
        fetch("/admin/updateQuestion/"+questionId, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(data)
        })
        .then(response => response.json())
        .then(result => {
            if (result.success) {
            	console.log(result);
                alert(result.message);
                location.reload(); // Reload the page to show the updated question
            } else {
                alert(result.message);
            }
        })
        .catch(error => console.error("Error:", error));
        inputs.forEach(input => input.readOnly = true);
        container.querySelector('.save-cancel-buttons').style.display = 'none';
        container.querySelector('.actions').style.display = 'block';
    }

    function deleteQuestion(questionId) {
        if (confirm("Are you sure you want to delete this question?")) {
        	// AJAX request to update data on the server
            fetch("/admin/deleteQuestion/"+questionId, {
            	method: 'DELETE', 
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error("Error deleting question");
                }
                return response.text();
            })
            .then(message => {
                alert(message);
                // Remove the question from the DOM after successful deletion
                location.reload();
            })
            .catch(error => {
                console.error('Error:', error);
                alert("An error occurred: " + error.message);
            });
        }
    }

</script>

</body>
</html>
