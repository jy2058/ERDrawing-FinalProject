<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="/css/boxErd.css">
<link rel="stylesheet" href="/css/member/memList.css">




	<div class="youtube-title">
		<h2>회원정보 리스트</h2>
	</div>
	<br />
	<br />

<!----------------------------- 회원정보 테이블 -------------------------->
<form id="frm" action="${cp }/member/memberDel"><div id="guswl">	
	<table >

		<thead>
			<tr>
				<th>#</th>
				<th>Name</th>
				<th>Id</th>
				<th>Date Created</th>
				<th>Auth</th>
				
				<th>Status</th>
				<th>Action</th>
				<th></th>
			</tr>
		</thead>

		<tbody id="memListTbody">
			
		</tbody>
		
		
		
	</table>
		<nav id="divNav" style="text-align: center;">
					<ul class="pagination" id="pagination">
						
						

						
					</ul>
				</nav>
	
	</div>


</form>




<script type="text/javascript">
	var memId="";
		$(document).ready(function(){
			getPostPageListHtml(1);
			
			$("#memListTbody").on('click',".d1 ul li",function() {
		$(this).find("ul").stop().fadeToggle(350);
	});
	
	//이미지 x표시 클릭시 사용자 삭제
	$("#memListTbody").on("click",".delImg",function() {
		if (confirm("정말 삭제하시겠습니까??") == true){   
			memId=$(this).data("memid");
			alert(memId+"dd");
			getPostPageListHtmlDel(1,memId);
		
		}else{   //취소

		     return false;

		 }
	});
	
		});

		//삭제후 Ajax처리
	function getPostPageListHtmlDel(page,memId) {
		$.ajax({
		url:"${cp}/member/memberDel",
		data :{memId :memId,
			   page:page  },
		
		success:function(data){

			
			var htmlArr = data.split("======================seperator==========================");
			$("#memListTbody").html(htmlArr[0]);
			$("#pagination").html(htmlArr[1]);
		}
			
	});}
	
	
	//전체 테이블 Ajax처리
	function getPostPageListHtml(page) {
		$.ajax({
		url:"${cp}/member/memberAjaxList",
		data :{
			   page:page  },
		success:function(data){

			
			var htmlArr = data.split("======================seperator==========================");
			$("#memListTbody").html(htmlArr[0]);
			$("#pagination").html(htmlArr[1]);
		}
			
	});}
	
</script>


