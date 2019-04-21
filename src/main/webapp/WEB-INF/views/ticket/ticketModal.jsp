<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <% %>
	
<!-- 티켓 수정.삭제 하는 모달창 띄우기 -->	
	<form id="frm" action="/ticket" method="post" enctype="multipart/form-data">
      <div class="modal modal-center fade" id="ticketModalEvnTest" tabindex="1" role="dialog" aria-labelledby="my80sizeCenterModalLabel" >
      <div class="modal-dialog modal-80size modal-center" role="document" >
         <div class="modal-content modal-80size">
            <div class="modal-header">
            <label>| Ticket</label>
               <button type="button" class="close" data-dismiss="modal"aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body">
               <div class="form-group">
                  <label class="modalLabels">Ticket No</label>  
                   <input   type="hidden" class="ticketContent" id="ticketNo"  name="ticketNo"/>
                  <div id="dupleCode"></div>
               </div>
               
                <div class="form-group">
                  <label class="modalLabels">TicketPrice</label> 
                  <input type="text" name="ticketPrice" id="ticketPrice" >    
               </div>   
        
            <div class="pass form-group">
                  <label class="modalLabels"  >ticketContent</label> 
                     <input   type="text" class="ticketContent" id="ticketContent" name="ticketContent"  />
               </div>
               
                <div class="pass form-group">
                  <label class="modalLabels"  >ticketImg</label> 
                  <img id="profileImg" src="" width="340" height="320" />
               </div>
               
               <div class="filebox img-btn btn-style1">
					<label  class="btn-style1" for="input_img">티켓 이미지 선택</label> 
					<input	type="file" id="input_img" name="profileImg" />
					
				</div>
               
               </div>   
               <div id="modalBtn" class="modal-footer">
                  <button type="button" id="insertBtn" class="btn btn-default" data-dismiss="modal">추가</button>
                  <button type="button" id="modifyBtn" class="btn btn-default" data-dismiss="modal">수정</button>
                  <button type="button" id="deleteBtn" class="btn btn-default" data-dismiss="modal">삭제</button>
                  <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
               </div>
            </div>
         </div>
      </div>
      </form>
      
      
      <!-- 티켓 구매 모달창 띄우기 -->	
	
      <div class="modal modal-center fade" id="modifyBuyModal" tabindex="1" role="dialog" aria-labelledby="my80sizeCenterModalLabel" >
      <div class="modal-dialog modal-80size modal-center" role="document" >
         <div class="modal-content modal-80size">
            <div class="modal-header">
            <label>| Buy Ticket</label>
               <button type="button" class="close" data-dismiss="modal"aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body">
            
               <div class="form-group">
                  <label class="modalLabels">결제 수단</label>  
                   <label><input type="radio" name="buychoose" value="mo" onclick="radioBtn_ch()"/> 무통장입금</label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   <label><input   type="radio" name="buychoose" value="sin" onclick="radioBtn_ch()"/>신용카드</label>
                  <div id="dupleCode"></div>
               </div>
               
                <!-- ======================== 신용카드 결제 화면 ========================-->	
                <form name="ATGAutoForm" id="cardFrm"  method="post">
                <div class="form-group" id="sinbuy">
                  <label class="modalLabels">신용카드 결제</label>
                	 <div class="frm-grp">
                        <label class="modalLabels">카드번호</label>
                        <div class="row label_slc1">
                            <span class="field1">
                                <input type="tel" width="10px" id="cardno1" name="cardno1" class="ipt_cardnumber" maxlength="4" style="font-size:16px;" onkeyup="if(this.value.length == 4) ATGAutoForm.cardno2.focus();">
                            </span>
                            <span class="field2 one-txt">-</span>
                            <span class="field2">
                                <input type="password" id="cardno2" name="cardno2" class="ipt_cardnumber" maxlength="4" style="font-size:16px;" onkeyup="if(this.value.length == 4) ATGAutoForm.cardno3.focus();">
                            </span>
                            <span class="field2 one-txt">-</span>
                            <span class="field2">
                                <input type="password" id="cardno3" name="cardno3" class="ipt_cardnumber" maxlength="4" style="font-size:16px;" onkeyup="if(this.value.length == 4) ATGAutoForm.cardno4.focus();">
                            </span>
                            <span class="field2 one-txt">-</span>
                            <span class="field2">
                                <input type="tel" id="cardno4" name="cardno4" class="ipt_cardnumber" maxlength="4" style="font-size:16px;">
                            </span>
                        </div>
                  
                    <div class="card_cbox">
                        <label class="label_tit">유효기간</label>
                        <div class="row label_slc2">
                            <span class="field2">
                                <select id="expmon" name="expmon">
                                    <option value="MM" selected="selected">MM</option>
                                    
                                        <option value="1">1</option>
                                    
                                        <option value="2">2</option>
                                    
                                        <option value="3">3</option>
                                    
                                        <option value="4">4</option>
                                    
                                        <option value="5">5</option>
                                    
                                        <option value="6">6</option>
                                    
                                        <option value="7">7</option>
                                    
                                        <option value="8">8</option>
                                    
                                        <option value="9">9</option>
                                    
                                        <option value="10">10</option>
                                    
                                        <option value="11">11</option>
                                    
                                        <option value="12">12</option>
                                    
                                </select>
                            </span><em class="ni_tit mr15">월</em>
                            
                            <span class="field2">
                                <select id="expyear" name="expyear">
                                    <option value="YYYY" selected="selected">YYYY</option>
                                    
                                    
                                        <option value="2019">2019</option>
                                        <option value="2020">2020</option>
                                        <option value="2021">2021</option>
                                        <option value="2022">2022</option>
                                        <option value="2023">2023</option>
                                        <option value="2024">2024</option>
                                        <option value="2025">2025</option>
                                        <option value="2026">2026</option>
                                        <option value="2027">2027</option>
                                        <option value="2028">2028</option>
                                        <option value="2029">2029</option>
                                        <option value="2030">2030</option>
                                        <option value="2031">2031</option>
                                        <option value="2032">2032</option>
                                        <option value="2033">2033</option>
                                        <option value="2034">2034</option>
                                        <option value="2035">2035</option>
                                        <option value="2036">2036</option>
                                    
                                        <option value="2037">2037</option>
                                    
                                        <option value="2038">2038</option>
                                    
                                        <option value="2039">2039</option>
                                    
                                </select>
                            </span><em class="ni_tit">년</em>
                    
                        </div>
                        
                        
                        
                    </div>

                    <div class="card_cbox">
                        <label class="label_tit date_of_birth">생년월일<br><em>(6자리)</em></label>
                        <label class="label_tit business_creditCard" style="display: none;">사업자번호</label>
                        <div class="row label_slc3 mr15 age_box">
                            <span class="field2">
                                <input type="text" id="age" name="age" maxlength="6" style="padding: 0 15px 0 15px;" class="inp-st" placeholder="YYMMDD">
                            </span>
                        </div>
                        <div class="row label_slc3 mr15 license_number" style="display: none;">
                            <span class="field2">
                                <input type="text" id="licenseNumber" style="padding: 0 15px 0 15px;" name="licenseNumber" class="inp-st" maxlength="10" placeholder="-제외하고 입력">
                            </span>
                        </div>
                        
                        <div class="frm_box mt7">
                            <label class="label_tit">비밀번호</label>
                            <div class="row label_slc1">
                                <span class="field2">
                                    <input type="password" id="cardpwd" name="cardpwd" style="padding: 0 15px 0 15px;" maxlength="2" class="inp-st" placeholder="앞 2자리">
                                </span>
                            </div>
                        </div>
                        

                        <ul class="rdo-chk-list other-type02">
                            <li class="all first_bd">
                                <input type="checkbox" class="frm-chk st01" id="all-agree" name="agreelist">
                                <label for="all-agree">전체동의</label>
                            </li><br/>
                            <li class="mt">
                                <input type="checkbox" class="frm-chk st01 checkSelect1" id="agree01" name="agreelist">
                                <label for="agree01" class="other-line agree01">전자금융거래 기본약관</label>&nbsp;<a href="#agreement1.html" class="linker linker2">보기</a>
                            </li><br/>
                            <li class="mt">
                                <input type="checkbox" class="frm-chk st01 checkSelect1" id="agree02" name="agreelist">
                                <label for="agree02" class="other-line agree02">개인정보 수집 및 이용안내</label>&nbsp;<a href="#agreement2.html" class="linker linker2">보기</a>
                            </li><br/>
                            <li class="mt">
                                <input type="checkbox" class="frm-chk st01 checkSelect1" id="agree03" name="agreelist">
                                <label for="agree03" class="other-line agree03">개인정보 제공 및 위탁 안내</label>&nbsp;<a href="#agreement3.html" class="linker linker2">보기</a>
                            </li><br/>
                            <li class="mt">
                                <input type="checkbox" class="frm-chk st01 checkSelect1" id="confirm" name="agreelist">
                                <label for="confirm" class="other-line agree00">자동결제 서비스 이용약관</label>&nbsp;<a href="#agreement4.html" class="linker linker2">보기</a>
                            </li><br/>
                            
                        </ul>  
                    </div>
                </div>
               </div>
               
               <input type="hidden" id="memId" name="memId" value="${SESSION_MEMBERVO.memId }"/>
               <input type="hidden" id="modalticketNo" name="ticketNo">
      </form>
               <!-- ======================== 무통장 결제 화면 ========================-->
                <div class="form-group" id="mobuy">
                  <label class="modalLabels">무통장 결제</label>
                	 
                  <div id="dupleCode"></div>
               </div>
               
               </div>   
               <div id="modalBtn" class="modal-footer">
                  <button type="button" id="buyBtn" >결제</button>
                  <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
               </div>
            </div>
         </div>
      </div>
	