<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../../favicon.ico">

   <!--  <title>Dashboard Template for Bootstrap</title> -->

    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <!-- Custom styles for this template -->
    <link href="${cp}/css/boxErd.css" rel="stylesheet">

	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="../SE2/js/HuskyEZCreator.js"></script>
	<script type="text/javascript">
var oEditors = []; // 개발되어 있는 소스에 맞추느라, 전역변수로 사용하였지만, 지역변수로 사용해도 전혀 무관 함.

$(document).ready(function() {
	// Editor Setting
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors, // 전역변수 명과 동일해야 함.
		elPlaceHolder : "smarteditor", // 에디터가 그려질 textarea ID 값과 동일 해야 함.
		sSkinURI : "../SE2/SmartEditor2Skin.html", // Editor HTML
		fCreator : "createSEditor2", // SE2BasicCreator.js 메소드명이니 변경 금지 X
		htParams : {
			// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseToolbar : true,
			// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,
			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true, 
		}
	});

	// 전송버튼 클릭이벤트
	$("#savebutton").click(function(){
		if($("#postTitle").val().trim() ==""){
			alert("글 제목을 입력해주세요");
			$("#postTitle").focus();
			return;
		}
		
		if(confirm("저장하시겠습니까?")) {
			// id가 smarteditor인 textarea에 에디터에서 대입
			oEditors.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []);
			
			// 이부분에 에디터 validation 검증
			if(validation()) {
				$("#frm").submit();
			}
		}
	})
});

// 필수값 Check
function validation(){
	var contents = $.trim(oEditors[0].getContents());
	if(contents === '<p>&nbsp;</p>' || contents === ''){ // 기본적으로 아무것도 입력하지 않아도 <p>&nbsp;</p> 값이 입력되어 있음. 
		alert("내용을 입력하세요.");
		oEditors.getById['smarteditor'].exec('FOCUS');
		return false;
	}

	return true;
}

function addFile(){
	if($("#fileUpload").siblings().size()>4){
		alert("5개 이상의 사진은 선택할 수 없습니다.");
		return;
	}
	if($("#fileUpload").siblings().size() == 0){
		$("#fileUpload").after("<input class='upload1' style='margin-left: 146px; width: 400px; margin-top:5px'  multiple='multiple' type='file' class='form-control' id='upload' name='upload'>");	
	}
	else{
		$("#fileUpload").siblings().last().after("<input class='upload1' style='margin-left: 146px; width: 400px; margin-top:5px'  multiple='multiple' type='file' class='form-control' id='upload' name='upload'>");
	}
	
}

function removeFile(){
	console.log("클릭");
	if($("#fileUpload").siblings().size()<=0){
		alert("더 이상 삭제할 수 있는 파일이 없습니다..");
		return;
	}
	$("#fileUpload").siblings().last().remove();
}

</script>
	
  </head>
			 <h1 class="page-header">게시글 작성 </h1>
				
			 <form id="frm" action="${cp}/post/postForm" method="post" class="form-horizontal" role="form"
			 	enctype="multipart/form-data"><!-- 디비값이 변경되면 post-->
			 
               <div class="form-group">
                  <label for="userNm" class="col-sm-1 control-label">제목</label>
                  <div class="col-sm-7">
                        <input type="text" class="form-control" id="postTitle" name="postTitle" placeholder="제목">
                  </div>
               </div>
				
				
               <div class="form-group">
                  <label for="userNm" class="col-sm-1 control-label">작성자</label>
                  <div class="col-sm-7">
                        <input type="text" class="form-control" id="userId" name="userId" value="${userVo.userId}" readonly="readonly">
                         <input type="hidden" class="form-control" id="boardNo" name="boardNo" value="${boardNo}">
                         <input type="hidden" class="form-control" id="post_Gn" name="post_Gn" value="${post_Gn}">
                         <input type="hidden" class="form-control" id="postNo" name="postNo" value="${postNo}">
                         <input type="hidden" class="form-control" id="flag" name="flag" value="T">
                  </div>
               </div>
				
               <div class="form-group">
                  <label for="userNm" class="col-sm-1 control-label">글 내용</label>
                  <div class="col-sm-11">
                     <textarea name="postContent" id="smarteditor" rows="10" cols="100" style="width:776px; height:412px;"></textarea> 
                  </div>
               </div>

 			<div class="form-group">
                  <div class="col-sm-offset-1 col-sm-11">
                     <button type="button" id="regBtn" class="btn btn-default" onclick="addFile()">파일추가</button>
                       <button type="button" id="regBtn" class="btn btn-default" onclick="removeFile()">파일삭제</button>
                  </div>
                                 
                <div class="form-group"  style="display: inline-block;">
                  <div class="col-sm-7" id= "fileUpload">
                 
                  </div>
               </div>
             
             
               </div>
               <div class="form-group">
                  <div class="col-sm-offset-1 col-sm-11">
                 	 <button type="button" id="savebutton" class="btn btn-default">글 작성</button>
                  </div>
               </div>
            </form>
