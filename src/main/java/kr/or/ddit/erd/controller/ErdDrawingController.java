package kr.or.ddit.erd.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.erd.model.DomainVo;
import kr.or.ddit.erd.service.IErdDrawingService;

@RequestMapping("/erddrawing")
@Controller
public class ErdDrawingController {
	
	@Resource(name="erdDrawingService")
	private IErdDrawingService erdDrawingService;
	
	@RequestMapping(path="/domainList", method=RequestMethod.GET)
	public String domainList(Model model, int erdNo){
		
		List<DomainVo> list = erdDrawingService.domainList(erdNo);
		model.addAttribute(list);
		
		return "jsonView";
	}
	

	@RequestMapping(path="/domainUpdate", method=RequestMethod.GET)
	public String domainUpdate(DomainVo domainVo){

		erdDrawingService.domainUpdate(domainVo);
		
		//model.addAttribute("updateNm",updateNm);
		
		return "jsonView";
	}
	
	
	@RequestMapping(path="/domainDelete", method=RequestMethod.GET)
	public String domainDelete(int domainNo){
		
		erdDrawingService.domainDelete(domainNo);
		
		return "jsonView";
	}
	
	
	
	@RequestMapping(path="/domainSearch", method=RequestMethod.GET)
	public String domainSearch(Model model, DomainVo domainVo){
		
		List<DomainVo> list = erdDrawingService.domainSearch(domainVo);
		model.addAttribute(list);
		
		return "jsonView";
	}
	
	
}
