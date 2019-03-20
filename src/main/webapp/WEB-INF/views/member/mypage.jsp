<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="/css/boxErd.css">
<link rel="stylesheet" href="/css/member/modify.css">
<link rel="stylesheet" href="/css/member/mypage.css">


<div id="contents">
	
	<div class="my-bg">
		<div class="container">
			<div class="inner-container">
				<a href="/modify" class="btn-style2">프로필 수정</a>
			</div>	
				
				
			<div class="profile-info">
				<div class="memberId">아이디 출력 위치</div>
				<div class="memberEmail">이메일 출력 위치</div>
				<div><div class="sampleImg"><div class="exText">Profile Image</div></div></div>
			</div>
		</div>
	</div>
		
		
	
	
	<div class="container">
		<div class="member">
		
		
			<div class="line-title">
				<h2 class="page-title">TEAM</h2>
				<a class="add-btn1">+</a>
			</div>
			
			<div class="row">
				<div style="background:#232323; color:#fff; height:100px; line-height:100px; padding-left:20px; font-size:20px; font-weight:600;">
					팀 리스트 출력위치
				</div>
			</div>
	
			
			<div class="line-title">
				<h2 class="page-title">MY-ERD</h2>
				<a class="add-btn1">+</a>
			</div>
			
			
			<div class="row">
				

						<div class="col-sm-12">
							 <ul class="erd-box-list">
							 
							 	<c:forEach begin="0" end="5" var="idx" varStatus="status">
							  	<li class="erd-box-item">
				
							  		<a class="preview-box">
							  			<div class="bg-box">
							  				<div class="bg-img">
								  				&nbsp;Image${idx }
								  			</div>
							  				<div class="table-bg-text">
							  					<div class="bg-text">
							  						&nbsp;Image${idx }
							  					</div>
								  			</div>
								  		</div>
							  		</a>
							  		<div class="description-item">
							  			<div style="float:left;">ERD제목 ${idx }</div>
							  			<div style="float:right;">Lock </div>
							  			
							  			<ul style="clear:both;">
							  				<li>Tag</li>
							  				<li>Tag</li>
							  				<li>Tag</li>			  			
							  			</ul>
							  		</div>
							  		
							  	</li>
								</c:forEach>
				
						  	</ul>
						 </div>
	
		
			</div> <!-- /row -->
			
			
			
		</div>
		
	</div>
</div>
