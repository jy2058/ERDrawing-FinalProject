<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav id="header" class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">


        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          
          <ul class="left-menu">
          	<li class="navbar-brand"><a href="/">ERDrawing</a></li>
          	<li class="navbar-brand"><a href="/library">Library</a></li>
          	<li class="navbar-brand communityHover"><a href="/">Community</a>
          		<%@ include file="/WEB-INF/views/template/module/communityMenu.jsp"%>
          	</li>
         
          </ul>

        </div>
 
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <!-- <li class="active"><a href="#">ERD생성</a></li> -->
            <li><a href="/test2">ERD생성</a></li>
          
            <c:choose>
            
            	<c:when test="${SESSION_MEMBERVO == null }">
            		<li><a href="/login">로그인</a></li>
            		<li><a href="/join">회원가입</a></li>
            	</c:when>
            	<c:otherwise>
            		<li><a href="/mypage">마이페이지-Img</a></li>
            		<li><a href="/message">메세지</a></li>
            		<li><a href="/logout">로그아웃</a></li>
            	</c:otherwise>
            
            </c:choose>
            
           <li><a href="">검색</a></li>
            
          </ul>
        </div><!--/.nav-collapse -->


      </div>
</nav>
