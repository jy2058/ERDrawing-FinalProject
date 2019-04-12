<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="/css/boxErd.css">


<style>
.erd-search {
	display: block;
	padding: 20px 0 20px;
}

.erd-search-txt {
	display: inline-block;
	margin-right: 10px;
	height: 30px;
}

.erd-search-btn {
	display: inline-block;
	padding: 5px 10px;
	background: #fff;
	color: #000;
}
</style>

<div class="erd-search">
	<input name="erd-search-txt" class="erd-search-txt" id="searchTxt" type="text" data-tagcontent="${tagContent }" value=""/>
	<button class="erd-search-btn" id="searchBtn">검색</button>
</div>

<div class="best-erd-list">
	<div class="inner-container">
		<div class="col-sm-12">
			<ul class="erd-box-list">
				<!-------------------------- erd list --------------------->
			</ul>
		</div>
	</div>
</div>

<script>
var page=1;
var stat = true; 	// 페이징 사이즈 보다 작을 때 스크롤 그만 되게
var tagContent;
var searchFlag = false;	// 검색버튼을 눌렀는지 플래그
$(document).ready(function(){
	page = 0;

	tagContent = $("#searchTxt").data("tagcontent");
	if(tagContent != ""){
		$("#searchTxt").val(tagContent);
	}
	showErd();
	
	$("#searchBtn").on("click", function(){
		tagContent = $("#searchTxt").val();
		searchFlag = true;
		page = 0;
		showErd();
	});
	
	
	var content_padding_b = parseInt($("#contents .container").css('padding-bottom'));
	var footer = $("#footer").height();
	var s_flag = true;
	
    $(window).scroll(function(){
    		
   		// 스크롤이 여러번 실행 되지 않게 스위칭
   		if(s_flag){
   			
   			s_flag != s_flag;
   			
   			var window = $(this);
   			var scrollTop = $(window).scrollTop();
   			var windowHeight = $(window).height();
   			var documentHeight = $(document).height();
   			var currentScroll = scrollTop + windowHeight + footer + content_padding_b;
   			
   	 		console.log("documentHeight:" + documentHeight + " | scrollTop:" + currentScroll + " | windowHeight: " + windowHeight );
   			
   			if( documentHeight < currentScroll && stat == true){
   				showErd();
   			}
   			
   			setTimeout(function(){
   				s_flag != s_flag;
   			}, 1000);
   		}
    });
});


	function showErd(){
		$.ajax({
			url : "${cp}/erd/libErdAjax",
			data : {
				page : ++page,
				tagContent : tagContent
			},
 			async: false,
			success : function(data) {
				
				var erdList = data.allErdListPaging;
				var erdTagMap = data.erdTagListMap;
				var erdTagMapKey = Object.keys(erdTagMap);	// 맵의 키를 따로 저장
				var erdTagMapNew = new Map(); //erdTagMapKey를 맵타입으로 바꾸기 위해서. 
				//스크립트에서 맵 안에 있는 맵을 배열로 인식.
				
				if(erdList.length < 12){
					stat = false;
				}
				
				// 맵 형식으로 다시 만들어 줌
				for(var z = 0; z < erdTagMapKey.length; z++){
					erdTagMapNew.set(erdTagMapKey[z], erdTagMap[erdTagMapKey[z]]);
				}
				
				var html ="";
				for(var i = 0; i < erdList.length; i++){
					html += '<li class="erd-box-item">';
					html += '	<a class="preview-box">';
					html += '		<div class="bg-box">';
					html += '			<img src="${cp }/erd/erdImg?erdNo=' + erdList[i].erdNo + '">';
					html += '			<div class="table-bg-text">';
					html += '				<div class="bg-text shinys">&nbsp;' + erdList[i].erdTitle + '</div>';
					html += '			</div>';
					html += '		</div>';
					html += '	</a>';
					html += '	<div class="description-item">';
					html += '		<div style="float: left;">' + erdList[i].erdTitle + '</div>';
					html += '		<div style="float: right;">' + erdList[i].erdScope + '</div>';
					html += '		<ul class="tagList" style="clear: both;">';
					
					  for(var [key, value] of erdTagMapNew){
						 if(key == erdList[i].erdNo){
							 for(var j = 0; j < value.length; j++){
								 html += '<a href="${cp}/library?tagContent=' + value[j].tagContent + '" title="" class="tagSearch">' + value[j].tagContent + '</a>';
							 }
						 }
					 }  
					html += '		</ul>';
					html += '	</div>';
					html += '</li>';
				}
				if(searchFlag){
					$(".erd-box-list").html(html);
				}
				$(".erd-box-list").append(html);
				
			}
		});
	};
	
	
</script>