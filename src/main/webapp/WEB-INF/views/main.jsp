<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="/css/boxErd.css">


<div id="contents">
	
	<div class="mov">
		<div class="container">
		
			<div class="youtube-title"><h2>최종 프로젝트가 시작되었습니다.-한수-유수1</h2></div>
			<div class="youtube-bg"><div class="youtube"><span><img width="200px" src="/image/youtube.png" /></span></div></div>
			<div class="youtube-btn btn-style1">ERDrawing 사용해보기</div>
		</div>
	</div>
		
    <div class="container">

		<div class="best-erd-title">
		  <h1>MOST POPULAR ERD</h1>
		  <p class="lead">ERD List</p>
		</div>
		
		
		<div class="best-erd-list">
			<div class="inner-container">
				<div class="col-sm-12">
					 <ul class="erd-box-list">
					 
					 	<c:forEach begin="0" end="11" var="idx" varStatus="status">
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
			</div>
		</div>
		
	</div>
</div>