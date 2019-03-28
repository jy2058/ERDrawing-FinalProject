<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


		<h1 class="erd-add h1">Create team</h1>
		<form action="/team/teamCreate" id="teamCreateFrm" method="post" enctype="multipart/form-data">
			<div class="input-box">
				<label>팀이름</label>
				<input type="text" id="title" name="teamNm" placeholder="팀이름">
			</div>
			<div class="input-box">
				<label>팀회원</label>
				<input type="text" id="autocomplete" placeholder="팀회원">
			</div>

			<div>
				<ul id="ul">
				</ul>
			</div>
			
			<input type="hidden" name="teamMember" id="teamMember" value="">

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
		<div class="cancle-btn99 btn-style1">취소</div>
		<div class="btn-style1" id="teamCreate">만들기</div>
		
<script>
$( "#autocomplete" ).autocomplete({
    source : function( request, response ) {
         $.ajax({
                type: 'get',
                url: "/team/auto",
//                request.term = $("#autocomplete").val()
                data: { value : request.term },
                success: function(data) {
                	console.log("data:"+data.array);
                    //서버에서 json 데이터 response 후 목록에 뿌려주기 위함(view 전에 실행)
                response(
                        $.map(data.array, function(item) {
                        	console.log("item :"+item);
                            return {
                                //label: item.img,
                                value: item.id,
                                data: item.img
                            }
                        })
                    ); 
                }
           });
        },
    //조회를 위한 최소글자수
    minLength: 2,
    autoFocus: true,
    select: function( event, ui ) {
        // 만약 검색리스트에서 선택하였을때 선택한 데이터에 의한 이벤트발생
        console.log("ui.label : " + ui.item.label + " ui.value : " + ui.item.value);
        
        var html = '';
        html += '<li class="teamMem">';
        html += '	<div><img src="'+ ui.item.data + '"></div>';
        html += '	<div>' + ui.item.value + '</div>';
        html += '	<input id="delBtn" type="button" value="삭제">';
        html += '</li>';

        $("#ul").append(html); 
        $("#autocomplete").val('');
        
        $("#teamMember").val(ui.item.value);
        
        //var searchId = $("input[name=searchId]").eq(1).val();
        return false;	// text clear
        
        }
});



//추가된 회원 삭제
$(document).on("click","#delBtn", function(e){
	$(e.target).parent('li').remove();	
});


$("#teamCreate").on("click", function(){
	$("#teamCreateFrm").submit();
});


</script>
<!-- css와 script는 moduleControl에서 작성 -->
