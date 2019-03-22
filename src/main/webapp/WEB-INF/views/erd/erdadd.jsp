<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

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
		<h1 class="erd-add h1">Create ERD</h1>
		<form action="/erd/erdAdd" id="erdAddFrm" method="post">
			<div class="input-box">
				<label>제목</label>
				<input type="text" id="title" name="erdTitle" placeholder="제목">
			</div>
			<div class="input-box">
				<label>태그</label>
				<input type="text" placeholder="태그">
			</div>
			<div class="input-box">
				<label>공유</label>
				<div>
					<div>
						<input type="radio">
						<label>공개</label>
					</div>
					<div>
						<input type="radio">
						<label>비공개</label>
					</div>
					<div>
						<input type="radio">
						<label>팀</label>
					</div>
				</div>
			</div>
			<div class="input-box">
				<label>태그</label>
				<select>
					<option value="">가입된 팀 목록 나올 거야1</option>
					<option value="">가입된 팀 목록 나올 거야2</option>
					<option value="">가입된 팀 목록 나올 거야3</option>
				</select>
			</div>
		</form>
		<div class="cancle-btn btn-style1">취소</div>
		<div class="cancle-btn btn-style1" id="erdAdd">만들기</div>
	</div>
</div>



<script>

	$(document).ready(function(){
		//ERD 생성버튼 클릭 시 화면 띄우기
		$("#myAdd").on("click", function(){
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
		
		$("#erdAdd").on("click", function(){
			//alert($("#title").val());
			$("#erdAddFrm").submit();
		});
	});
</script>
