<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav id="header" class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">


        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          
          <ul class="navbar-brand">
          	<li><a href="/">ERDrawing</a></li>
          	<li><a href="/library">Library</a></li>
          	<li><a href="/">Community</a>
          		<%@ include file="/WEB-INF/views/template/module/communityMenu.jsp"%>
          	</li>
         
          </ul>

        </div>


        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <!-- <li class="active"><a href="#">ERD생성</a></li> -->
            <li><a href="/test2">ERD생성</a></li>
            <li><a href="/login">로그인</a></li>
            <li><a href="/join">회원가입</a></li>
            <li><a href="/mypage">마이페이지</a></li>
          </ul>
        </div><!--/.nav-collapse -->


      </div>
</nav>
