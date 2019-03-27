<%-- <%@page import="kr.or.ddit.reply.model.ReplyVO"%> --%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">

<title>Dashboard Template for Bootstrap</title>

<!-- Bootstrap core CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- Custom styles for this template -->
<link href="${cp}/css/dashboard.css" rel="stylesheet">
<!-- <link rel="stylesheet" href="/css/style.css"> -->
</head>

<body>
	<%-- <%@ include file="/WEB-INF/views/module/header.jsp"%> --%>
	<form class="form-horizontal" role="form">
		<div class="container-fluid">
			<div class="row">
				<%@ include file="/WEB-INF/views/post/left.jsp" %>
			</div>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				
				</br>
				</br>
				글제목  : <input type="text" value="${postList.postTitle}" rows="10" cols="100" style="width:400px; height:30px;" readonly/></br></br>

				작성자  : <input type="text" value="${postList.writerId}" rows="10" cols="100" style="width:400px; height:30px;" readonly/></br></br>

				작성일  : <input type="text" value="${postList.postRegDt}" rows="10" cols="100" style="width:400px; height:30px;" readonly/></br></br>
				
				<div class="form-group">
					<label for="userNm" class="col-sm-1 control-label">작성일 :</label>
					<div class="col-sm-9">
						<label class="control-label"><fmt:formatDate value="${postList.postRegDt}" pattern="yyyy-MM-dd" /> </label>
					</div>
				</div> 

				<%--글내용  : <input type="text" value="${postList.postContent}" rows="10" cols="100" style="width:400px; height:30px;" readonly/></br></br> --%>
					글내용 : <textarea rows="10" cols="100" style="width:400px; height:100px;" readonly>${postList.postContent}</textarea></br></br> 
						
				<div class="form-group">
					<label for="content" class="col-sm-1 control-label">댓글</label>
					<div class="col-sm-5">
						<input type="text" class="form-control" id="cmtText" />
					</div>
					<div class="col-sm-2">
						<button id="cmtBtn" type="button" class="btn btn-default">등록</button>
					</div>
				</div>
				
		</br></br>
		<div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>댓글번호</th>
                  <th>작성자</th>
                  <th>댓글내용</th>
                </tr>
              </thead>
              <tbody>
				<c:forEach items="${cmtList}" var="cmt" >
			      	  <tr class="cmtTr" data-cmtNo="${cmt.cmtNo}" >
		      	  		<td>${cmt.cmtNo}</td>
		      	  		<td>${cmt.memId}</td>
		      	  		<td>${cmt.cmtContent}</td>
		      	  		<c:if test="${SESSION_MEMBERVO.memId == cmt.memId}">
			      	  		<td><!-- <button id="cmtUpdBtn" type="button" class="btnUpd btn-default">수정</button> -->
			      	  		    <button type="button" class="btnDel btn-default" data-cmtnum="${cmt.cmtNo}">삭제</button></td>
		      	  		</c:if>
			      	  </tr>
				</c:forEach>
              </tbody>
            </table>
          </div>
				
				</br></br>
				<div class="form-group">
					<div class="col-sm-3">
						<input type="button" id="listBtn" value="목록" class="btn btn-default" />
						<c:if test="${SESSION_MEMBERVO.memId == postList.writerId}"><input type="button" id="updBtn" value="수정" class="btn btn-default" /></c:if>
						<c:if test="${SESSION_MEMBERVO.memId == postList.writerId}"><input type="button" id="delBtn" value="삭제" class="btn btn-default" /></c:if>
						<input type="button" id="replyBtn" value="답글" class="btn btn-default" />
						<!-- <input type="button" id="likeBtn" value="LIKE" class="btn btn-default" /> -->
					</div>
				</div>
			</div>
	</form>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

	<script src="/SE2/js/HuskyEZCreator.js"></script>
	<script type="text/javascript">
		// 목록버튼 클릭이벤트
		$(document).ready(function() {
			$("#listBtn").click(function() {
				$("#listFrm").submit();
			});
			
			//수정버튼 클릭이벤트
			$("#updBtn").click(function() {
				alert("게시글을 수정 하시겠습니까?");
				$("#updFrm").submit();
			});
			
			//삭제버튼 클릭이벤트
			$("#delBtn").click(function() {
				alert("게시글을 삭제 하시겠습니까?");
				$("#delFrm").submit();
			});
			
			//댓글등록버튼 클릭이벤트
			$("#cmtBtn").click(function() {
				var cmt = $("#cmtText").val();
				alert("댓글을 등록 하시겠습니까?");
				$("#cmtContent").val(cmt);
				$("#cmtFrm").submit();
			});
			
			//댓글수정버튼 클릭이벤트
			$("#cmtUpdBtn").click(function() {
				alert("댓글을 수정 하시겠습니까?");
				$("#cmtUpdFrm").submit();
			});
			
			//댓글삭제버튼 클릭이벤트
			$(".btnDel").on("click",function() {
				var cmtNoDel = $(this).data("cmtnum");
				alert("댓글을 삭제 하시겠습니까?");
				//input id.val(cmtNoDel);
				$("#cmtNo").val(cmtNoDel);
				$("#cmtDelFrm").submit();
			});
			
		
			
		});
	</script>
	
<form id="listFrm" action="${cp}/post/postList" method="get">
	<input type="hidden" name="boardNo" value="${postList.boardNo}" />
</form>

<!-- 해야됨 -->
<form id="updFrm" action="${cp}/post/postUpd" method="get">
	<input type="hidden" name="postNo" value="${postList.postNo}" />
</form>	

<form id="delFrm" action="${cp}/post/postDel" method="get">
	<input type="hidden" name="boardNo" value="${postList.boardNo}" />
	<input type="hidden" name="postNo" value="${postList.postNo}" />
</form>	

<!-- 해야됨 -->
<form id="cmtFrm" action="${cp}/post/insertCmt" method="get">
	<input type="hidden" id="cmtContent" name="cmtContent"/>
	<input type="hidden" name="postNo" value="${postList.postNo}" />
	<input type="hidden" name="memId" value="${SESSION_MEMBERVO.memId}" />
</form>

<!-- 해야됨 -->
<%-- <form id="cmtUpdFrm" action="${cp}/post/postUpd" method="get">
	<input type="hidden" name="postNo" value="${postList.postNo}" />
</form>	 --%>

<form id="cmtDelFrm" action="${cp}/post/deleteCmt" method="get">
	<input type="hidden" name="postNo" value="${postList.postNo}" />
	<input type="hidden" name="cmtNo" id="cmtNo" />
</form>

</body>
</html>