<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<link href="/js/ticket/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
    <link href="/js/ticket/daterangepicker.css" rel="stylesheet" media="all">
    <link href="/css/ticket.css" rel="stylesheet" media="all"> 
    <link href="/js/ticket/select2.min.css" rel="stylesheet" media="all">
    <div style="padding-top: 100px"></div>


<div class="tab-content" >
	<div class="tab-pane active" id="tab1">
		<form method="POST" action="#">

			<div class="row row-space">
				<div class="col-2">
					<div class="input-group">
						<label class="label">to:</label> <input class="input--style-1"
							type="text" name="check-in" placeholder="mm/dd/yyyy"
							id="input-start" width="100px">
					</div>
				</div>
				<div class="col-2">
					<div class="input-group">
						<label class="label">end:</label> <input class="input--style-1"
							type="text" name="check-out" placeholder="mm/dd/yyyy"
							id="input-end">
					</div>
				</div>

			
				<div class="input-group input-group-big">
				
				<label class="label">검색 조건:</label>
						<div class="rs-select2 js-select-simple select--no-search" style="width: 100px">
							<select name="car-group">
								<option selected="selected">날짜</option>
								<option>구매자</option>
								<option>티켓</option>
								<option>환불여부</option>
							</select>
							<div class="select-dropdown"></div>
						</div>
				
				
					<label class="label" style="padding-left: 30px">where:</label> <input name="address"
						class="input--style-1" required="required" type="text" style="width: 260px"
						placeholder="검색조건을 입력해주세요"> 
						<i class="zmdi zmdi-search input-group-symbol" style="cursor: pointer;" id="searchBtn"></i>
				</div>

			</div>

		</form>
	</div>

</div>


<!-- ===============환불내역 테이블=================  -->
<div>
    	<table border="1">
    		<thead>
	    		<tr>
	    			<th>티켓</th>
	    			<th>티켓구매일</th>
	    			<th>구매자</th>
	    			<th>은행명</th>
	    			<th>계좌번호</th>
	    			<th>예금주명</th>
	    			<th>상태</th>
	    		</tr>
	    	</thead>
    		
    		<tbody id="ticketRefListTbody"> 		</tbody>
    	</table>

			<nav id="divNav" style="text-align: center;">
				<ul class="pagination" id="pagination">
				</ul>
			</nav>
</div>
    
    <script src="/js/ticket/select2.min.js" type="08a3d66d4e4ffeca331a2908-text/javascript"></script>
    <script src="/js/ticket/moment.min.js" type="08a3d66d4e4ffeca331a2908-text/javascript"></script>
    <script src="/js/ticket/daterangepicker.js" type="08a3d66d4e4ffeca331a2908-text/javascript"></script>
    <script src="/js/ticket/global.js" type="08a3d66d4e4ffeca331a2908-text/javascript"></script>
	<script src="https://ajax.cloudflare.com/cdn-cgi/scripts/a2bd7673/cloudflare-static/rocket-loader.min.js" data-cf-settings="08a3d66d4e4ffeca331a2908-|49" defer=""></script></body><!-- This templates was made by Colorlib (https://colorlib.com) -->
	<script>
	$(document).ready(function() {
		getTicketRefPageListHtml(1);	//페이징 아작스
	
		$("#searchBtn").on("click",function(){
			console.log($("#input-start").val());
		});
	});
	
	//전체 테이블 Ajax처리
	function getTicketRefPageListHtml(page) {
		$
				.ajax({
					url : "${cp}/ticket/ticketRefAjaxList",
					data : {
						page : page
					},
					success : function(data) {
						console.log(data);
						var htmlArr = data
								.split("======================seperator==========================");
						$("#ticketRefListTbody").html(htmlArr[0]);
						$("#pagination").html(htmlArr[1]);
					}
				});
	}
	</script>
    