<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
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
<link href="${cp}/css/boxErd.css" rel="stylesheet">

<script src="../../assets/js/ie-emulation-modes-warning.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script>
	$(document).ready(function(){
		
		//msg속성이 존재하면 alert 존재하지 않으면 넘어가기
		<c:if test="${msg != null}">
		alert("${msg}");
		<%-- <%session.removeAttribute("msg");%> //세션객체 지워주기 --%>
		</c:if>
		
		//수정버튼 클릭 시
		$("#updBtn").click(function(){
			 $("#frm").attr("method","get");
			 $("#frm").attr("action","${cp}/post/postUpd");
				$("#frm").submit();
			
		});
		
		/*삭제버튼 클릭 시  */
		$("#delBtn").click(function(){
			console.log("삭제버튼클릭");
			if(!confirm('정말로 삭제하시겠습니까?')){
				return;
			}
			 $("#frm").attr("method","post");
			 $("#frm").attr("action","${cp}/post/postDel");
				$("#frm").submit();
			
		});
		
		
		/* 댓글등록 버튼 눌렀을 때 */
		$("#CmtCreateBtn").click(function(){
			console.log("댓글버튼클릭");
			if($("#commentContent").val().trim() ==""){
				alert("댓글을 입력해주세요");
				$("#commentContent").focus();
				return;
			}
			if(!confirm('정말로 등록하시겠습니까?')){
				return;
			}
			 $("#frm").attr("method","post");
			 $("#frm").attr("action","${cp}/comment/createComment");
				$("#frm").submit();
		});
	});	
		
	</script>
</head>



			<h1 class="page-header">${infoMap.boardNm}-
				<span style="font-size: 20px;">상세보기</span>
			</h1>


			<form id="frm" action="${cp}/post/postForm"
				method="get" class="form-horizontal" role="form">

				<div class="form-group">
					<label for="postTitle" class="col-sm-1 control-label">제목</label>
					<div class="col-sm-7">
						<label class="form-control" id="postTitle">
							${postVo.postTitle}</label>
					</div>
				</div>


				<div class="form-group">
					<label for="userId" class="col-sm-1 control-label">작성자</label>
					<div class="col-sm-7">
						<label class="form-control" id="userId">${postVo.userId}</label>
					</div>
				</div>

				<div class="form-group">
					<label for="post_Reg_Dt" class="col-sm-1 control-label">작성일</label>
					<div class="col-sm-7">
						<label class="form-control" id="userId">${postVo.fmtDate}</label>
					</div>
				</div>


				<div class="form-group">
					<label for="userId" class="col-sm-1 control-label">첨부파일</label>
					<div class="col-sm-7">
						<c:if test="${fn:length(uploadFileList ) eq 0}">
							<label class="form-control" id="userId">첨부파일 없음</label>
						</c:if>
						<c:forEach items="${uploadFileList}" var="uploadFileVo">
							<label class="form-control" id="userId"><a
								href="${cp}/post/download?uploadFileNo=${uploadFileVo.uploadFileNo}">${uploadFileVo.uploadFileName}</a></label>
						</c:forEach>
					</div>
				</div>

				<div class="form-group">
					<label for="smarteditor" class="col-sm-1 control-label">글
						내용</label>
					<div class="col-sm-7" style="border-style:solid; border-color: gray;" >
				<%-- 	<textarea id="smarteditor" rows="10" cols="50">${postVo.postContent}</textarea> --%>
					${postVo.postContent}
					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-offset-1 col-sm-11">
						<button type="submit" id="regBtn" class="btn btn-default">답글달기</button>
						<c:if test="${sessionScope.userVo.userId eq postVo.userId}">
							<button type="button" id="updBtn" name="regBtn"
								class="btn btn-default">수정</button>
							<button type="button" id="delBtn" name="delBtn"
								class="btn btn-default">삭제</button>
							<input type="hidden" name="postNo" value="${infoMap.postNo}"
								class="btn btn-default" />
							<input type="hidden" name="post_Gn" value="${infoMap.post_Gn}"
								class="btn btn-default" />
							<input type="hidden" name="boardNm" value="${infoMap.boardNm}" 
								class="btn btn-default" />
							<input type="hidden" name="boardNo" value="${infoMap.boardNo}"  
								class="btn btn-default" />
						</c:if>
					</div>
				</div>
					name${infoMap.boardNm}
					no${infoMap.boardNo}
					<hr></hr>
						<div class="form-group">
					<label for="post_Reg_Dt" class="col-sm-1 control-label">댓글</label>
					<div class="col-sm-7">
					</div>
				</div>
					
				<div class="form-group">
					<label for="post_Reg_Dt" class="col-sm-1 control-label" >${sessionScope.userVo.userId}</label>
					<div class="col-sm-7"style="display:inline;">
						<textarea  cols="10" rows="2" class="form-control" id="commentContent" name="commentContent" placeholder="댓글을 입력해주세요."></textarea>
							<input type="hidden" name="userId" value="${sessionScope.userVo.userId}"/>
					</div>
						<button type="button" id="CmtCreateBtn" name="CmtCreateBtn" class="btn btn-default">작성</button>
				</div>
			</form>
			
				<div class="form-group">
                  <c:forEach items="${commentList}" var="comment">
                  <c:if test="${comment.comment_Del_Flag eq 'T'}">
                  <dd>
                  <label for="userId" class="col-sm-1 control-label">${comment.userId}</label>
				     <label>${comment.commentContent}</label>
					<c:if test="${comment.userId eq sessionScope.userVo.userId}">
					<a href="${cp}/comment/delComments?postNo=${infoMap.postNo}&post_Gn=${infoMap.post_Gn}&boardNo=${infoMap.boardNo}&commentNo=${comment.commentNo}">X</a>
					</c:if>
                   </dd>
                   </c:if>
                  </c:forEach>
                  </div>
               
           
			
			


