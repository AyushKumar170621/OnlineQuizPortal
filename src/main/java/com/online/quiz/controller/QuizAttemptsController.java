package com.online.quiz.controller;

import com.online.quiz.model.Question;
import com.online.quiz.model.QuestionAnswerDTO;
import com.online.quiz.model.QuizAttempts;
import com.online.quiz.service.QuestionService;
import com.online.quiz.service.QuizAttemptsService;
import com.online.quiz.service.QuizServices;

import jakarta.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class QuizAttemptsController {
	private int total=10,correct=0;
    private final QuizAttemptsService quizAttemptsService;
    private final QuestionService questionService;
    private final QuizServices quizService;
    @Autowired
    public QuizAttemptsController(QuizAttemptsService quizAttemptsService, QuestionService questionService,QuizServices quizService) {
        this.quizAttemptsService = quizAttemptsService;
        this.questionService = questionService;
        this.quizService=quizService;
    }
    
    @PostMapping("/question/submitQuiz")
    public String submitQuiz(HttpServletRequest request,Model model) {
        // Extract form parameters
        int quizId = Integer.parseInt(request.getParameter("quizId"));
        String username = request.getParameter("username");

        // Extract selected options for each question
        List<QuestionAnswerDTO> questionAnswers = new ArrayList<>();
        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            if (paramName.startsWith("selectedOptions")) {
                String[] selectedOptions = request.getParameterValues(paramName);
                if (selectedOptions != null && selectedOptions.length > 0) {
                    String questionIdStr = paramName.substring("selectedOptions".length());
                    int questionId = Integer.parseInt(questionIdStr);
                    QuestionAnswerDTO questionAnswer = new QuestionAnswerDTO();
                    questionAnswer.setQuestionId(questionId);
                    questionAnswer.setSelectedOptions(Arrays.asList(selectedOptions));
                    questionAnswers.add(questionAnswer);
                }
            }
        }
        int totalScore = calculateScore(questionAnswers);
        model.addAttribute("score",totalScore);
        model.addAttribute("name",username);
        model.addAttribute("correctAnswers",correct);
    	model.addAttribute("incorrectAnswers",total-correct);
        quizAttemptsService.submitQuizAttempt(username, quizId, totalScore);
        return "result";
    }

    private int calculateScore(List<QuestionAnswerDTO> submission) {
    	int ans = 0;
    	correct=0;
    	for(QuestionAnswerDTO qdto : submission)
        {
        	Question qs = questionService.getAnswers(qdto.getQuestionId());
        	if(qs.isMultichoice())
        	{
        		String[] arr = qs.getCorrectAnswer().split(",");
        		for(int i=0;i<arr.length;i++)
                {
                    arr[i]=arr[i].trim();
                }
        		List<String> list = Arrays.asList(arr);
        		Collections.sort(list);
        		Collections.sort(qdto.getSelectedOptions());
        		if(list.equals(qdto.getSelectedOptions()))
        		{
        			ans+=5;
        			correct++;
        		}
        	}
        	else {
        		if(qs.getCorrectAnswer().equals(qdto.getAns()))
        		{
        			ans+=3;
        			correct++;
        		}	
    		}
        	
        }
        return ans; 
    }
    @GetMapping("question/results")
    public String showResults(Model model, @AuthenticationPrincipal UserDetails currentUser)
    {
    	List<QuizAttempts> lst = quizAttemptsService.getUserSubmissions(currentUser.getUsername());
    	Map<Integer,String> mp = new HashMap<>();
//    	for(QuizAttempts qat : lst)
//    	{
//    		int id =qat.getQuizTopic().getQuestions();
//    		mp.put( id , quizService.getQuiz(id).getTopicName());
//    	}
    	model.addAttribute("quizAttempts",lst);
    	model.addAttribute("nameMap",mp);
    	return "displayAttempt";
    }

}
