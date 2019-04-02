<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="/css/message/messageModal.css">

<div class="message">
	<h1>
		<div class="massage-title">알림</div>
		<button class="glyphicon glyphicon-trash"></button>
		<button class="glyphicon glyphicon-remove cancle-btn99"></button>
	</h1>
	
	<div class="msg-listBox">
		<ul>
			<!-- 리스트 출력 -->
			<c:forEach items="${MSGLIST }" var="msgVo">
			<li class="msg-items">
				<a>${msgVo.msgContent }</a>
				
				<div class="info">
					<div class="nd-box">
						<div class="userId">${msgVo.senderId }</div>
<%-- 						<div class="dateTime">${msgVo.sendDt }</div> --%>
						<div class="dateTime"><fmt:formatDate value="${msgVo.sendDt }" pattern="yy.MM.dd HH:mm" /></div>
					</div>
				</div>
				<div class="btns2">
					<button class="btn btn-success">예</button>
					<button class="btn btn-danger">아니오</button>
				</div>
			</li>
			</c:forEach>
		</ul>
	</div>
</div>

