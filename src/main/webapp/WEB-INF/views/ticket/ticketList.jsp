<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="/css/boxErd.css">


<style>
.erd-box-item {
    position: relative;
    display: inline-block;
    width: 800px;
    margin-right: 2%;
    margin-bottom: 2%;
    /* float: left; */
    color: #000;
    border: 3px solid #000;
    vertical-align: top;
}

.erd-search{
display:block;
padding:20px 0 20px;
}

.erd-search-txt{
display:inline-block;
margin-right:10px;
height:10px;
}

.erd-search-btn{
display:inline-block;
padding:5px 10px;
background:#fff;
color:#000;
}
</style>

<div class="erd-search">
</div>



<div class="best-erd-list">
	<div class="inner-container">
		<div class="col-sm-12">
			 <ul class="erd-box-list">
			 
			 	<c:forEach items="${ticketList }" var="ticket">
			  	<li class="erd-box-item">

			  		<a class="preview-box">
			  			<div class="bg-box">
			  				<div class="bg-img">
				  				&nbsp;${ticket.ticketContent }
				  			</div>
			  				<div class="table-bg-text">
			  					<div class="bg-text shinys">
			  						&nbsp;${ticket.ticketPrice }
			  					</div>
				  			</div>
				  		</div>
			  		</a>
			  		<div class="description-item">
			  		이용권 설명
			  		</div>
			  		
			  	</li>
				</c:forEach>

		  	</ul>
		 </div>
	</div>
	
	<input type="button" class="money" value="fff">
<script type="text/javascript"></script>
</div>