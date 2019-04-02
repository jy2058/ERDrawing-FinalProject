<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

    <!-- Custom styles for this template -->
   <link href="${cp}/css/dashboard.css" rel="stylesheet">
  </head>

  <body>
	<%-- <%@ include file="/WEB-INF/views/module/header.jsp" %> --%>
    <div class="container-fluid">
      <div class="row">
      	<%@ include file="/WEB-INF/views/post/left.jsp"%>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <!-- <h1 class="page-header">게시글 조회</h1> -->
          <form id="frm" action="${cp}/delPost" method="post" class="form-horizontal" role="form">
			<div class="form-group">
				<label for="title" class="col-sm-2 control-label">글제목</label>
				<div class="col-sm-7">
					<label class="control-label">${postList.postTitle}</label>
				</div>
			</div>
			
			<div class="form-group">
				<label for="writer" class="col-sm-2 control-label">작성자</label>
				<div class="col-sm-7">
					<label class="control-label">${postList.writerId}</label>
				</div>
			</div>
			
			<div class="form-group">
				<label for="insertDate" class="col-sm-2 control-label">작성일</label>
				<div class="col-sm-7">
					<label class="control-label"><fmt:formatDate value="${postList.postRegDt}" pattern="yyyy-MM-dd" /></label>
				</div>
			</div>
			
			<div class="form-group">
				<label for="content" class="col-sm-2 control-label">글내용</label>
				<div class="col-sm-7">
					<label class="control-label">${postList.postContent}</label>
				</div>
			</div>
			
			<%-- 파일첨부 --%>
			<div class="form-group">
				<label for="content" class="col-sm-2 control-label">첨부파일</label>
				<div class="col-sm-7">
					<c:forEach items="${fileList}" var="file">
						<a href="${cp}/post/fileDownload?uploadFileNo=${file.uploadFileNo}">${file.uploadFileNm}</a>
					</c:forEach>
				</div>
			</div>

			<div class="form-group">
				<label for="content" class="col-sm-1 control-label">댓글</label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="cmtText" />
				</div>
				<div class="col-sm-2">
					<button id="cmtBtn" type="button" class="btn btn-default">등록</button>
				</div>
			</div>

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
						<c:forEach items="${cmtList}" var="cmt">
							<tr class="cmtTr" data-cmtNo="${cmt.cmtNo}">
								<td>${cmt.cmtNo}</td>
								<td>${cmt.memId}</td>
								<td>${cmt.cmtContent}</td>
								<td>
								<button type="button" class="btnLike btn-default" data-cmtnum="${cmt.cmtNo}">좋아요</button>
								<c:if test="${SESSION_MEMBERVO.memId == cmt.memId}">
										<button type="button" class="btnDel btn-default" data-cmtnum="${cmt.cmtNo}">삭제</button>
											<%--  <c:choose>
												<c:when test="${SESSION_MEMBERVO.memId ne null}">
													<a href="javascript: like_func();"><img src="">좋아요</a>
												</c:when>
											</c:choose> --%>
									</td>
								</c:if>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			
			<div class="form-group">
				<div class="col-sm-3">
					<input type="button" id="listBtn" value="목록" class="btn btn-default" />
					<c:if test="${SESSION_MEMBERVO.memId == postList.writerId}">
						<input type="button" id="updBtn" value="수정" class="btn btn-default" />
					</c:if>
					<c:if test="${SESSION_MEMBERVO.memId == postList.writerId}">
						<input type="button" id="delBtn" value="삭제" class="btn btn-default" />
					</c:if>
					<input type="button" id="replyBtn" value="답글" class="btn btn-default" />
				</div>
			</div>	
			</div>
			
			<input type="hidden" id="postNo" name="postNo" value="${postVo.postNo}" />
		</form>
        </div>
      </div>
      
<form id="listFrm" action="${cp}/post/postList" method="get">
	<input type="hidden" name="boardNo" value="${postList.boardNo}" />
</form>

<form id="updFrm" action="${cp}/post/postUpdate" method="get">
	<input type="hidden" name="postNo" value="${postList.postNo}" />
</form>	

<form id="delFrm" action="${cp}/post/postDel" method="get">
	<input type="hidden" name="boardNo" value="${postList.boardNo}" />
	<input type="hidden" name="postNo" value="${postList.postNo}" />
</form>	

<form id="cmtFrm" action="${cp}/post/insertCmt" method="get">
	<input type="hidden" id="cmtContent" name="cmtContent"/>
	<input type="hidden" name="postNo" value="${postList.postNo}" />
	<input type="hidden" name="memId" value="${SESSION_MEMBERVO.memId}" />
</form>

<form id="cmtDelFrm" action="${cp}/post/deleteCmt" method="get">
	<input type="hidden" name="postNo" value="${postList.postNo}" />
	<input type="hidden" name="cmtNo" id="cmtNo" />
</form>

<!-- 해야됨 -->
<!-- 댓글 좋아요 -->
<%-- <form id="cmtLikeFrm" action="${cp}/post/likeCmt" method="get">
	<input type="hidden" id="cmtContent" name="cmtContent"/>
	<input type="hidden" name="postNo" value="${postList.postNo}" />
	<input type="hidden" name="cmtNo" value="${.cmtNo}" />
	
	<input type="hidden" name="memId" value="${SESSION_MEMBERVO.memId}" />
</form> --%>

<!-- 해야됨 -->
<form id="replyFrm" action="${cp}/post/postReply" method="get" class="form-horizontal" role="form">
	<input type="hidden" id="postNo" name="postNo" value="${postNo}" />
	<input type="hidden" id="boardNo" name="boardNo" value="${boardNo}" />
</form>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	
	<script type="text/javascript">
	
	
		// 목록버튼 클릭이벤트
		$(document).ready(function() {
			$("#listBtn").click(function() {
				$("#listFrm").submit();
			});
			
			//수정버튼 클릭이벤트
			$("#updBtn").click(function() {
				$("#updFrm").submit();
			});
			
			//삭제버튼 클릭이벤트
			$("#delBtn").click(function() {
				alert("게시글을 삭제 하시겠습니까?");
				$("#delFrm").submit();
			});
			
			//답글버튼 클릭이벤트
			$("#replyBtn").click(function() {
				$("#replyFrm").submit();
			});
			
			//댓글등록버튼 클릭이벤트
			$("#cmtBtn").click(function() {
				var cmt = $("#cmtText").val();
				alert("댓글을 등록 하시겠습니까?");
				$("#cmtContent").val(cmt);
				$("#cmtFrm").submit();
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
  </body>
</html>
    