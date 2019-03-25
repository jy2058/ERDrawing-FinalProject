<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<div class="col-sm-3 col-md-2 sidebar">
	<ul class="nav nav-sidebar">
		<li><a href="${cp}/post/postList?boardNo=1">공지사항</a></li>
	</ul>
	
	<ul class="nav nav-sidebar">
		<li><a href="${cp}/post/postList?boardNo=2">자유게시판</a></li>
	</ul>
	
	<ul class="nav nav-sidebar">
		<li><a href="${cp}/post/postList?boardNo=3">질문게시판</a></li>
	</ul>
</div>
