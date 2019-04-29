<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	select{
		color: black;
	}
</style>   

		<h1 class="erd-add h1">ERD 설정</h1>
		<form action="${cp }/erd/erdModify" id="erdModifyFrm" method="post" enctype="multipart/form-data">
			<div class="input-box">
				<label>제목</label>
				<input type="text" id="title" name="erdTitle" placeholder="제목">
			</div>
			<div class="input-box">
				<label>태그</label>
				<input type="text" placeholder="태그" name="tag" id="tag">
			</div>
			<div class="input-box">
				<label>공유</label>
				<div>
					<div>
						<input type="radio" name="erdScope" value="public">
						<label>공개</label>
					</div>
					<div>
						<input type="radio" name="erdScope" value="private">
						<label>비공개</label>
					</div>
					<div>
						<input type="radio" name="erdScope" value="team">
						<label>팀</label>
					</div>
				</div>
			</div>
			
			<!-- 팀 라디오 버튼 선택 시 나타나야 함 -->
			<div class="input-box" id="selTeam">
				<label>팀</label>
				<select name="teamNo">
					<option value="0">팀 선택</option>
					<c:forEach var="teamInfoList" items="${teamInfoList}">
						<option value="${teamInfoList.teamNo }">${teamInfoList.teamNm }</option>
					</c:forEach>
				</select>
			</div>
			<div class="input-box">
				<label>썸네일 이미지</label>
				<img alt="" src="" id="erdImg" width="200px"> 
				<input type="file" name="profileImg" onchange="loadImg(this)" id="profileImg" value="" style="width: 300px">
				<input type="button" id="snapshotBtn"  value="스냅샷 찍기"> 
			</div>
			<input type="hidden" id="snapshot" name="snapshot" value="">
			<input type="hidden" id="erdNo" name="erdNo" value="">
			<input type="hidden" id="selTeamNo" name="selTeamNo" value="">
		</form>
		<div class="cancle-btn99 btn-style1">취소</div>
		<div class="submit-btn99 btn-style1" id="erdSave">저장</div>
		
<script>
	var clickTeam = false;
	
	$("#selTeam").hide();
	
	$("#erdSave").on("click", function(){
		var selTeam = $("select[name=teamNo]").val();
		if(selTeam == 0 && clickTeam == true){
			alert("팀을 선택해 주세요.");
			return;
		}else
			$("#erdModifyFrm").submit();
	});
	
	
	$('input[type=radio][name=erdScope]').change(function() {
		if (this.value == 'team') {
	    	$("#selTeam").show();
	    	clickTeam = true;
	    }else{
	    	$("#selTeam").hide();
	    	clickTeam = false;
	    }
	});
                   	
	// 이미지 미리보기
	function loadImg(value){
		if(value.files && value.files[0]){
			var reader = new FileReader();
			reader.onload = function(e){
				$("#erdImg").attr('src', e.target.result);
			}
			reader.readAsDataURL(value.files[0]);
		}
	}
</script>
		
