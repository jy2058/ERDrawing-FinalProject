<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="/css/message/messageModal.css">

<div class="message" style="overflow: auto; height: 45%;">
	<h1>
		<div class="massage-title">알림</div>
		<button class="btn glyphicon glyphicon-trash" id="delAllBtn" value="delAll"></button>
		<button class="glyphicon glyphicon-remove cancle-btn99"></button>
	</h1>
	
	<div class="msg-listBox">
		<!----------------------------------------------알림------------------------------------------------>
		<ul id="ul">
		
			
		</ul>
	</div>
	
	<!------------------------------------------------ 페이지네이션---------------------------------------- -->
	<nav id="divNav" style="text-align: center;">
			<ul class="pagination" id="pagination">
			</ul>
	</nav>
</div>

<script>

$(document).ready(function(){
	var page = 1;
	getMessagePagingHtml(page);	// 페이징 메서드
	page++;
	
  	$(".message").scroll(function(){   //스크롤이 최하단 으로 내려가면 리스트를 조회하고 page를 증가시킨다.
	     if($(".message").scrollTop() >= $(".liClass").height() - $(".message").height()){
	    	 console.log("liClass : " + $(".liClass").height() + " message : " + $(".message").height());
	    	 getMessagePagingHtml(page);
	           page++;   
	     } 
	}); 
 
	$(".message").on("click", ".btn", function(e){
		var senderId = $(e.target).closest('li').data("senderid");
		var teamNo = $(e.target).closest('li').data("teamno");	
		var msgNo = $(e.target).closest('li').data("msgno");	
		var value = $(e.target).val();
		
		console.log(value);
		console.log("msgNo", msgNo);
		console.log("senderId", senderId);
		
		// 알림 전송 / 삭제 ajax
		$.ajax({
			type : "get",
			url : "${cp}/message/insertMsg",
			data : {senderId : senderId,
					teamNo : teamNo,
					msgNo : msgNo,
					value : value},
			success : function(data){
				if(e.target.value == "delAll"){
					$(".liClass").remove();
					$("#ul").append("<div>알림이 없습니다.</div>");
				}
				$(e.target).closest('li').remove();
			},
			error : function(xhr, status, error){
				alert("에러");
			}
		});
	});

});

/*  $(".message").scroll(function(){
	console.log($("#ul").height());
});  */

// 페이징 메서드
function getMessagePagingHtml(page) {
	$.ajax({
			url : "${cp}/message/msgAjax",
			data : {
				page : page
			},
			success : function(data) {
				var htmlArr = data
						.split("======================seperator==========================");
				$("#ul").html(htmlArr[0]);
				//$("#pagination").html(htmlArr[1]);
			}
		});
	}




</script>
