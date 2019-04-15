<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<link rel="stylesheet" href="/css/member/mypage.css">
<link rel="stylesheet" href="/css/boxErd.css">

<style>
.modal{
 color: #000;

}
.modal-dialog, .modal-content {
    height: 63%;
}
.modalLabels{
width: 100px;
}

#add{
    margin-right: 1.5%;
    margin-left: 90%;
    position: relative;
    padding: 10px;
    font-weight: 100;
    font-size: 16px;
    top: 20px;
    right: 0;
    border: 3px solid #fff;
    border-radius: 5px;
    opacity: 0.8;
    cursor: pointer;
}
.modal-backdrop {
    position: absolute;
    height: 500%;
    top: 0;
    right: 0;
    left: 0;
    background-color: #000;
}

#add:hover {
    opacity: 1;
    background: #fff;
    color: #000;
}
</style>
<br />
<br />

<c:if test="${SESSION_MEMBERVO.memAuth == 'T' }">

		<div style="" id="add" class="modifyModal" data-toggle="modal" data-ticketno="insert" data-target="#ticketModalEvnTest" data-ticketno="insert" >티켓 추가</div>
		<br/>	<br/>
	
</c:if>


<div class="best-erd-list">
	<div class="inner-container">
		<div class="col-sm-12">
			<ul class="erd-box-list">

				<c:forEach var="ticket" varStatus="status" items="${ticketList }">
					<li class="erd-box-item">
					
						<a class="preview-box">
							<div class="bg-box">
								<div class="bg-img">&nbsp;${ticket.ticketContent }</div>
								<div class="table-bg-text">
									<div class="bg-text shinys">&nbsp;${ticket.ticketPrice }</div>
								</div>
							</div>
						</a>
						
						<div class="description-item">
							<c:if test="${SESSION_MEMBERVO.memAuth == 'T' }">
								<div  class="modifyModal" style="float: right; cursor: pointer;" data-toggle="modal" data-target="#ticketModalEvnTest" data-ticketno="${ticket.ticketNo }">수정</div>
							</c:if>

							<div style="float: left;">${ticket.ticketContent }</div>

							<ul class="tagList" style="clear: both;">
								<li>가격:</li>
								<li>&nbsp;${ticket.ticketPrice }</li>
							</ul>
							
						</div></li>
				</c:forEach>
			</ul>
		</div>
	</div>
	
	
<!-- 티켓 수정.삭제 하는 모달창 띄우기 -->	
	<form id="frm" action="/ticket" method="post">
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
                     <input   type="text" class="ticketImg" id="ticketImg" name="ticketImg" />
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
	
	
	
	<script type="text/javascript">
	
	
	var ticketNo = "";
	var regex= /^[0-9]+$/;
	$(document).ready(function() {

		var msg = "${msg}"
		if(msg !=""){
			
			alert(msg);
		}
		
		//티켓리스트의 수정클릭시
		$(".modifyModal").on('click', function() {
				ticketNo = $(this).data("ticketno");
				
				//수정버튼
				if(ticketNo!="insert"){
				$("#insertBtn").hide();
				$("#modifyBtn").show();
				$("#deleteBtn").show();
				getModify(ticketNo);
				}
				
				//추가버튼
				else{
					$("#insertBtn").show();
					$("#modifyBtn").hide();
					$("#deleteBtn").hide();
					getModifys();	
				}
			});

		//모달창 수정클릭시
		$("#modifyBtn").on('click', function() {
			
			if (confirm("수정 하시겠습니까??") == true) {
				
				if($("#ticketPrice").val().trim()==""){
					//$("#memId").val().trim()
					alert("가격을 입력해 주세요");
					$("#ticketPrice").focus();
					return false;
				}
				
				if($("#ticketPrice").val().trim()==""  || regex.test($("#ticketPrice").val())==false){
					alert("가격은 숫자만 입력 가능합니다.");
					$("#ticketPrice").focus();
					return false;
				}
				
				if($("#ticketContent").val().trim()==""){
					//$("#memId").val().trim()
					alert("이용권 내용을 입력해주세요");
					$("#ticketContent").focus();
					return false;
				}
				
				if($("#ticketContent").val().trim()==""){
					//$("#memId").val().trim()
					alert("이용권 내용을 입력해주세요");
					$("#ticketContent").focus();
					return false;
				}
				
				$("#frm").attr("action", "/ticket/modifyTicket");
				$("#frm").submit();
			}
			});

			$("#deleteBtn").on('click', function() {
				
				if (confirm("삭제 하시겠습니까??") == true) {
					$("#frm").attr("action", "/ticket/deleteTicket");
					$("#frm").submit();
				}
			});
			
			//모달창 추가클릭시
			$("#insertBtn").on('click', function() {
				
				if (confirm("추가 하시겠습니까??") == true) {
					
					if($("#ticketPrice").val().trim()==""){
						//$("#memId").val().trim()
						alert("가격을 입력해 주세요");
						$("#ticketPrice").focus();
						return false;
					}
					if($("#ticketPrice").val().trim()==""  || regex.test($("#ticketPrice").val())==false){
						alert("가격은 숫자만 입력 가능합니다.");
						$("#ticketPrice").focus();
						return false;
					}
					
					if($("#ticketContent").val().trim()==""){
						//$("#memId").val().trim()
						alert("이용권 내용을 입력해주세요");
						$("#ticketContent").focus();
						return false;
					}
					
					if($("#ticketContent").val().trim()==""){
						//$("#memId").val().trim()
						alert("이용권 내용을 입력해주세요");
						$("#ticketContent").focus();
						return false;
					}
					$("#frm").attr("action", "/ticket/insertTicket");
					$("#frm").submit();
				}
				});
		});

		function getModify(ticketNo) {
			$.ajax({
				url : "${cp}/ticket/ticketModify",
				data : {
					ticketNo : ticketNo
				},
				success : function(data) {
					console.log(data);
					//모달창에  해당 회원의 값 넣어주기
					$("#ticketNo").val(data.ticketVo.ticketNo);
					$("#ticketPrice").val(data.ticketVo.ticketPrice);
					$("#ticketContent").val(data.ticketVo.ticketContent);
				}
			});
		}
		
		function getModifys() {
			$("#ticketNo").val("");
			$("#ticketPrice").val("");
			$("#ticketContent").val("");
		}
	</script>
</div>