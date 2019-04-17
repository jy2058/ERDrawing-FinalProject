package kr.or.ddit.ticket.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.map.HashedMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.ticket.model.TicketBuyHistVo;
import kr.or.ddit.ticket.model.TicketVo;
import kr.or.ddit.ticket.service.ITicketService;

@RequestMapping("ticket")
@Controller
public class TicketController {
	
	@Resource(name="ticketService")
	private ITicketService ticketService;
	
	private Logger logger = LoggerFactory.getLogger(TicketController.class);

	@RequestMapping("ticketList")
	public String ticketList(Model model){
	model.addAttribute("ticketList", ticketService.getAllTicketList());
		return "ticket";
	}
	
	@RequestMapping("CallPaymentKakaoPaySuccess")
	public String CallPaymentKakaoPaySuccess(Model model){
	model.addAttribute("next_redirect_pc_url", "/ticket/CallPay");
		return "jsonView";
	}
	
	@RequestMapping("CallPay")
	public String CallPay(Model model){
		return "ticket/ticketBuy";
	}
	
	//티켓수정정보요청
	@RequestMapping("ticketModify")
	public String ticketModify(Model model,String ticketNo){
		TicketVo ticketVo =  ticketService.selectTicket(ticketNo);
		model.addAttribute("ticketVo", ticketVo);
		return "jsonView";
	}
	
	//티켓정수정
	@RequestMapping("modifyTicket")
	public String modifyTicket(Model model,TicketVo ticketVo,RedirectAttributes ra,HttpServletRequest req){
		logger.debug("======modify{}",ticketVo);
		int updCnt = ticketService.updateTicket(ticketVo);
		
		if(updCnt>0){
			ra.addFlashAttribute("msg", "수정이 완료되었습니다.");
		}else{
			ra.addFlashAttribute("msg", "수정이 실패 하였습니다.");
		}
		
		model.addAttribute("ticketList", ticketService.getAllTicketList());
		return "redirect:" + req.getContextPath() +"/ticket/ticketList";
	}
	
	@RequestMapping("deleteTicket")
	public String deleteTicket(Model model,TicketVo ticketVo,String ticketNo,RedirectAttributes ra,HttpServletRequest req){
		logger.debug("======delete{}",ticketVo);
		
		int delCnt = ticketService.deleteTicket(ticketNo);
		
		if(delCnt>0){
			ra.addFlashAttribute("msg", "티켓이 삭제되었습니다.");
		}else{
			ra.addFlashAttribute("msg", "실패하였습니다.");
		}
		
		model.addAttribute("ticketList", ticketService.getAllTicketList());
		return "redirect:" + req.getContextPath() +"/ticket/ticketList";
	}
	
	
	//티켓추가
	@RequestMapping("insertTicket")
	public String insertTicket(Model model,TicketVo ticketVo,RedirectAttributes ra,HttpServletRequest req){
		logger.debug("======insertTicket{}",ticketVo);
		int inCnt = ticketService.insertTicket(ticketVo);
		
		if(inCnt >0){
			ra.addFlashAttribute("msg", "추가 되었습니다.");
		}else{
			ra.addFlashAttribute("msg", "실패 하였습니다.");
		}
		
		model.addAttribute("ticketList", ticketService.getAllTicketList());
		return "redirect:" + req.getContextPath() +"/ticket/ticketList";
	}
		
		//티켓차트 페이지
		@RequestMapping("ticketChart")
		public String ticketChart(Model model,TicketVo ticketVo,RedirectAttributes ra,HttpServletRequest req){
			List<TicketBuyHistVo> ticketBuyHistList = ticketService.selectTicketYearList("3");
			getCanvasjsDataListLine(ticketBuyHistList);
			  String dt = ticketBuyHistList.get(0).getTicketMonDt();
		
			  
			  logger.debug("===yyyy{}",dt.substring(0, 4));
			  logger.debug("===mm{}",dt.substring(4, 6));
			  
			  
			return "ticketChart";
		}
		
		public List<List<Map<Object, Object>>> getCanvasjsDataListLine( List<TicketBuyHistVo> ticketBuyList){
			 Map<Object,Object> map = null;
			 List<List<Map<Object,Object>>> list = new ArrayList<List<Map<Object,Object>>>();
			 List<Map<Object,Object>> dataPoints1 = new ArrayList<Map<Object,Object>>();
			 for(TicketBuyHistVo vo : ticketBuyList){
				 String subDateYy = vo.getTicketMonDt().substring(0, 4);
				 String subDateMm = vo.getTicketMonDt().substring(4, 6);
				 int to = Integer.parseInt(subDateYy);
				 int to2 = Integer.parseInt(subDateMm);
				 
				 map = new HashMap<Object,Object>();
				 map.put("y", vo.getTicketFee()); 
				 map.put("x", new Date(to, to2, 01));
				 dataPoints1.add(map);
			 }
				list.add(dataPoints1);
			return list;
		}
		
		
		
		
		
		
		
		//티켓차트(pie) 페이지
				@RequestMapping("ticketPie")
				public String ticketPie(Model model,TicketVo ticketVo,RedirectAttributes ra,HttpServletRequest req,ModelMap modelMap){
					Map<String, Object> ticketmap = new HashMap<>();
					ticketmap.put("yyyy", "2019");
					ticketmap.put("ticketNo", 2);
					
					List<TicketBuyHistVo> ticketBuyHistList = ticketService.selectTicketMonthList(ticketmap);
					
					if(ticketBuyHistList!=null){
						List<List<Map<Object, Object>>> canvasjsDataList =getCanvasjsDataListPie(ticketBuyHistList);
						modelMap.addAttribute("dataPointsList", canvasjsDataList);
					}
					model.addAttribute("ticketBuyHistList", ticketBuyHistList );
					return "ticketPie";
				}
				
		//pie		
		public List<List<Map<Object, Object>>> getCanvasjsDataListPie(List<TicketBuyHistVo> ticketBuyHistList){
			 Map<Object,Object> map = null;
			 List<List<Map<Object,Object>>> list = new ArrayList<List<Map<Object,Object>>>();
			 List<Map<Object,Object>> dataPoints1 = new ArrayList<Map<Object,Object>>();
			 
			 for(TicketBuyHistVo vo : ticketBuyHistList){
			 	map = new HashMap<Object,Object>(); map.put("label", "test"+vo.getTicketMonDt()); map.put("y", vo.getTicketFee());dataPoints1.add(map);
			 }
				list.add(dataPoints1);
			return list;
		}
}
