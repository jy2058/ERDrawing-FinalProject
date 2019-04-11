<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="/css/message/messageModal.css">

<div class="message">
	<h1 class="massage-title">ERD 검색
		<button class="glyphicon glyphicon-remove cancle-btn99"></button>
	</h1>
	<div class="msg-listBox">
		<div class="btns2">
			<input type="text">
		</div>
		<button class="btn">검색</button>
	</div>
	<div>
		<ul>
			<li>
				<a>
					<div>
						<img alt="" src="">
					</div>
					<div>
						<div>이름</div>
					</div>
				</a>
			</li>
		</ul>
	</div>
</div>

<script>
	$.ajax({
		type : "get",
		url : "${cp}/message/insertMsg",
		data : {},
		success : function(data){
			
		}
	});
</script>

