<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/css/member/modify.css">
<style>

.my-bg {
	position:relative;
	height: 300px;
	width: 100%;
	background: #232323;
	color: #fff;
}


.profile-info{
	position:absolute;
	left:50%;
	bottom:-250px;
	transform:translate(-50%, -50%);
	
	background:#eee;
}

.sampleImg{
	width:100px;
	margin:0 auto;
}

.exText{
	height:100px;
}

.memberId{
	font-size:30px;
	text-align:center;
}

.memberEmail{
	font-size:20px;
	text-align:center;
}

	
</style>


<div id="contents">
	
	<div class="my-bg">
		<div class="container">
			<div class="line-btn btn-style1">수정완료</div>
			
			<div class="profile-info">
				<div class="memberId">아이디 출력 위치</div>
				<div class="memberEmail">이메일 출력 위치</div>
				<div><div class="sampleImg"><div class="exText">Profile Image</div></div></div>
			</div>

		</div>
	</div>
		
		
	
	
	<div class="container">
		<div class="member">
		
		
			<div class="line-title">
				<h1 class="page-title">EDIT PROFILE</h1>
				
			</div>
			
			
			<div class="row">
				<div class="profileImg col-sm-4">
					<div class="sampleImg"><div class="exText">Profile Image</div></div>		<!-- 예시로 만들어 놓음 -->
					<div class="img-btn btn-style1">프로필 이미지 올리기</div>
				</div>
				
				
				<div class="col-shinys-1 col-shinys-offset">
					<form class="label-member">
					
						<span>이름</span>
						<input type="text" />
						<span>아이디</span>
						<input type="text" />
						<span>이메일</span>
						<input type="text" />
						<span>비밀번호</span>
						<input type="text" />
						<span>비밀번호 확인</span>
						<input type="text" />
				
					</form>
					
					<div class="label-memberDel">
						<span>계정삭제</span>
					</div>
				
				
				</div>
		
			</div>
		
		</div>
		
	</div>
</div>
