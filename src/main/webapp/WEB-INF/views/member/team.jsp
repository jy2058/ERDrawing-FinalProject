<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<link rel="stylesheet" href="/css/boxErd.css">
<link rel="stylesheet" href="/css/member/modify.css">
<link rel="stylesheet" href="/css/member/mypage.css">
<link rel="stylesheet" href="/css/team/toggle-switches.css">

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
						<c:forEach var="teamMemberGet" items="${teamMember }" varStatus="status">
							<li data-memid="${teamMemberGet.memId }" data-teamno="${teamList[status.index].teamNo }"> <!-- ajax를 위한 커스텀 데이터 생성 -->
								<a>
									<div>
										<img alt="" src="/member/memberImg?memId=${teamMemberGet.memId }">
									</div>
									<div>
										<strong>${teamMemberGet.memId }</strong>
										<span>${teamMemberGet.memMail }</span>
									</div>
								</a>
								<div>
									<span class="memAuth">${teamList[status.index].teamAuth }</span>
								</div>
								 
								 <!-- 팀 생성자이면서 권한이 creator가 아닌 것(user, admin) -->
								  <c:if test="${teamList[status.index].teamAuth ne 'creator' and teamInfo.makerId eq loginId }"> 
									<input type="checkbox" class="toggle-switch" name="authCheck" style="font-size: 1px;" value="${teamList[status.index].teamAuth }"
									<c:if test="${teamList[status.index].teamAuth eq 'admin'}"> <!-- 권한 admin일 경우 checked -->
										checked
									</c:if>
									>
									<button type="button" class="close delBtn" style="color: white">x</button>
								</c:if>
								
								<c:if test="${teamMemberGet.memId eq loginId and teamInfo.makerId ne loginId}"> <!-- 본인일 경우 삭제버튼 활성화(생성자는 삭제 X) -->
									<button type="button" class="close delBtn" style="color: white">x</button>
									
								</c:if>

	
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

<script>
	// 팀 멤버 권한 변경(user <-> admin)
	$("input[name=authCheck]").on("click", function(e){ 
		var teamAuth = this.value;
		var memId = $(e.target).closest('li').data("memid");
		var teamNo = $(e.target).closest('li').data("teamno");
		
		$.ajax({
			type : "get",
			url : "${cp}/team/authUpdate",
			data : {teamNo : teamNo,
					memId : memId,
					teamAuth : teamAuth},
			success : function(data){
				$(e.target).closest('li').find(".memAuth").html(data.auth);
				$(e.target).val(data.auth);
			},
			error : function(xhr, status, error){
				aalert("에러");
			}
		});
	});
	
	
	
	
	
	// 팀 멤버 삭제
	$(".delBtn").on("click", function(e){
		var memId = $(e.target).closest('li').data("memid");
		var teamNo = $(e.target).closest('li').data("teamno");		
		
		var result = confirm("삭제하시겠습니까?");
		if(!result){
			return;
		}
		
		$.ajax({
			type : "get",
			url : "${cp}/team/delMember",
			data : {teamNo : teamNo,
					memId : memId },
			success : function(data){
				$(e.target).closest('li').remove();
			},
			error : function(xhr, status, error){
				alert("에러");
			}
		});
		
	});
</script>

