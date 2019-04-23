package kr.or.ddit.erd.controller;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.ddit.erd.model.DomainVo;
import kr.or.ddit.erd.service.IErdDrawingService;
import kr.or.ddit.erdhistory.model.ErdHistVo;

@RequestMapping("/erddrawing")
@Controller
public class ErdDrawingController {
	private Logger logger = LoggerFactory.getLogger(ErdDrawingController.class);
	
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
	
	@RequestMapping(path="/erdHistInsert", method=RequestMethod.POST)
	public String erdHistInser(ErdHistVo erdHistVo){
		erdDrawingService.erdHistInsert(erdHistVo);
		
		return "jsonView";
	}
	
	@RequestMapping(path="erdMaxHistSelect", method=RequestMethod.POST)
	public String erdMaxHistSelect(Model model, int erdNo){
		ErdHistVo vo = erdDrawingService.erdMaxHistSelect(erdNo);
		model.addAttribute("erdHistVo", vo);
		return "jsonView";
	}
	
}