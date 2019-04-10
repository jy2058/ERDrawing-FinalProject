package kr.or.ddit.ticket.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.ticket.service.ITicketService;

@RequestMapping("ticket")
@Controller
public class TicketController {
	
	@Resource(name="ticketService")
	private ITicketService ticketService;

	@RequestMapping("ticketList")
	public String library(Model model){
	model.addAttribute("ticketList", ticketService.getAllTicketList());
		return "ticket";
	}

}
