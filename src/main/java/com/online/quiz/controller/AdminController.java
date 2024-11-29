package com.online.quiz.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.online.quiz.model.Question;
import com.online.quiz.model.QuizAttempts;
import com.online.quiz.model.QuizTopic;
import com.online.quiz.model.RoleDTO;
import com.online.quiz.model.RoleUpdateRequest;
import com.online.quiz.model.Users;
import com.online.quiz.service.MyUserDetailsService;
import com.online.quiz.service.QuestionService;
import com.online.quiz.service.QuizAttemptsService;
import com.online.quiz.service.QuizServices;
import com.online.quiz.service.RoleService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	private QuizServices qService;
	@Autowired
	private MyUserDetailsService userService;
	@Autowired
	private QuizAttemptsService attemptService;
	@Autowired
	private QuestionService questionService;
	@Autowired
	private RoleService roleService;
	
	@GetMapping("/quiz")
	public ModelAndView AdminHome()
	{
		ModelAndView modelAndView = new ModelAndView();
        List<QuizTopic> quizTopics = qService.getAllQuizTopics();
        modelAndView.addObject("quizTopics", quizTopics);
        modelAndView.setViewName("Admin");
        return modelAndView;
	}
	
	@GetMapping("/users")
    public ModelAndView getUsers(
            @RequestParam(value = "role", required = false) String role,
            @RequestParam(value = "name", required = false) String name,
            @RequestParam(value = "email", required = false) String email) {

        ModelAndView modelAndView = new ModelAndView("users");
        List<Users> users;

        if (role != null || name != null || email != null) {
            users = userService.searchUsers(role, name, email);
        } else {
            users = userService.findAllUsers();
        }

        modelAndView.addObject("users", users);
        return modelAndView;
    }
	
	@GetMapping("/results")
	public ModelAndView AllResults()
	{
		ModelAndView modelAndView = new ModelAndView();
		List<QuizAttempts> attempts = attemptService.findAllQuizAttempts();
		modelAndView.addObject("attempts",attempts);
		modelAndView.setViewName("admin-result");
		return modelAndView;
	}
	
	@GetMapping("quizTopic/{id}")
	public ModelAndView AllQuentionUnderATopic(@PathVariable Long id)
	{
		ModelAndView modelAndView = new ModelAndView();
		List<Question> questions = questionService.getQuestionsByTopicId(id);
		modelAndView.addObject("questions",questions);
		modelAndView.addObject("quizId",id);
		modelAndView.setViewName("admin-question");
		return modelAndView;
	}
	
	@PostMapping("/addQuestion/{id}")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> saveQuestion(@PathVariable int id,@RequestBody Map<String, Object> questionData) {
	    Map<String, Object> response = new HashMap<>();

	    try {
	        // Extract data from request body
	        String questionText = (String) questionData.get("questionText");
	        List<String> options = (List<String>) questionData.get("options");
	        String correctAnswer = (String) questionData.get("correctAnswer");
	        boolean isMultichoice = (Boolean) questionData.get("isMultichoice");

	        // Create new Question object
	        Question question = new Question();
	        question.setQuestionText(questionText);
	        question.setOption1(options.get(0));
	        question.setOption2(options.get(1));
	        question.setOption3(options.get(2));
	        question.setOption4(options.get(3));
	        question.setCorrectAnswer(correctAnswer);
	        question.setMultichoice(isMultichoice);
	        question.setQuizTopic(qService.getQuiz(id));

	        // Save question using QuestionService
	        questionService.saveQuestion(question);

	        response.put("success", true);
	        response.put("message", "Question added successfully.");
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "Failed to add question: " + e.getMessage());
	    }

	    return ResponseEntity.ok(response);
	}
	
	@PutMapping("/updateQuestion/{id}")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> updateQuestion(@PathVariable int id, @RequestBody Map<String, Object> questionData) {
	    Map<String, Object> response = new HashMap<>();

	    try {
	        // Retrieve the existing question by ID
	        Question question = questionService.findQuestionById(id);
	        if (question == null) {
	            response.put("success", false);
	            response.put("message", "Question not found.");
	            return ResponseEntity.ok(response);
	        }

	        // Update question fields with new data
	        question.setQuestionText((String) questionData.get("questionText"));
	        List<String> options = (List<String>) questionData.get("options");
	        question.setOption1(options.get(0));
	        question.setOption2(options.get(1));
	        question.setOption3(options.get(2));
	        question.setOption4(options.get(3));
	        question.setCorrectAnswer((String) questionData.get("correctAnswer"));
	        question.setMultichoice((Boolean) questionData.get("isMultichoice"));
	        System.out.println(question.toString());
	        // Save the updated question
	        questionService.saveQuestion(question);

	        response.put("success", true);
	        response.put("message", "Question updated successfully.");
	    } catch (Exception e) {
	        response.put("success", false);
	        response.put("message", "Failed to update question: " + e.getMessage());
	    }

	    return ResponseEntity.ok(response);
	}
	
	@DeleteMapping("/deleteQuestion/{id}")
	public ResponseEntity<String> deleteQuestion(@PathVariable int id) {
	    try {
	        questionService.deleteQuestionById(id);  // Ensure questionService has a delete method
	        return ResponseEntity.ok("Question deleted successfully");
	    } catch (Exception e) {
	        return ResponseEntity.status(500).body("Error deleting question");
	    }
	}
	
	@GetMapping("/userRoles")
	@ResponseBody
    public Map<String, List<RoleDTO>> getUserRoles(@RequestParam("userId") int userId) {
		System.out.println("Inside req");
		Map<String, List<RoleDTO>> map = new HashMap<>();
		map.put("roles", roleService.getRolesWithAssignmentStatus(userId));
		System.out.println("Inside req");
		return map;
    }
	
	@PostMapping("/updateUserRoles")
    public ResponseEntity<String> updateUserRoles(@RequestBody RoleUpdateRequest request) {
        boolean isUpdated = userService.updateUserRoles(request.getUserId(), request.getRoleIds());
        System.out.println("after req");
        return isUpdated ? ResponseEntity.ok("Roles updated successfully") : ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating roles");
    }

}
