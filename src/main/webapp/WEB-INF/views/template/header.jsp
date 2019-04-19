<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
				<li class="navbar-brand"><a href="/erdDrawing?erdNo=1098">ErdTest</a></li>
				<li class="navbar-brand"><a href="/ticket/ticketList">Ticket</a></li>
				
				<c:if test="${SESSION_MEMBERVO.memAuth == 'T' }">
				<li class="navbar-brand communityHover"><a href="/">Admin</a>
					<%@ include file="/WEB-INF/views/template/module/adminMenu.jsp"%>
					<%-- <li class="navbar-brand"><a href="${cp }/member/memberList">MemberList</a></li>
					<li class="navbar-brand"><a href="${cp }/member/memberList">TicketChart</a></li> --%>
					</li>
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
						<li><a href="${cp }/mypage">
					 	<c:choose>
									<c:when test="${SESSION_MEMBERVO.memEmailDiv =='basic'}">
										<img alt=""
											src="${cp }/member/memberImg?memId=${SESSION_MEMBERVO.memId }"
											width="35" height="30">
									</c:when>
									<c:otherwise>

										<c:choose>
											<c:when
												test="${ fn:indexOf(SESSION_MEMBERVO.memImg,'http') > -1}">
												<img alt="" src="${SESSION_MEMBERVO.memImg }" width="35"
													height="30">

											</c:when>
											<c:otherwise>

												<img alt=""
													src="${cp }/member/memberImg?memId=${SESSION_MEMBERVO.memId }"
													width="35" height="30">

											</c:otherwise>
										</c:choose>

									</c:otherwise>
								</c:choose>
						</a></li>
						<%-- 						<li><a href="${cp }/message/messageView">메세지</a></li> --%>
						<li><a id="message">메세지</a></li>
						<li><a id="logout" href="#" hidden="">로그아웃</a></li>
					</c:otherwise>
				</c:choose>

				<li><a id="searchModal" data-toggle="modal" data-target="#modalEvnTest">검색</a></li>
			</ul>
		</div>	
		<!--/.nav-collapse -->
		
		<div id="modals">
			<%@ include file="/WEB-INF/views/erd/search.jsp"%>
		</div>

		<input type="hidden" id="memEmailDiv"
			value="${SESSION_MEMBERVO.memEmailDiv}">

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
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
		
		
		/* $(document).ready(function(){
			
			$("#sendBtn").click(function() {
                sendMessage();
                $('#message').val('')

       		 });
			
			// 웹소켓
			// 웹소켓을 지정한 url로 연결한다.
	        let sock = new SockJS("<c:url value="/echo"/>");
	        sock.onmessage = onMessage;
	        sock.onclose = onClose;
	
	        // 메시지 전송
	        function sendMessage() {
	               sock.send($("#test").val());
	        }
	        // 서버로부터 메시지를 받았을 때
	        function onMessage(msg) {
	               var data = msg.data;
	               $("#data").append(data + "<br/>");
	        }
	
	        // 서버와 연결을 끊었을 때
	        function onClose(evt) {
	               $("#data").append("연결 끊김"); 
	        }
		});	 */
		
			
		// 검색모달용 ajax
		

// 		 		$.ajax({
// 					type : "get",
// 					url : "/pageViewAjax",
// 					data: { value :"searchModal" },
// 					success : function(data){
// 						$("#modals").html(data);
// 					}
// 				});

		
 
	</script>
</nav>