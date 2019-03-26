<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    

<style>
.background-etc{
position:absolute;
z-index:9000;
display:none;
width:100%;
height:100%;
left:0;
top:0;
background:#000;
color:#fff;
}


.background-etc.bg-on{
	display:block;
}

.erd-add{
   /*  position: relative;
    width: 32%;
    margin-right: 2%;
    margin-bottom: 2%;
    float: left; */
    border: 2px solid #fff;
    background-color : #1e1e1e;
    width : auto;
    color: #fff; 
}

.erd-add.h1{
	position: relative;
    padding: 5px 44px 5px 10px;
    margin: 0;
    background-color: #4a4a4a;
}

.input-box{
	display: table;
	padding: 10px;
}

.input-box.text-label{
	position: relative;
	display: table-cell;
	width: 34%;
	padding: 5px 40px 5px 0;
	color: white;
	padding-right: 10px;
}

</style>



<div class="background-etc">
	<div class="erd-add">
		<h1 class="erd-add h1">Create team</h1>
		<form action="/team/teamCreate" id="teamCreateFrm" method="post" enctype="multipart/form-data">
			<div class="input-box">
				<label>팀이름</label>
				<input type="text" id="title" name="teamNm" placeholder="팀이름">
			</div>
			<div class="input-box">
				<label>팀회원</label>
				<input type="text" placeholder="팀회원" name="teamMember">
			</div>
			<div class="input-box">
				<label>팀설명</label>
				<textarea rows="" cols="" name="teamIntro"></textarea>
			</div>
			<div class="input-box">
				<label>썸네일 이미지</label>
				<input type="image" src="${cp }/image/no_img.jpg">
				<input type="file" name="profileImg"> 
			</div>
			
			
		</form>
		<div class="cancle-btn btn-style1">취소</div>
		<div class="cancle-btn btn-style1" id="teamCreate">만들기</div>
	</div>
</div>



<script>

	$(document).ready(function(){
		//팀 생성버튼 클릭 시 화면 띄우기
		 $("#teamAdd").on("click", function(){
			var height = $(document).height();
// 			$(".background-etc").addClass("bg-on");
			$(".background-etc").css({"display":"block", 
									  "height" : height + "px"});
		}); 
		
		// 취소버튼 클릭 시 화면 띄우기
		$(".cancle-btn").on("click", function(){
			$(".background-etc").css("display","none");
// 			$(".background-etc").removeClass("bg-on");
		});
		
		$("#teamCreate").on("click", function(){
			//alert($("#title").val());
			$("#teamCreateFrm").submit();
		});
	});
</script>
