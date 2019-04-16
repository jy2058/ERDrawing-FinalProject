<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

		<c:forEach items="${cmtList}" var="cmt">
			<tr class="cmtTr" border-right: 2px solid #fff;" data-cmtno="${cmt.cmtNo}" style="background-color: #f9f9f9;">
				<td style="text-align: center; border-right: 2px solid #fff; color:black;">${cmt.cmtNo}</td>
				<td style="text-align: center; border-right: 2px solid #fff; color:black;">${cmt.memId}</td>
				<td style="border-right:2px solid #fff; color:black;">&nbsp;${cmt.cmtContent}</td>
				<td style="text-align: center; border-right: 2px solid #fff; color:black;">( ${cmt.cnt} 건 )
					<button type="button" id="likeBtn" class="btnLike btn-default" data-cmtnum="${cmt.cmtNo}">좋아요</button> 
					
					<c:if test="${SESSION_MEMBERVO.memId == cmt.memId}">
					<button type="button" class="btnDel btn-default" data-cmtnum="${cmt.cmtNo}">삭제</button>
						<%--  <c:choose>
								<c:when test="${SESSION_MEMBERVO.memId ne null}">
									<a href="javascript: like_func();"><img src="">좋아요</a>
								</c:when>
							  </c:choose> --%>
					</c:if>
				</td>
			</tr>
		</c:forEach>
				
		======================seperator======================
		<c:choose>
			<c:when test="${paging.pageNo eq 1}">
				<li class="disabled"><a ria-label="Previous"> <span aria-hidden="true">&laquo;</span>
				</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="javascript:cmtPage(${paging.prevPageNo})" aria-label="Previous"> 
					<span aria-hidden="true">&laquo;</span>
				</a></li>
			</c:otherwise>
		</c:choose>
		<c:forEach begin="${paging.startPageNo}" end="${paging.endPageNo}" var="i">
			<c:set var="active" value="" />
			<!-- 초기화 과정 값이 계속 남기때문에 -->
			<c:if test="${i eq paging.pageNo}">
				<c:set var="active" value="active" />
				<!-- 현재 페이지일 때 활성화를 위해서 -->
			</c:if>
			<li class="${active}"><a href="javascript:cmtPage(${i})">${i}</a>
			</li>
		</c:forEach>
		
		<c:choose>
			<c:when test="${paging.finalPageNo eq paging.pageNo}">
				<li class="disabled">
					<a ria-label="Next"> 
						<span aria-hidden="true">&raquo;</span>
					</a>
				</li>
			</c:when>
			<c:otherwise>
		
				<li><a href="javascript:cmtPage(${paging.nextPageNo})" aria-label="Next">
					<span aria-hidden="true">&raquo;</span>
				</a></li>
			</c:otherwise>
		</c:choose>