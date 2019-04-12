package kr.or.ddit.ticket.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

}
