package kr.or.ddit.api.chatbot;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ibm.watson.developer_cloud.assistant.v1.Assistant;
import com.ibm.watson.developer_cloud.assistant.v1.model.InputData;
import com.ibm.watson.developer_cloud.assistant.v1.model.MessageOptions;
import com.ibm.watson.developer_cloud.assistant.v1.model.MessageResponse;
import com.ibm.watson.developer_cloud.service.security.IamOptions;

@RequestMapping("/chatbot")
@Controller
public class ChatbotController {
	
	private Logger logger = LoggerFactory.getLogger(ChatbotController.class);
	

	
	@RequestMapping(path = "/chatbot")
	public String login(Model model, HttpSession session) {
		IamOptions iamOptions = new IamOptions.Builder().apiKey("Rvy0XPi7YkMsaVk2MkZU5iVeSBv67fFl0EKlonub6hZL").build();
		Assistant service = new Assistant("2019-02-28", iamOptions);
		service.setEndPoint("https://gateway-tok.watsonplatform.net/assistant/api");

		String workspaceId = "2721d597-8f79-42f2-bc70-1fd348f64602";
		InputData input = new InputData.Builder("안녕").build();

		MessageOptions options = new MessageOptions.Builder(workspaceId)
		  .input(input)
		  .build();

		MessageResponse response = service.message(options).execute();
		logger.debug("====son{}",response);
		System.out.println(response);
		return "chatbot";
	}
	
}