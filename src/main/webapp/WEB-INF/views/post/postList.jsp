<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link href="${cp}/css/boxErd.css" rel="stylesheet">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
  </head>
			 
			  <div class="row">
        		<%@ include file="/WEB-INF/views/post/left.jsp" %>
              </div>
              
  
		<h1 class="page-header">${boardNm}</h1>

		<div class="table-responsive">
			<table class="table table-striped">
				<thead>
					<tr>
						<th>글번호</th>
						<th>글제목</th>
						<th>작성자</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${postList}" var="post">
						<tr class='postTr' data-postno="${post.postNo}" data-postgn="${post.postGn}" data-flag="${post.postDelFlag}">
				<td>${post.postNo}</td>
				<c:choose>
					<c:when test="${post.level gt 1}"> <!--레벨에 따른 공백주기  -->
					<td>
						<c:forEach begin="1" end="${post.level-1}">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</c:forEach>
					 <span style="color: red">└[RE]: </span>
						<c:choose>
							<c:when test="${post.postDelFlag eq 'T'}">
							 ${post.postTitle}
							</c:when>
							<c:otherwise>
							삭제된 답글입니다.
							</c:otherwise>								
						</c:choose>
					 
					 </td>
					</c:when>
					<c:otherwise>
					<td>
					<c:choose>
							<c:when test="${post.postDelFlag eq 'T'}">
							 ${post.postTitle}
							</c:when>
							<c:otherwise>
							<span style="color: red;">삭제된 게시글입니다.</span>
							</c:otherwise>								
						</c:choose>
					
					</td>
					</c:otherwise>
				</c:choose>			
							<td>${post.writerId}</td>
							<td>${post.postRegDt}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<form action="${cp}/post/postInsert" method="get">
			<input type = "hidden" name="boardNo" value="${boardNo}"> 
			   <button type="submit" class="btn btn-default">게시글 등록</button>
			</form>
		</div>

		<nav style="text-align: center;">
			<ul class="pagination">
				<c:choose>
					<c:when test="${paging.pageNo eq 1}">
						<li class="disabled"><a ria-label="Previous"> <span
								aria-hidden="true">&laquo;</span>
						</a></li>
					</c:when>
					<c:otherwise>
						<li><a
							href="${cp}/post/postList?boardNo=${boardNo}&boardNm=${boardNm}&page=${paging.prevPageNo}"
							aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
					</c:otherwise>
				</c:choose>
				<c:forEach begin="${paging.startPageNo}" end="${paging.endPageNo}" var="i">
					<c:set var="active" value="" />
				    <!-- 초기화 과정 값이 계속 남기때문에 -->
					<c:if test="${i eq paging.pageNo}">
						<c:set var="active" value="active" />
					<!-- 현재 페이지일 때 활성화를 위해서 -->
					</c:if>
					<li class="${active}"><a
						href="${cp}/post/postList?boardNo=${boardNo}&boardNm=${boardNm}&page=${i}">${i}</a>
					</li>
				</c:forEach>

				<c:choose>
					<c:when test="${paging.finalPageNo eq paging.pageNo}">
						<li class="disabled"><a ria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
					</c:when>
					<c:otherwise>
					
						<li><a
							href="${cp}/post/postList?boardNo=${boardNo}&boardNm=${boardNm}&page=${paging.nextPageNo}"
							aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</nav>

	<script>
		//문서 로딩이 완료된 이후 이벤트 등록 
		$(document).ready(function() {
			<c:if test="${msg != null}">
			alert("${msg}");
			<%session.removeAttribute("msg");%> //세션객체 지워주기
			</c:if>
			
			//사용자 tr태그 클릭 시 이벤트 핸들러 
			$(".postTr").click(function() {
				console.log("post click");

				//클릭한 post태그의 postNo값을 출력
				var flag = $(this).data("flag");
				if(flag == 'F'){
					alert("삭제된 글은 열람할 수 없습니다.")
					return;
				}
				
				var postNo = $(this).data("postno");
				var postGn = $(this).data("postgn");
				
				//2. form
				$("#postNo").val(postNo);
				$("#postGn").val(postGn);
				console.log("postNo" +  postNo);
				console.log("postGn" +  postGn);
				// $("#frm").attr("action","/userAllList"); 속성값 수정하는 방법  
				$("#frm").submit();

			});
		});
	</script>
		
	<form id="frm" action="${cp}/post/postDetail" method="get">
	<input type="hidden" name="postNo" id="postNo"/>
	<input type="hidden" name="postGn" id="postGn"/>
	<input type = "hidden" name="boardNo" value="${boardNo}"> 
	</form>

