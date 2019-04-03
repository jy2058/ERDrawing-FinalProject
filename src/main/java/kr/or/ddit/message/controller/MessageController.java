package kr.or.ddit.message.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/message")
@Controller
public class MessageController {
	private Logger logger = LoggerFactory.getLogger(MessageController.class);
	
	@RequestMapping("/messageView")
	public String messageView(){
		return "member/message";
	}

}
