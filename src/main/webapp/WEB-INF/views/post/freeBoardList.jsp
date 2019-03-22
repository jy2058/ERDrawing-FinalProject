<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> -->

<!-- Custom styles for this template -->
<link href="${cp }/css/boxErd.css" rel="stylesheet">
</head>

<body>
<%@ include file="/WEB-INF/views/template/header.jsp"%>
   <div class="container-fluid">
      <div class="row">
         <div class="col-sm-3 col-md-2 sidebar">
            <%@ include file="/WEB-INF/views/post/left.jsp"%>
         </div>
         <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h2 class="page-header">${boardNm} </h2>
            <div class="table-responsive">
               <table class="table table-striped">
                  <thead>
                     <tr>
                        <th>글번호</th>
                        <th>글제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                     </tr>
                  </thead>
                  <tbody>
                      <c:forEach items="${postList }" var="post">
                       <c:choose>
                       	 <c:when test="${board.postDelFlag=='F' }">
                       		<tr>
                       			<td>삭제된 게시글 입니다.</td>
                       		</tr>
                       	</c:when>
                       	<c:otherwise> 
	                        <tr class="boardTr" data-postNo="${post.postNo }" data-boardNo="${post.boardNo }">
	                           <td>${post.postNo }</td>
	                           <td>${post.postTitle }</td>
	                           <td>${post.writerId }</td>
	                           <td><fmt:formatDate value="${post.postRegDt }" pattern="yyyy/MM/dd"/></td>
	                        </tr>
                         </c:otherwise>
                        </c:choose> 
                     </c:forEach> 
                  </tbody>
               </table>
               <%-- <form action="${cp }/post/boardInsert" method="get">
                  <button type="submit" class="btn btn-default">등록</button>
                  <input type="hidden" id= "board_code" name="board_code" value="${board_code }" />
               </form> --%>
            <c:set var="lastPage" value="${Integer(boardCnt/pageSize + (boardCnt%pageSize > 0 ? 1 : 0))}"/>
               
			<nav style="text-align: center;">
					<ul class="pagination">
						<c:choose>
							<c:when test="${paging.pageNo eq 1}">
								<li class="disabled"><a ria-label="Previous"> 
									<span aria-hidden="true">&laquo;</span>
								</a></li>
							</c:when>
							<c:otherwise>
								<li><a href="/post/postList?boardNo=${boardNo}&boardNm=${boardNm}&page=${paging.prevPageNo}" aria-label="Previous">
									<span aria-hidden="true">&laquo;</span>
								</a></li>
							</c:otherwise>
						</c:choose>
						<c:forEach begin="${paging.startPageNo}" end="${paging.endPageNo}" var="i">
							<c:set var="active" value="" />
							<!-- 	초기화 과정 값이 계속 남기때문에 -->
							<c:if test="${i eq paging.pageNo}">
								<c:set var="active" value="active" />
							<!-- 	현재 페이지일 때 활성화를 위해서 -->
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
               
               
            </div>
         </div>
      </div>
   </div>

   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

        <script>
        /* 문서로딩이 완료된 이후 이벤트 등록 */
          $(document).ready(function(){
            console.log("document ready");
             
           //사용자 tr 태그 클릭시 이벤트 핸들러 
         $(".boardTr").on("click",function(){
             console.log("boardTr click");   
             
              var postNo = $(this).data("postNo");
              var boardNo = $(this).data("boardNo");
             
              $("#postNo").val(board_num);
              $("#boardNo").val(board_code);
              $("#frm").submit();
          });
       });
     </script>
     <form id="frm" 
        action="${cp}/post/boardDetail" method="get">
        <input type="hidden" id = "postNo" name = "postNo" value="${postNo}"/>
        <input type="hidden" id = "boardNo" name = "boardNo" value="${boardNo}"/>
     </form>
</body>

</html>







