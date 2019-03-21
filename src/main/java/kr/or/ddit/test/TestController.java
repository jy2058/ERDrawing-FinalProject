package kr.or.ddit.test;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController {

	
	@RequestMapping(path="/")
	public String test1(){
		return "main";
	}
	
	@RequestMapping(path="/test2")
	public String test2(){
		return "test2";
	}
	
	
	@RequestMapping(path="/library")
	public String library(){
		return "library";
	}
	
	
	@RequestMapping(path="/join")
	public String join(){
		return "join";
	}
	
	

	
	@RequestMapping(path="/mypage")
	public String mypage(){
		return "mypage";
	}
	
	@RequestMapping(path="/modify")
	public String modify(){
		return "modify";
	}
	
	
	@RequestMapping(path="/team")
	public String team(){
		return "team";
	}
	
	
}
