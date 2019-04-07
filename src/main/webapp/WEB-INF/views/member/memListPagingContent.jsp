<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<link rel="stylesheet" href="/css/boxErd.css">
<link rel="stylesheet" href="/css/member/memList.css">


	<div class="youtube-title">
		<h2>회원정보 리스트</h2>
	</div>
<!-- 	<br /> -->
	<br />

   <!-- ------------------------회원정보 모달창-------------------- -->
   <form id="modalFrm" action="${cp }/member/memModalModify" method="post">
   <div class="modal modal-center fade" id="modalEvn" tabindex="1" role="dialog" aria-labelledby="my80sizeCenterModalLabel" >
      <div class="modal-dialog modal-80size modal-center" role="document" >
         <div class="modal-content modal-80size">
            <div class="modal-header">
            <label>| 회원정보 수정</label>
               <button type="button" class="close" data-dismiss="modal"aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body">
                           
               <div class="form-group">
                  <label class="modalLabel" >회원 이미지</label> 
                  
				  <img alt="" src="" name="memImg" id="memImg" width="100px" height="100px">
               </div>
            
            
               <div class="form-group">
               <!-- 여기부터 로직작성 -->
                  <label class="modalLabel">회원 이름</label> 
                  <input type="text" id="memNm" name="memNm"> 
                   
                  <div id="dupleCode"></div>
               </div>
               
                <div class="form-group">
                  <label class="modalLabel">회원 아이디</label> 
                  <input type="text" name="memId" id="memId" >    
               </div>   
               
               <div class="form-group">
                  <label class="modalLabel" >회원 비밀번호</label> 
                  <input  type="password" name="inputMemPass" id="inputMemPass" > 
                  <input  type="hidden" name="memPass" id="memPass" > 
                 <!--  <input type="button" data-toggle="modal" data-target="#my80sizeModal2" value="검색" > -->
               </div>
               
                <div class="form-group">
                  <label class="modalLabel">회원 이메일</label> 
                  <input type="text" name="memMail" id="memMail" >    
               </div> 

               
               <div class="form-group">
                  <label class="modalLabel">회원 소개</label> 
                  <input type="text" name="memIntro" id="memIntro" >    
               </div>
               
                <div class="form-group">
                  <label class="modalLabel">회원 전화번호</label> 
                  <input type="text" name="memTel" id="memTel" >    
               </div>
               
                <div class="form-group">
                  <label class="modalLabel">회원 가입날짜</label> 
                  <input type="text" name="memInDts" id="memInDts" >    
               </div>
               
               <div class="form-group">
                  <label class="modalLabel">블랙리스트 여부</label> 
				  <input type="checkbox"  name="chMemBlackFlag" id="chMemBlackFlag"  data-toggle="toggle"  data-on="O" data-off="X"/>
				  <input type="hidden"  name="memBlackFlag" id="memBlackFlag"  />
				  
                  <label class="modalLabel" style="width: 30px"> </label> 
                  
                  <label class="modalLabel" style="width: 30px">탈퇴 여부</label> 
                  <input type="checkbox" name="chMemCancelFlag" id=""chMemCancelFlag"" data-toggle="toggle"  data-on="O" data-off="X"/>
                  <input type="hidden" name="memCancelFlag" id="memCancelFlag"/>
		  
               </div>
               
                <div class="form-group">
                  <label class="modalLabel">이용권 기한</label> 
                  <input type="text" name="memPeriods" id="memPeriods" >    
               </div>
               
               </div>   
               <div class="modal-footer">
                  <button type="button" id="insertBtn" class="btn btn-default" data-dismiss="modal">수정</button>
                  <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
               </div>
            </div>
         </div>
      </div>
 </form>     

<!----------------------------- 회원정보 테이블 -------------------------->
<form id="frm" action="${cp }/member/memberDel">
	<div id="guswl">
		<table>
			<thead>
				<tr>
					<th>#</th>
					<th>Name</th>
					<th>Id</th>
					<th>Date Created</th>
					<th>Auth</th>

					<th>Status</th>
					<th>Action</th>
					<th></th>
				</tr>
			</thead>

			<tbody id="memListTbody">
			</tbody>
		</table>
		
		<nav id="divNav" style="text-align: center;">
			<ul class="pagination" id="pagination">
			</ul>
		</nav>
		
	</div>
</form>




<script type="text/javascript">
	
	var memId = "";
	
	$(document).ready(function() {
		getMemListPageListHtml(1);

		$("#memListTbody").on('click', ".d1 ul li", function() {
			$(this).find("ul").stop().fadeToggle(350);
		});

		//이미지 x표시 클릭시 사용자 삭제
		$("#memListTbody").on("click", ".delImg", function() {
			if (confirm("정말 삭제하시겠습니까??") == true) {
				memId = $(this).data("memid");
				alert(memId + "dd");
				getMemListPageListHtmlDel(1, memId);
			} else { //취소
				return false;
			}
		});
		
		//회원정보수정시 
		$("#insertBtn").on("click", function() {
			if (confirm("수정 하시겠습니까??") == true) {
				
				if($("#chMemBlackFlag").is(':checked')){
					$("#memBlackFlag").val("T");
				}else{
					$("#memBlackFlag").val("F");
				}
				console.log($("#memBlackFlag").val());
					
				if($("#chMemCancelFlag").is(':checked')){
					$("#memCancelFlag").val("T");					
				}else{
					$("#memCancelFlag").val("F");
				}
				console.log($("#memCancelFlag").val());
					
				$("#modalFrm").submit();
			} else { //취소
				return false;
			}
		});
		
		//회원정보클릭시
		$("#memListTbody").on('click', "#liMemModify", function() {
			memId = $(this).data("memid");
			getMemberModifyModal(memId);
		});
		
		$('#modalEvn').on('show.bs.modal', function (event) {
			var button = $(event.relatedTarget);
			var deleteUrl = button.data('title');
			var modal = $(this);
			
			alert(memId);
		
			});
	});

	//삭제후 Ajax처리
	function getMemListPageListHtmlDel(page, memId) {
		$.ajax({
				url : "${cp}/member/memberDel",
				data : {
					memId : memId,
					page : page
				},
				success : function(data) {
					var htmlArr = data
							.split("======================seperator==========================");
					$("#memListTbody").html(htmlArr[0]);
					$("#pagination").html(htmlArr[1]);
				}
			});
		}

	//전체 테이블 Ajax처리
	function getMemListPageListHtml(page) {
		$.ajax({
				url : "${cp}/member/memberAjaxList",
				data : {
					page : page
				},
				success : function(data) {
					var htmlArr = data
							.split("======================seperator==========================");
					$("#memListTbody").html(htmlArr[0]);
					$("#pagination").html(htmlArr[1]);
				}
			});
		}
	
	function getMemberModifyModal(memId) {
		$.ajax({
				url : "${cp}/member/memModifyModal",
				data : {
					memId : memId
				},
				success : function(data) {
					console.log(data.memVo);
					//모달창에  해당 회원의 값 넣어주기
					modalResult(data);
					
				}
			});
		}
	

	function modalResult(data) {

		var src = data.memVo.memImg;
		var black = data.memVo.memBlackFlag;
		var cancel = data.memVo.memCancelFlag;
		
		//이미지
		if (src == "" || src == null) {
			$("#memImg").attr("src", "../image/noImg.png");
		} else {
			$("#memImg").attr("src", src);
		}
		
		//구글 카카오는 비밀번호 변경불가 
		if (data.memVo.memEmailDiv == "basic") {
			$("#inputMemPass").val(data.memVo.memPass);
			$("#memPass").val($("#inputMemPass").val());
		} else {
			$("#memPass").val(data.memVo.memPass);
			$("#inputMemPass").remove();
			$("#inputMemPass").remove();
		}
		
		if(black=='T'){
			$("input[name=chMemBlackFlag]").prop("checked", true).change();
		}else{
			$("input[name=chMemBlackFlag]").prop("checked", false).change();
		}
		
		if(cancel=='T'){
			$("input[name=chMemCancelFlag]").prop("checked", true).change();
		}else{
			$("input[name=chMemCancelFlag]").prop("checked", false).change();
		}
		
		$("#memId").val(data.memVo.memId);
		$("#memNm").val(data.memVo.memNm);
		$("#memIntro").val(data.memVo.memIntro);
		$("#memImg").val(data.memVo.memImg);
		$("#memInDts").val(data.inDate);

		$("#memTel").val(data.memVo.memTel);
		$("#memMail").val(data.memVo.memMail);
		$("#memPeriods").val(data.memVo.memPeriod);

	}
</script>

