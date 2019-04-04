<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="/css/boxErd.css">
<link rel="stylesheet" href="/css/member/memList.css">




	<div class="youtube-title">
		<h2>회원정보 리스트</h2>
	</div>
	<br />
	<br />

   <!-- 80%size Modal at Center -->
   <div class="modal modal-center fade" id="modalEvn" tabindex="1" role="dialog" aria-labelledby="my80sizeCenterModalLabel" >
      <div class="modal-dialog modal-80size modal-center" role="document" >
         <div class="modal-content modal-80size">
            <div class="modal-header">
            <label>| 부서등록</label>
               <button type="button" class="close" data-dismiss="modal"aria-label="Close">
                  <span aria-hidden="true">&times;</span>
               </button>
            </div>
            
            <div class="modal-body">
               <div class="form-group">
               <!-- 여기부터 로직작성 -->
                  <label>부서코드(*)</label> 
                  <input type="text" id="deptCode" placeholder="코드를 입력하세요"> 
                  <input type="button" value="중복체크" id="duplCheckbtn" name="duplCheckbtn"/> 
                  <div id="dupleCode"></div>
               </div>
                  <div class="form-group">
                  <label>부서명(*) &nbsp;&nbsp;&nbsp;</label> 
                  <input style="width: 180px;" type="text" name="deptName" id="deptName" placeholder="부서명을 입력하세요"> 
                  
               </div>   
               <div class="form-group">
                  <label>회사 코드 &nbsp;</label> 
                  <input style="width: 200px;" type="text" name="companyCode" id="companyCode" placeholder="회사코드를 입력하세요"> 
                  <input type="button" data-toggle="modal" data-target="#my80sizeModal2" value="검색" >
               </div>
               
               </div>   
               <div class="modal-footer">
                  <button type="button" id="insertBtn" class="btn btn-default" data-dismiss="modal">등록</button>
                  <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
               </div>
            </div>
         </div>
      </div>
      
      

   <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalEvn">등록</button>

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
		getPostPageListHtml(1);

		$("#memListTbody").on('click', ".d1 ul li", function() {
			$(this).find("ul").stop().fadeToggle(350);
		});

		//이미지 x표시 클릭시 사용자 삭제
		$("#memListTbody").on("click", ".delImg", function() {
			if (confirm("정말 삭제하시겠습니까??") == true) {
				memId = $(this).data("memid");
				alert(memId + "dd");
				getPostPageListHtmlDel(1, memId);
			} else { //취소
				return false;
			}
		});
		
		//회원정보클릭시
		$("#memListTbody").on('click', "liMemInfo", function() {
			alert($(this).data("memid"));
		});
		
		$('#modalEvn').on('show.bs.modal', function (event) {
			var button = $(event.relatedTarget);
			var deleteUrl = button.data('title');
			var modal = $(this);
		$("#deptCode").val("테스트중");
			alert("fdf");
		
			});
	});

	//삭제후 Ajax처리
	function getPostPageListHtmlDel(page, memId) {
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
	function getPostPageListHtml(page) {
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
</script>


