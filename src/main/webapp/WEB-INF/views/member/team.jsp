<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="/css/boxErd.css">
<link rel="stylesheet" href="/css/member/modify.css">
<link rel="stylesheet" href="/css/member/mypage.css">

<style>
.profile-info{
	bottom:-130px;
}
.memberId{
	margin-bottom:10px;
}

</style>

<div id="contents">
	
	<div class="my-bg">
		<div class="container">
			<div class="inner-container">
				<a href="#" class="btn-style2">Edit Team</a>
			</div>	
				
				
			<div class="profile-info">
				<div class="memberId">${teamInfo.teamNm }</div>
				<div><div class="sampleImg"><div class="exText"><img src="${cp }/team/teamImg?teamNo=${teamInfo.teamNo}"></div></div></div>
			</div>
		</div>
	</div>
		
		
	
	
	<div class="container">
		<div class="member">
		
		
			<div class="line-title">
				<h2 class="page-title">TEAM</h2>
				<a class="add-btn1" id="teamAdd">+</a>
			</div>
			
			<div class="row">
				<div style="background:#232323; color:#fff; height:100px; line-height:100px; padding-left:20px; font-size:20px; font-weight:600;">
					<ul style=" min-height:72px; line-height: 1.5">
					<c:forEach var="teamList" items="${teamInfoList }" >
						<li><a href="/team?teamNo=${teamList.teamNo }">
						${fn:toUpperCase(fn:substring(teamList.teamNm,0,1 ))}
							<span>${teamList.teamNm }</span>
							</a>
						</li>
					</c:forEach>
					</ul>
				</div>
			</div>
	
	
			<div class="line-title">
				<h2 class="page-title">TEAM MEMBER</h2>
			</div>
			
			<div class="row">
				<div style="background:#232323; color:#fff; height:100px; line-height:100px; padding-left:20px; font-size:20px; font-weight:600;">
					<ul style=" min-height:72px; line-height: 1.5">
						<c:forEach var="teamMember" items="${teamMember }" varStatus="status">
							<li>
								<a>
									<div>
										<img alt="" src="/member/memberImg?memId=${teamMember.memId }">
									</div>
									<div>
										<strong>${teamMember.memId }</strong>
										<span>${teamMember.memMail }</span>
									</div>
								</a>
								<div>
									<span>${teamList[status.index].teamAuth }</span>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div class="line-title">
				<h2 class="page-title">TEAM ERD</h2>
				<a class="add-btn1" id="myAdd">+</a>
			</div>
			<div class="row">
						<div class="col-sm-12">
							 <ul class="erd-box-list">
							 
							 	<c:forEach var="teamErdList" varStatus="status" items="${teamErdList }">
							  	<li class="erd-box-item">
									
								  		<a class="preview-box">
								  			<div class="bg-box">
								  				<div class="bg-img">
									  				&nbsp;Image
									  			</div>
								  				<div class="table-bg-text">
								  					<div class="bg-text shinys">
								  						&nbsp;${teamErdList.erdTitle }
								  					</div>
									  			</div>
									  		</div>
								  		</a>
								  		<div class="description-item">
								  			<div style="float:left;">${teamErdList.erdTitle }</div>
								  			<!-- erd public / private에 따라 자물쇠 이미지 변경 -->
								  			<div style="float:right;">${teamErdList.erdScope } </div>
								  			
								  			
								  			
								  			<ul class="tagList" style="clear:both;">
								  		<c:forEach var="entry" items="${erdTagListMap }">
								  			<c:if test="${entry.key eq teamErdList.erdNo}">
								  				<c:set var="value" value="${entry.value }"/>
								  				<c:forEach var="tagVo" items="${value}">
								  				<li>${tagVo.tagContent }</li>
								  					
								  				</c:forEach>
								  					
								  			</c:if>
								  		</c:forEach>
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
