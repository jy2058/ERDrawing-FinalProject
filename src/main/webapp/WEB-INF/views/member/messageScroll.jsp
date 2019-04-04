<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="/css/message/messageModal.css">

<div class="message" style="overflow: scroll;">
	<h1>
		<div class="massage-title">알림</div>
		<button class="btn glyphicon glyphicon-trash" value="delAll"></button>
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
	
	getMessagePagingHtml(1);	// 페이징 메서드

	// $(".btn에서 #ul")로 바꾸니까 전체 삭제 안 되는 중 / 버튼은 잘 됨
	// 수락 / 거절 / 삭제 눌렀을때 화면에서 사라지기는 한데 새로고침하면 삭제되기 전의 리스트가 가져와 짐 -> 디비엔 이미 삭제됨
	$("#ul").on("click", ".btn", function(e){
		var senderId = $(e.target).closest('li').data("senderid");
		var teamNo = $(e.target).closest('li').data("teamno");	
		var msgNo = $(e.target).closest('li').data("msgno");	
		var value = $(e.target).val();
		
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
				//getMessagePagingHtml(1); 이렇게 해도 안돼
			},
			error : function(xhr, status, error){
				alert("에러");
			}
		});
	});

});

/* $(document).scroll(function(){
	console.log($(document).height());
}); */

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
				$("#pagination").html(htmlArr[1]);
			}
		});
	}




</script>

