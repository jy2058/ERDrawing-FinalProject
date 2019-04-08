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
   

<!-- <link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script> -->
   
   
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
				
				
<style>
	#layer_popup {display:none; border:5px solid #cccccc;margin:0;padding:5px;background-color:#ffffff;z-index:2000;}
	#layer_popup .b-close {position:absolute;top:10px;right:30px;color:#f37a20;font-weight:bold;cursor:hand;}
	#layer_popup .popupContent {margin:0;padding:0;text-align:center;border:0;width:650px;height:200px;}
	#layer_popup .popupContent iframe {border:0;padding:0px;margin:0;z-index:10;}
</style>
<input type="button" onclick="layer_open();" value="신고">
<!-- <input type="button" value="레이어팝업 열기" onclick="layer_open();"  style="cursor:pointer; background-color:#663333; color:#FFF;" /> -->
<!-- 팝업 -->
<div id="layer_popup" style="display:none; ">
	<span>     
	    <div class="b-close">X</div>
	</span>
	<div class="popupContent">
		<div class="modal-header">
			<label>게시글 신고</label>
		</div>
		
		<div class="modal-body">
                           
        <%--  <div class="form-group">
              <label class="modalLabel">작성자</label> 
              <input type="text" id="memNm" name="memNm" value="${postList.writerId}" readonly /> 
              <div id="dupleCode"></div>
           </div>  --%>
           
            <div class="form-group">
              <label class="modalLabel">신고사유</label> 
              <input type="text" id="reasonTxt" rows="10" cols="100" style="width: 500px; height: 30px;">    
           </div>   
        </div>  
           
           <div class="modal-footer">
                  <button type="button" id="reportBtn" class="btn btn-default" data-dismiss="modal">신고</button>
                  <button type="button" id="cancelBtn" class="btn btn-default" data-dismiss="modal">취소</button>
           </div>
	</div>
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
							<tr class="cmtTr" data-cmtno="${cmt.cmtNo}">
								<td>${cmt.cmtNo}</td>
								<td>${cmt.memId}</td>
								<td>${cmt.cmtContent}</td>
								<td> ( ${cmt.cnt} 건 ) 
								<button type="button" id="likeBtn" class="btnLike btn-default" data-cmtnum="${cmt.cmtNo}">좋아요</button>
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
         
<!-- 목록 -->
<form id="listFrm" action="${cp}/post/postList" method="get">
	<input type="hidden" name="boardNo" value="${postList.boardNo}" />
</form>

<!-- 게시글 수정 -->
<form id="updFrm" action="${cp}/post/postUpdate" method="get">
	<input type="hidden" name="postNo" value="${postList.postNo}" />
</form>	

<!-- 게시글 삭제 -->
<form id="delFrm" action="${cp}/post/postDel" method="get">
	<input type="hidden" name="boardNo" value="${postList.boardNo}" />
	<input type="hidden" name="postNo" value="${postList.postNo}" />
</form>

<!-- 신고 확인 -->
<form id="reportFrm" action="${cp}/post/postReport" method="get">
	<input type="hidden" name="postNo" value="${postList.postNo}" />
	<input type="hidden" name="fromMemId" value="${SESSION_MEMBERVO.memId}" />
	<input type="hidden" name="toMemId" value="${postList.writerId}" />
	<input type="hidden" id="reason" name="reason" />
</form>

<!-- 신고 취소 -->
<form id="cancelFrm" action="${cp}/post/postDetail" method="get">
	<input type="hidden" name="postNo" value="${postList.postNo}" />
</form>

<!-- 댓글 등록 -->
<form id="cmtFrm" action="${cp}/post/insertCmt" method="get">
	<input type="hidden" id="cmtContent" name="cmtContent"/>
	<input type="hidden" name="postNo" value="${postList.postNo}" />
	<input type="hidden" name="memId" value="${SESSION_MEMBERVO.memId}" />
</form>

<!-- 댓글 삭제 -->
<form id="cmtDelFrm" action="${cp}/post/deleteCmt" method="get">
	<input type="hidden" name="postNo" value="${postList.postNo}" />
	<input type="hidden" name="cmtNo" id="cmtNoDel" />
</form>

<!-- 댓글 좋아요 -->
<form id="cmtLikeFrm" action="${cp}/post/likeCmt" method="post">
	<input type="hidden" name="postNo" value="${postNo}" />
	<input type="hidden" id="cmtNo" name="cmtNo" />
	<input type="hidden" name="memId" value="${SESSION_MEMBERVO.memId}" />
</form> 

<!-- 답글 -->
<form id="replyFrm" action="${cp}/post/postReply" method="get" class="form-horizontal" role="form">
	<input type="hidden" id="postNo" name="postNo" value="${postNo}" />
	<input type="hidden" id="boardNo" name="boardNo" value="${boardNo}" />
</form>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<script src="${cp}/js/popup/bpopup.js"></script>
   	
	<script>
	function layer_open() { 
	 $("#layer_popup").bPopup();
	}
	</script>  
	<script type="text/javascript">
	
		$(document).ready(function() {
			
		//버튼 눌렀을때 참고
		 	$('#modalEvnTest').on('show.bs.modal', function (event) {
			 		

// 		         var button = $(event.relatedTarget);
// 		         var deleteUrl = button.data('title');
// 		         var modal = $(this);

		         //alert("test");
// 			 		$('#modalEvnTest123').bPopup();

	         }); 
			
			// 목록버튼 클릭이벤트
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
			
			//신고확인버튼 클릭이벤트
			$("#reportBtn").click(function() {
				var reportReason = $("#reasonTxt").val();
				alert("해당 게시글을 신고하시겠습니까?");
				$("#reason").val(reportReason);
				$("#reportFrm").submit();
			});
			
			//신고취소버튼 클릭이벤트
			$("#cancelBtn").click(function() {
				$("#cancelFrm").submit();
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
				$("#cmtNoDel").val(cmtNoDel);
				$("#cmtDelFrm").submit();
			});
			
			//댓글좋아요버튼 클릭이벤트
			$("#likeBtn").click(function() {
				
				//클릭한 cmtTr의 cmtNo값을 출력
				var cmtNo = $(this).data("cmtnum");
				
				$("#cmtNo").val(cmtNo);
				console.log("cmtNo" +  cmtNo);
				$("#cmtLikeFrm").submit();
			});
			
		});
	</script>
  </body>
</html>
    