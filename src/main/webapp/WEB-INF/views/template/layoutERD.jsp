<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link href="/css/bootstrap_erd.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic+Coding" rel="stylesheet">
<link href="/css/erdDrawing.css" rel="stylesheet" type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script> 

<script src="https://unpkg.com/konva@3.2.0/konva.min.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    
<script src="/js/drawing/minimap.js"></script>
<script src="/js/drawing/attribute.js"></script>
<script src="/js/drawing/style.js"></script>
<script src="/js/drawing/realation.js"></script>
<script src="/js/drawing/sqlexport.js"></script>
<script src="/js/drawing/sqlimport.js"></script>
</head>

<body id='my_body'>

<tiles:insertAttribute name="content"/>
<tiles:insertAttribute name="module"/>

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="/js/drawing/drawingAjax.js"></script>
<script src="/js/drawing/chat.js"></script>

<script>
$(document).ready(function(){
	
	//본인이 아니면 버튼 이벤트 없애기
	if(erdCreator != S_userId && erdScope != 'team'){

		 $('#button3').off('click');		//엔티티추가
		 $('#tmp_btn_11').off('click');
		 $('#tmp_btn_12').off('click');
		 $('#tmp_btn_13').off('click');
		 $('#tmp_btn_14').off('click');
		 $('#tmp_btn_15').off('click');
		 $('#one2many').off('click');
		 $('#one2one').off('click');
		 $('#button30').off('click');	//도메인
		 $('#button31').off('click');	//가져오기
		 
		 $('#button40').off('click');	
		 $('#button41').off('click');	
		 
		 $('#erdModify').off('click');

		 $('#erdModify, #button41, #button40, #button30, #button31').css('color','#999999');
		 $('#button3, #tmp_btn_11, #tmp_btn_12, #tmp_btn_13, #tmp_btn_14, #tmp_btn_15, #one2many, #one2one').css('opacity','0.5');
		 $('#erdModify, #button41, #button40, #button30, #button31').css('cursor','not-allowed');
		 $('#button3, #tmp_btn_11, #tmp_btn_12, #tmp_btn_13, #tmp_btn_14, #tmp_btn_15, #one2many, #one2one').css('cursor','not-allowed');
		 
		 stage.off('click');
		 stage.off('.dragSetup');
		 stage.find('.entity').draggable(false);
	}

});


</script>

</body>
</html>