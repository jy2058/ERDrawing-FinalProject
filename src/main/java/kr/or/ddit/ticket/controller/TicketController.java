package kr.or.ddit.ticket.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.HashedMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.member.model.MemberVo;
import kr.or.ddit.ticket.model.TicketBuyHistVo;
import kr.or.ddit.ticket.model.TicketVo;
import kr.or.ddit.ticket.service.ITicketService;

@RequestMapping("/ticket")
@Controller
public class TicketController {
   
   @Resource(name="ticketService")
   private ITicketService ticketService;
   
   private Logger logger = LoggerFactory.getLogger(TicketController.class);

   @RequestMapping("/ticketList")
   public String ticketList(Model model){
   model.addAttribute("ticketList", ticketService.getAllTicketList());
      return "ticket";
   }
   
   @RequestMapping("/CallPaymentKakaoPaySuccess")
   public String CallPaymentKakaoPaySuccess(Model model){
   model.addAttribute("next_redirect_pc_url", "/ticket/CallPay");
      return "jsonView";
   }
   
   @RequestMapping("/CallPay")
   public String CallPay(Model model){
      return "ticket/ticketBuy";
   }
   
   //티켓수정정보요청
   @RequestMapping("/ticketModify")
   public String ticketModify(Model model,String ticketNo){
      TicketVo ticketVo =  ticketService.selectTicket(ticketNo);
      model.addAttribute("ticketVo", ticketVo);
      return "jsonView";
   }
   
   //티켓정수정
   @RequestMapping("/modifyTicket")
   public String modifyTicket(Model model,TicketVo ticketVo,RedirectAttributes ra,HttpServletRequest req,MultipartFile profileImg) throws IllegalStateException, IOException{
      logger.debug("======modify{}",ticketVo);
      
      
      TicketVo vo = ticketService.selectTicket(ticketVo.getTicketNo()+"");

		String realFilename = vo.getTicketImg();
		
		//수정할 이미지가 있을경우
		if (profileImg.getSize() > 0) {
			String filename = profileImg.getOriginalFilename();
			realFilename = "d:\\picture\\" + UUID.randomUUID() + filename;

			profileImg.transferTo(new File(realFilename));
		}
		
		ticketVo.setTicketImg(realFilename);
      
      int updCnt = ticketService.updateTicket(ticketVo);
      
      if(updCnt>0){
         ra.addFlashAttribute("msg", "수정이 완료되었습니다.");
      }else{
         ra.addFlashAttribute("msg", "수정이 실패 하였습니다.");
      }
      
      model.addAttribute("ticketList", ticketService.getAllTicketList());
      return "redirect:" + req.getContextPath() +"/ticket/ticketList";
   }
   
   @RequestMapping("/deleteTicket")
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
   
   
	// 티켓추가
	@RequestMapping("/insertTicket")
	public String insertTicket(Model model, TicketVo ticketVo, RedirectAttributes ra, HttpServletRequest req) {
		logger.debug("======insertTicket{}", ticketVo);
		int inCnt = ticketService.insertTicket(ticketVo);

		if (inCnt > 0) {
			ra.addFlashAttribute("msg", "추가 되었습니다.");
		} else {
			ra.addFlashAttribute("msg", "실패 하였습니다.");
		}
		model.addAttribute("ticketList", ticketService.getAllTicketList());
		return "redirect:" + req.getContextPath() + "/ticket/ticketList";
	}
      
	// 티켓차트 페이지
	@RequestMapping("/ticketChart")
	public String ticketChart(Model model, TicketVo ticketVo, RedirectAttributes ra, HttpServletRequest req,
			ModelMap modelMap) throws ParseException {
		List<TicketBuyHistVo> ticketBuyHistList = ticketService.selectTicketYearList("3");

		if (ticketBuyHistList != null) {
			List<List<Map<Object, Object>>> canvasjsDataList = getCanvasjsDataListLine(ticketBuyHistList);
			modelMap.addAttribute("dataPointsList", canvasjsDataList);
			logger.debug("====list{}", canvasjsDataList);
		}
		model.addAttribute("ticketBuyHistList", ticketService.getAllTicketList());

		return "ticketChart";
	}
      
	public List<List<Map<Object, Object>>> getCanvasjsDataListLine(List<TicketBuyHistVo> ticketBuyList) throws ParseException {
		
		Map<Object, Object> map = null;
		List<List<Map<Object, Object>>> list = new ArrayList<List<Map<Object, Object>>>();
		List<Map<Object, Object>> dataPoints1 = new ArrayList<Map<Object, Object>>();
		
		List<TicketVo> allTicket = ticketService.getAllTicketList();
		
		for(int i=0; i<allTicket.size();i++){
			 ticketBuyList = ticketService.selectTicketYearList(allTicket.get(i).getTicketNo()+"");
			 if(ticketBuyList.size()>0){
			 for (TicketBuyHistVo vo : ticketBuyList) {
				SimpleDateFormat transFormat = new SimpleDateFormat("yyyyMMdd");
				Date tos = transFormat.parse(vo.getTicketMonDt() + "01");
				long dataLong = tos.getTime();
				
				map = new HashMap<Object, Object>();
				map.put("y"+i, vo.getTicketFee());
				map.put("x"+i, dataLong);
				map.put("showInLegend"+i, "true");
				map.put("name"+i, allTicket.get(i).getTicketContent());
				dataPoints1.add(map);
				}
			}
		}
		list.add(dataPoints1);
		return list;
	}
      
	// 티켓차트(pie) 페이지
	@RequestMapping("/ticketPie")
	public String ticketPie(Model model, TicketVo ticketVo, RedirectAttributes ra, HttpServletRequest req,
			ModelMap modelMap) {
		Map<String, Object> ticketmap = new HashMap<>();
		ticketmap.put("yyyy", "2019");
		ticketmap.put("ticketNo", 2);

		List<TicketBuyHistVo> ticketBuyHistList = ticketService.selectTicketMonthList(ticketmap);

		if (ticketBuyHistList != null) {
			List<List<Map<Object, Object>>> canvasjsDataList = getCanvasjsDataListPie(ticketBuyHistList);
			modelMap.addAttribute("dataPointsList", canvasjsDataList);
		}
		model.addAttribute("ticketBuyHistList", ticketBuyHistList);
		return "ticketPie";
	}
            
      //pie      
	public List<List<Map<Object, Object>>> getCanvasjsDataListPie(List<TicketBuyHistVo> ticketBuyHistList) {
		Map<Object, Object> map = null;
		List<List<Map<Object, Object>>> list = new ArrayList<List<Map<Object, Object>>>();
		List<Map<Object, Object>> dataPoints1 = new ArrayList<Map<Object, Object>>();

		for (TicketBuyHistVo vo : ticketBuyHistList) {
			map = new HashMap<Object, Object>();
			map.put("label", "test" + vo.getTicketMonDt());
			map.put("y", vo.getTicketFee());
			dataPoints1.add(map);
		}
		list.add(dataPoints1);
		return list;
	}
	
	
	 // imageView
	 @RequestMapping("/ticketImg")
	 public void ticketImg(HttpServletRequest req, HttpServletResponse resp, String ticketNo) throws IOException{
		 	// 1. 사용자 아이디 파라미터 확인
			// String userId = request.getParameter("userId");

			// 2. 해당 사용자 아이디로 사용자 정보 조회(realFilename)
		 	TicketVo tickerVo = ticketService.selectTicket(ticketNo);
		 	
		 	
			// 3-1. memImg 존재 할 경우
			// 3-1-1. 해당 경로의 파일을 FileInputStream으로 읽는다.
			FileInputStream fis;
			if (tickerVo != null && tickerVo.getTicketImg() != null) {
				fis = new FileInputStream(new File(tickerVo.getTicketImg()));
			}
			// 3-2. memImg 존재하지 않을 경우
			// 3-2-1. /image/noImg.png(application.getRealPath())
			else {
				ServletContext application = req.getServletContext();
				String noimgPath = application.getRealPath("/image/noImg.png");
				fis = new FileInputStream(new File(noimgPath));
			}
			// 4. FileInputStream을 response객체의 outputStream 객체에 write
			ServletOutputStream sos = resp.getOutputStream();

			byte[] buff = new byte[512];
			int len = 0;
			while ((len = fis.read(buff)) > -1) {
				sos.write(buff);
			}

			sos.close();
			fis.close();
		 	
	 }
	 
	 //티켓구매
	 @RequestMapping(path="/ticketCardBuy" ,method= { RequestMethod.POST })
	 public String ticketCardBuy(HttpServletRequest req ,int ticketNo,String memId){
		 logger.debug("======1{}",ticketNo);
//		 logger.debug("======2{}",memId);
		 if(memId != null && ticketNo != 0){
		 TicketBuyHistVo vo = new TicketBuyHistVo();
		 vo.setMemId(memId);
		 vo.setTicketNo(ticketNo);
		 ticketService.insertticketBuyHist(vo);
		 }
			return "redirect:" + req.getContextPath() + "/ticket/ticketList";
	 }
	
	
}