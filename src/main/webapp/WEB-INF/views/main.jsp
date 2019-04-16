<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="/css/boxErd.css">

<style>
.tag-a{
    margin: 3px;
    padding: 3px;
    background-color: #444444;
    font-size: 11px;
}
</style>

<div id="contents">
	
	<div class="mov">
		<div class="container">

			<div class="youtube-title"><h2>최종 프로젝트가 시작되었습니다.</h2></div>
			<div class="youtube-bg"><div class="youtube"><span><img width="200px" src="/image/youtube.png" /></span></div></div>
			<div class="youtube-btn btn-style1">ERDrawing 사용해보기</div>
		</div>
	</div>
	<c:if test=""></c:if>
		
    <div class="container">

		<div class="best-erd-title">
		  <h1>MOST POPULAR ERD</h1>
		  <p class="lead">ERD List</p>
		</div>
		
		
		<div class="best-erd-list">
			<div class="inner-container">
				<div class="col-sm-12">
					 <ul class="erd-box-list">
						<c:forEach var="erdList" varStatus="status" items="${erdList }">
							<li class="erd-box-item erdClick" onclick="erdClick(${erdList.erdNo})">
								<a class="preview-box">
									<div class="bg-box">
										<img src="${cp }/erd/erdImg?erdNo=${erdList.erdNo}">
										<div class="table-bg-text">
											<div class="bg-text shinys">&nbsp;${erdList.erdTitle }
											</div>
										</div>
									</div>
								</a>
								<div class="description-item">
									<div style="float: left;">${erdList.erdTitle }</div>
									<!-- erd public / private에 따라 자물쇠 이미지 변경 -->
									<div style="float: right;">${erdList.erdScope }</div>



									<ul class="tagList" style="clear: both;">
										<c:forEach var="entry" items="${erdTagListMap }">
											<c:if test="${entry.key eq erdList.erdNo}">
												<c:set var="value" value="${entry.value }" />
												<c:forEach var="tagVo" items="${value}">
													<a class="tag-a" href="${cp}/library?tagContent=${tagVo.tagContent }" title="" class="tagSearch">${tagVo.tagContent }</a>
												</c:forEach>

											</c:if>
										</c:forEach>
									</ul>
								</div>

							</li>



						</c:forEach>			  			
					  			</ul>
					  		</div>
				 </div>
			</div>
		</div>
		
	</div>
