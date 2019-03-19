<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="/css/boxErd.css">


<style>
.erd-search{
display:block;
padding:20px 0 20px;
}

.erd-search-txt{
display:inline-block;
margin-right:10px;
height:30px;
}

.erd-search-btn{
display:inline-block;
padding:5px 10px;
background:#fff;
color:#000;
}
</style>

<div class="erd-search">
	<input name="erd-search-txt" class="erd-search-txt" type="text" /><div class="erd-search-btn">검색</div>
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