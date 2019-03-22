package kr.or.ddit.erd.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.erd.model.ErdVo;

@RequestMapping("/erd")
@Controller
public class ErdController {
	private Logger logger = LoggerFactory.getLogger(ErdController.class);
	
	@RequestMapping(path = { "/erdAdd" }, method = { RequestMethod.POST })
	public String makeErd(ErdVo erdVo){
		logger.debug("======erdVo{} : ", erdVo.getErdTitle());
		return "mypage";
	}

}
