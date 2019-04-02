<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<nav id="header" class="navbar navbar-inverse navbar-fixed-top">
	<div class="container">


		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#navbar" aria-expanded="false"
				aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>

			<ul class="left-menu">
				<li class="navbar-brand"><a href="/">ERDrawing</a></li>
				<li class="navbar-brand"><a href="/library">Library</a></li>
				<li class="navbar-brand communityHover"><a href="/">Community</a>
					<%@ include file="/WEB-INF/views/template/module/communityMenu.jsp"%>
				</li>
				<li class="navbar-brand"><a href="/er">ErdTest</a></li>
				<c:if test="${SESSION_MEMBERVO.memAuth == 'T' }">
					<li class="navbar-brand"><a href="${cp }/member/memberList">MemberList</a></li>
				</c:if>
			</ul>

		</div>

		<div id="navbar" class="collapse navbar-collapse">
			<ul class="nav navbar-nav">
				<!-- <li class="active"><a href="#">ERD생성</a></li> -->
				<li><a href="/test2">ERD생성</a></li>

				<c:choose>

					<c:when test="${SESSION_MEMBERVO == null }">
						<li><a href="${cp }/login">로그인</a></li>
						<li><a href="${cp }/join">회원가입</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="${cp }/mypage"><img alt="" src="${SESSION_MEMBERVO.memImg}" width="35" height="30"> </a></li>
						<li><a href="/message">메세지</a></li>
						<li><a id="logout" href="#" hidden="">로그아웃</a></li>
					</c:otherwise>
				</c:choose>

				<li><a href="">검색</a></li>

			</ul>
		</div>
		<!--/.nav-collapse -->

		<input type="hidden" id="memEmailDiv"
			value="${SESSION_MEMBERVO.memEmailDiv}">
	</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
	<script>
		var abc;
		$("#logout").click(function() {
		if ($("#memEmailDiv").val() == "google") {
						abc = window.open('https://accounts.google.com/logout',
								'ot', 'width=300,height=300,left=650,top=300');

						setTimeout(function() {
							abc.close();
							window.location.href = '/logout';
						}, 1500);
					}	//구글로그인한 경우

		else if ($("#memEmailDiv").val() == "kakao") {
						Kakao.init('8eded83f4085ba344e793801d05f3722');
					     Kakao.API.request({
					          url: '/v1/user/unlink',
					       //   /v1/api/talk/profile
					          success: function(res) {
						            alert("로그아웃");
						            location.href = '/logout';
						          },
					          fail: function(error) {
					            alert("로그인 실패");
					          }
					        });
					}

					else {
						$("#logout").attr("href", "/logout");
					}//기본 로그인한 경우
				});
	</script>
</nav>