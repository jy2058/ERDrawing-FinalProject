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
	
	
}
