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

</head>

<body>

<%--  <%@ include file="/WEB-INF/views/module/header.jsp" %> --%>

    <div class="container-fluid">
      <div class="row">
      <%--   <%@ include file="/WEB-INF/views/module/left.jsp" %> --%>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">수정</h1>
			<form id="frm" action="${cp}/board/boardUpd" method="post" class="form-horizontal" role="form">
				<input type="hidden" id="board_num" name="board_num" value="${board_dVO.board_num}" />
				
				<div class="form-group">
					<label for="userNm" class="col-sm-3 control-label">제목 : </label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="title" name="title" placeholder="제목" />
					</div>
				</div>
				
				<div class="form-group">
					<label for="userNm" class="col-sm-1 control-label">작성자 : </label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="userId" placeholder="작성자" readonly />
					</div>
				</div>

				<div class="form-group">
					<label for="userNm" class="col-sm-1 control-label">작성일 :</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="upd_date" placeholder="작성일" readonly />
					</div>
				</div>

				<div class="form-group">
					<label for="userNm" class="col-sm-1 control-label">내용 : </label>
					<div class="col-sm-9">
						<input type="text" class="form-control" id="content" name="content" placeholder="내용">
					</div>
				</div>
				
				</br></br>
				<div class="form-group">
					<div class="col-sm-3">
						<input type="button" id="updBtn" value="수정완료" class="btn btn-default" />
					</div>
				</div>
</form>
            
        </div>
      </div>
    </div>




	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

	<script src="/SE2/js/HuskyEZCreator.js"></script>
	<script type="text/javascript">
	
	function initData(){
		$("#title").val("${board_dVO.title}");
		$("#userId").val("${board_dVO.userId}");
		$("#upd_date").val("${board_dVO.upd_date}");
		$("#content").val("${board_dVO.content}");
	}
	
		$(document).ready(function() {
			
			initData();
			
			//수정완료버튼 클릭이벤트
			$("#updBtn").click(function() {
				$("#frm").submit();
			});
			
		});
	</script>




</body>
</html>