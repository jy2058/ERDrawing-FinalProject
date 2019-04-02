<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
#contents {
	background: #3d3d3d;
}

.join-title {
	margin: 50px 0;
}

.submit-btn {
	margin: 10px 0 50px 0;
	width: 100px;
}

.memLang input {
	margin: 10px 0 0 0;
	width: 10px;
}

#memId{
margin: 0 0 0 0;
	width: 450px;
}

#check{
margin: 0 0 0 0;
	width: 100px;
}
</style>

<div class="member">
	<div class="join-title">
		<h3>ERDrawing</h3>
		<h1>Sign Up</h1>
	</div>

	<form id="frm" action="member/join" method="post">

		<span>이름</span> 
		<input type="text" id="memNm" name="memNm" /> 
		
		<span >아이디</span>
		<div >
		<input type="text" id="memId" name="memId" /> 
		<input type="button" class="btn-style1" id="checkId" name="checkId" value="중복" />
		
		</div>
		
		
		
		
		<span>이메일</span> 
		<input	type="text" id="memMail" name="memMail" /> 
		<input type="button" class="btn-style1" id="checkEmail" name="email" value="인증번호 보내기" />
		<div id="fileDiv"></div>
		<span>비밀번호</span> 
		<input	type="password" class="memPass" id="memPass"  oninput="checkPwd()" />
		 <span>비밀번호 확인</span> 
		 <input	type="password" class="memPass" id="reMemPass" name="memPass" oninput="checkPwd()" />
		 
		  <span>언어</span>
		<div class=".member input memLang">
			kr	<input type="radio" name="memLang" checked value="kr" />
			en	<input type="radio" name="memLang" value="en" />
		</div>
		
		<span>핸드폰 번호</span> <input type="text" id="memTel" name="memTel" />
 <div class="g-recaptcha" data-sitekey="6LfnUpoUAAAAAMtKydIehTmTDdm7JZUubAfHHVuf"></div>

		<div class="submit-btn btn-style1">회원가입</div>
	</form>
</div>
<script>
var checkId=0;
var checkInput=0;
var checkEmail=0;

	$(document).ready(function() {
		//회원가입 버튼 클릭시
		$(".submit-btn").on("click", function() {
			
			if($("#memNm").val().trim()==""){
				//$("#memId").val().trim()
				alert("이름을 입력해 주세요");
				$("#memNm").focus();
				return;
			}
			
			if($("#memId").val().trim()==""){
				//$("#memId").val().trim()
				alert("아이디를 입력해 주세요");
				$("#memId").focus();
				return;
			}
			
			if($("#memMail").val().trim()==""  ){
				//$("#memId").val().trim()
				
				alert("이메일을 입력해 주세요");
				$("#memMail").focus();
				return;
			}
			
			var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
			if($("#memMail").val().trim()==""  || exptext.test($("#memMail").val())==false){
				//$("#memId").val().trim()
				alert(" 메일형식이 올바르지 않습니다");
				$("#memMail").focus();
				return;
			}
			
			
		
			
			
			if($("#memPass").val().trim()==""){
				//$("#memId").val().trim()
				alert("비밀번호를 입력해 주세요");
				$("#memPass").focus();
				return;
			}
			
			if($("#reMemPass").val().trim()==""){
				//$("#memId").val().trim()
				alert("비밀번호를 입력해 주세요");
				$("#reMemPass").focus();
				return;
			}
			
			
		
			if($("#memTel").val().trim()==""){
				//$("#memId").val().trim()
				alert("핸드폰 번호를 입력해 주세요");
				$("#memTel").focus();
				return;
			}
			
			
			if(!/^[a-zA-Z0-9!@#$%^&*()?_~]{6,15}$/.test($("#reMemPass").val()))
			 { 
			  alert("비밀번호는 숫자, 영문, 특수문자 조합으로 6~15자리를 사용해야 합니다."); 
			  return false;
			 }
			
			var sst=$("#g-recaptcha-response").val();
				if(sst==''){
					alert("리캡챠를 먼저해주세요 ");
					return;
				}
			
			if(checkEmail==0){
				alert("이메일 인증을 해주세요");
				return;
			}
			
			if(checkId==0){
				alert("중복체크를 먼저 해주세요")
			}else{
				$("#frm").submit();	
			}
			
		});
		
		$("#checkId").on("click", function() {
			
			if($("#memId").val().trim()==""){
				//$("#memId").val().trim()
				alert("아이디를 입력해 주세요");
				$("#memId").focus();
				return;
			}
			
			var memId = $("#memId").val();
			$.ajax({
			type : "get",
			url : "${cp}/member/checkId",
			data : { memId: memId}, 
			success : function(data) {
				if(data.check=="OK"){
					console.log(data);
				alert("사용 가능한 아이디 입니다.");
                $("#memId").css("background-color", "#FFCECE");
                checkId=1;
				}else{
					alert("이미 존재하는 아이디 입니다.");
					$("#memId").css("background-color", "#FFFFFF");
					$("#memId").focus();
				}
//				alert(data.OK);
			},
			error : function(xhr, status, error) {
				console.log("에러!: " + error);
			},
			
		});
		
		});
		
		
		
		//이메일 인증보내기 클릭시
		$("#checkEmail").on("click", function() {
			if(checkInput > 0){
				return;
			}
			if($("#memMail").val().trim()==""){
				//$("#memId").val().trim()
				alert("메일을 입력해 주세요");
				$("#memMail").focus();
				return;
			}
			
			var email = $("#memMail").val();
			$.ajax({
			type : "get",
			url : "${cp}/member/sendMail",
			data : { email: email}, 
			success : function(data) {
				if(data.check==true){
					var citationStr = "<input type='text' id='citationVal' placeholder='인증번호를 입력해주세요~' /> "
					+"<input type='button' class='btn-style1' id='citation' value='인증' />"
					 $("#fileDiv").append(citationStr);
					checkInput++;
					
					$("#citation").on("click", function() {
						
						 if(data.joinCode==$("#citationVal").val()){
							
						alert("인증");
						checkEmail++;
						} 
					});
					
				}else{
					alert("이메일 전송이 실패하였습니다.");
				}
			},
			error : function(xhr, status, error) {
				console.log("에러!: " + error);
			},
			
		});
		});
	});
	var pwdCheck=0;
	function checkPwd() {
		var inputed = $(".memPass").val();
        var reinputed = $("#reMemPass").val();
		console.log(inputed);
		
	     if(reinputed=="" && (inputed != reinputed || inputed == reinputed)){
	            $("#reMemPass").css("background-color", "#FFCECE");
	        }
	        else if (inputed == reinputed) {
	            $("#reMemPass").css("background-color", "#B0F6AC");
	            pwdCheck = 1;
	        } else if (inputed != reinputed) {
	            pwdCheck = 0;
	            $("#reMemPass").css("background-color", "#FFCECE");
	            
	        }

	}
	
	
</script>
