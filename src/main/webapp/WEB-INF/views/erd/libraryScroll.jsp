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
	<input name="erd-search-txt" class="erd-search-txt" id="searchTxt" type="text" data-tagcontent="${tagContent }"/>
	<button class="erd-search-btn" id="searchBtn">검색</button>
</div>

<div class="best-erd-list">
	<div class="inner-container">
		<div class="col-sm-12">
			<ul class="erd-box-list">
				<%-- <c:forEach var="erdList" varStatus="status" items="${allErdListPaging }">
					<c:if test="${erdList.erdScope eq 'public' }">
						<li class="erd-box-item "><a class="preview-box">
								<div class="bg-box">
									<div class="bg-img">&nbsp;Image</div>
									<div class="table-bg-text">
										<div class="bg-text shinys">&nbsp;${erdList.erdTitle }</div>
									</div>
								</div>
						</a>
							<div class="description-item">
								<div style="float: left;">${erdList.erdTitle }</div>
								<!-- erd public / private에 따라 자물쇠 이미지 변경 -->
								<div style="float: right;">${erdList.erdScope }</div>
								<ul class="tagList" style="clear: both;">
									<c:forEach var="entry" items="${erdTagListMap }">
										<c:if test="${entry.key eq myErdList.erdNo}">
											<c:set var="value" value="${entry.value }" />
											<c:forEach var="tagVo" items="${value}">
												<li>${tagVo.tagContent }</li>
											</c:forEach>
										</c:if>
									</c:forEach>
								</ul>
							</div></li>
					</c:if>
				</c:forEach> --%>
			</ul>
		</div>
	</div>
</div>

<script>
var page=1;
var stat = true; 	// 페이징 사이즈 보다 작을 때 스크롤 그만 되게
$(document).ready(function(){
	page = 0;
	
	var tagContent = $("#searchTxt").data("tagcontent");
	if(tagContent != ""){
		$("#searchBtn").val(tagContent);
	}else{
		showErd();
	}
});


//$(function(){
	var content_padding_b = parseInt($("#contents .container").css('padding-bottom'));
	var footer = $("#footer").height();
	
    $(window).scroll(function(){
		var window = $(this);
		var scrollTop = $(window).scrollTop();
		var windowHeight = $(window).height();
		var documentHeight = $(document).height();
		var currentScroll = scrollTop + windowHeight + footer + content_padding_b + 30;
		
 		console.log("documentHeight:" + documentHeight + " | scrollTop:" + currentScroll + " | windowHeight: " + windowHeight );
		
		if( documentHeight < currentScroll && stat == true){
			showErd();
		}
    });



	function showErd(){
		$.ajax({
			url : "${cp}/erd/libErdAjax",
			data : {
				page : ++page
			},
			success : function(data) {
				var erdList = data.allErdListPaging;
				var erdTagMap = data.erdTagListMap;
				var erdTagMapKey = Object.keys(erdTagMap);	// 맵의 키를 따로 저장
				var erdTagMapNew = new Map(); //erdTagMapKey를 맵타입으로 바꾸기 위해서. 
				//스크립트에서 맵 안에 있는 맵을 배열로 인식.
				
				if(erdList.length < 6){
					stat = false;
				}
				
				// 맵 형식으로 다시 만들어 줌
				for(var z = 0; z < erdTagMapKey.length; z++){
					erdTagMapNew.set(erdTagMapKey[z], erdTagMap[erdTagMapKey[z]]);
				}
				
				
				var html ="";
				for(var i = 0; i < erdList.length; i++){
					if(erdList[i].erdScope == 'public'){
						html += '<li class="erd-box-item">';
						html += '	<a class="preview-box">';
						html += '		<div class="bg-box">';
						html += '			<div class="bg-img">&nbsp;Image</div>';
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
							  console.log(key);
							  console.log(value);
							 if(key == erdList[i].erdNo){
								 for(var j = 0; j < value.length; j++){
									 html += '<li>' + value[j].tagContent +'</li>';
								 }
							 }
						 }  
						html += '		</ul>';
						html += '	</div>';
						html += '</li>';
					}
				}
				$(".erd-box-list").append(html);
			}
		});
	};
</script>