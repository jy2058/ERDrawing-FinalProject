<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="/css/boxErd.css">
<link rel="stylesheet" href="/css/member/modify.css">
<link rel="stylesheet" href="/css/member/mypage.css">


<div id="contents">
	<div class="my-bg">
		<div class="container">
			<div class="profile-info">
				<div class="memberId">${memberVo.memId }</div>
				<div class="memberEmail">${memberVo.memMail }</div>
				<div><div class="sampleImg"><div class="exText"><img src="${cp }/member/memberImg?memId=${memberVo.memId }"></div></div></div>
			</div>
		</div>
	</div>
	
	<div class="container">
		<div class="member">
		
			<div class="line-title">
				<h2 class="page-title">USER ERD</h2>
			</div>
			<div class="row">
						<div class="col-sm-12">
							 <ul class="erd-box-list">
							 	<c:forEach var="myErdList" varStatus="status" items="${myErdList }">
							 	<c:if test="${myErdList.erdScope eq 'public' }">
							  	<li class="erd-box-item">
						  			<c:if test="${SESSION_MEMBERVO.memId eq memberVo.memId }">
							  			<button type="button" class="btn btn-default delBtn" aria-label="trash" value="${myErdList.erdNo }">
										  <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
										</button>
									</c:if>
								  		<a class="preview-box">
								  			<div class="bg-box">
								  				<div class="bg-img">
									  				&nbsp;Image
									  			</div>
								  				<div class="table-bg-text">
								  					<div class="bg-text shinys">
								  						&nbsp;${myErdList.erdTitle }
								  					</div>
									  			</div>
									  		</div>
								  		</a>
								  		<div class="description-item">
								  			<div style="float:left;">${myErdList.erdTitle }</div>
								  			<!-- erd public / private에 따라 자물쇠 이미지 변경 -->
								  			<div style="float:right;">${myErdList.erdScope } </div>
								  			
								  			
								  			<ul class="tagList" style="clear:both;">
								  		<c:forEach var="entry" items="${erdTagListMap }">
								  			<c:if test="${entry.key eq myErdList.erdNo}">
								  				<c:set var="value" value="${entry.value }"/>
								  				<c:forEach var="tagVo" items="${value}">
								  				<li>${tagVo.tagContent }</li>
								  					
								  				</c:forEach>
								  					
								  			</c:if>
								  		</c:forEach>
								  			</ul>
								  		</div>
							  
							  	</li>
							  	
							  	
							  	</c:if>
								</c:forEach>
				
						  	</ul>
						 </div>
	
			</div> <!-- /row -->
			
		</div>
		
	</div>
</div>

<script>
	// erd 삭제
	$(".delBtn").on("click", function(e){
		var result = confirm("삭제하시겠습니까?");
		if(!result){
			return;
		}
		
		var erdNo = $(this).val();
		$.ajax({
			type : "get",
			url : "${cp}/erd/delErd",
			data : {erdNo : erdNo},
			success : function(data){
				$(e.target).closest('li').remove();
			},
			error : function(xhr, status, error){
				alert("에러");
			}
		});
	});
</script>



