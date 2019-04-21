<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="/css/member/modify.css">
<link rel="stylesheet" href="/css/member/mypage.css">
<link rel="stylesheet" href="/css/boxErd.css">

<style>

.filebox input[type="file"] {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
}
.filebox label {
  display: inline-block;
  color: #fff;
  font-size: inherit;
  line-height: normal;
  vertical-align: middle;
  background-color: #FA4358;
  cursor: pointer;
  border: 1px solid #FA4358;
  border-radius: .25em;
}
.filebox label:hover {
  background-color: #FA4358;
}
.filebox label:active {
  background-color: #FA4358;
}
.modal{
 color: #000;

}
.modal-dialog, .modal-content {
    height: auto;
}

#ticketModalEvnTest{
 height: auto;
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

.tickets .bg-img{
color:#fff;
}
</style>
<br />
<br />

<c:if test="${SESSION_MEMBERVO.memAuth == 'T' }">

		<div style="" id="add" class="modifyModal" data-toggle="modal" data-ticketno="insert" data-target="#ticketModalEvnTest" data-ticketno="insert" >티켓 추가</div>
		<br/>	<br/>
	
</c:if>


<div class="best-erd-list tickets">
	<div class="inner-container">
		<div class="col-sm-12">
			<ul class="erd-box-list">

				<c:forEach var="ticket" varStatus="status" items="${ticketList }">
					<li class="erd-box-item"  >
					
						<a class="preview-box" data-ticketno="${ticket.ticketNo }"  style="" class="modifyModal" data-toggle="modal" data-target="#modifyBuyModal" >
							<div class="bg-box">
								<div class="bg-img" ><img alt="" src="${cp }/ticket/ticketImg?ticketNo=${ticket.ticketNo }" width="700" height="200"></div>
								<div class="table-bg-text">
									<div class="bg-text shinys"><h1>${ticket.ticketContent }</h1>${ticket.ticketPrice } 원</div>
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
	
<%@ include file="/WEB-INF/views/ticket/ticketModal.jsp"%>
	
	
	<script type="text/javascript">
	
	
	var ticketNo = "";
	var regex= /^[0-9]+$/;
	$(document).ready(function() {
		
	    $("#input_img").on("change", handleImgFileSelect);

		var msg = "${msg}"
		if(msg !=""){
			alert(msg);
		}
	
		//티켓 클릭시
		$(".preview-box").on('click', function() {
			ticketNo = $(this).data("ticketno");
			  $("#sinbuy").hide();  
	    		$("#mobuy").hide();
		});
		
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
			
			//결제모달창 제어
			//동의 체크박스 제어
			$("#all-agree").on("click", function(){
			    if (! $('#all-agree').prop('checked')) {
			        $('.checkSelect1').prop('checked', false);          
			    }else{
			        $('.checkSelect1').prop('checked', 'checked');
			    }
			});
			 $("#age").on("keyup", function(e) {
			        $(this).val($(this).val().replace(/[^0-9]/g,""));
			    });
			$("#licenseNumber").on("keyup", function(e) {
			     $(this).val($(this).val().replace(/[^0-9]/g,""));
			  });
			  $("#cardpwd").on("keyup", function(e) {
			      $(this).val($(this).val().replace(/[^0-9]/g,""));
			  });
			  $(".ipt_cardnumber").on("keyup", function(e) {
			      $(this).val($(this).val().replace(/[^0-9]/g,""));
			  })
			   $("#buyBtn").on("click", function(e) {
				   var radioVal = $('input[name="buychoose"]:checked').val();		   
				   if(radioVal =="sin"){
					cardBuyCk();
					$("#cardFrm").attr("action","${cp}/ticket/ticketCardBuy");
				    $("#modalticketNo").val(ticketNo);
				    console.log($("#ticketNo").val());
				    console.log($("#memId").val());
				    $("#cardFrm").submit();
				    }else{
					   alert("==");
				   }
			  })
			
		});

	//해당 티켓 정보 가져오기 
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
					$("#profileImg").attr("src", "${cp }/ticket/ticketImg?ticketNo="+data.ticketVo.ticketNo);
				}
			});
		}
		
		function getModifys() {
			$("#ticketNo").val("");
			$("#ticketPrice").val("");
			$("#ticketContent").val("");
			$("#profileImg").attr("src","/image/noImg.png");
		}
		
		

	      function handleImgFileSelect(e) {
	          var files = e.target.files;
	          var filesArr = Array.prototype.slice.call(files);
	          filesArr.forEach(function(f) {
	              if(!f.type.match("image.*")) {
	                  alert("확장자는 이미지 확장자만 가능합니다.");
	                  return;
	              }

	              sel_file = f;

	              var reader = new FileReader();
	              reader.onload = function(e) {
	                  $("#profileImg").attr("src", e.target.result);
	              }
	              reader.readAsDataURL(f);
	          });
	      }
	      
	      function radioBtn_ch() {
	    	  var radioVal = $('input[name="buychoose"]:checked').val();
	    	  alert(radioVal);
	    	  if(radioVal=="sin"){
	    		$("#sinbuy").show();  
	    		$("#mobuy").hide();  
	    	  }else{

		    		$("#sinbuy").hide();  
		    		$("#mobuy").show();
	    	  }
		}
	      function cardBuyCk() {
	    	  if($("#cardno1").val().trim()=="")
	            {
	                alert("카드 번호를 입력해 주세요.");
	                $("#cardno1").val() = "";
	                $("#cardno1").focus();
	                return false;
	            }
		}
		
		
	</script>
</div>