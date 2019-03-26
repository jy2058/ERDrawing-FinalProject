<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
#contents{
background:#3d3d3d;
}

.join-title{
	margin:50px 0;
}

.submit-btn{
	margin:10px 0 50px 0;
	width:100px;
}

.member input memLang {
	margin:10px 0 50px 0;
	width: 10px;
}
	
</style>

<div class="member">
	<div class="join-title">
		<h3>ERDrawing</h3>
		<h1>Sign Up</h1>
	</div>
	
	<form>
	
		<span>이름</span>
		<input type="text" id="memNm" name="memNm"/>
		<span>아이디</span>
		<input type="text" id="memId" name="memId"/>
		<span>이메일</span>
		<input type="text" id="memMail" name="memMail"/>
		<span>비밀번호</span>
		<input type="text" id="memPass" name="memPass"/>
		<span>비밀번호 확인</span>
		<input type="text" id="memPass" name="memPass"/>
		<span>언어</span>
		<div class=".member input memLang"><input  type="radio"  name="memLang" value="kr" />kr</div>
		<div class=".member input memLang"><input type="radio"  name="memLang" value="en"/>en</div>
		<span>핸드폰 번호</span>
		<input type="text" id="memTel" name="memTel"/>

		
		<div class="submit-btn btn-style1">회원가입</div>
	</form>
</div>
