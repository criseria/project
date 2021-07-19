<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/mypage.jsp" %>
<link rel="stylesheet" href="/resources/tourPickList.css">
<sec:authentication property="principal" var="pinfo"/>

<h1>여행지 찜 목록</h1>
<table>
	<tr class="menu">
		<th class="img">여행지 이미지</th>
		<th class="title">여행지</th>
		<th class="content">여행지 소개</th>
		<th class="name">지역</th>
	</tr>
	<c:forEach items="${list}" var="tourInfo">
		<tr style="text-align: center;">
			<td class="img"><img src='/resources/image/<c:out value="${tourInfo.tou_image}"/>' style="width: 100px; height: 100px;"></td>
			<td class='move' onclick="location.href='/tourInfo/detail?pageNum=1&amount=9&userid=<c:out value="${pinfo.username}"/>&tou_no=<c:out value="${tourInfo.tou_no}" />'">
			<c:out value="${tourInfo.tou_name}" />
			</td>
			<td class="content"><c:out value="${tourInfo.tou_title}" /></td>
			<td class="name"><c:out value="${tourInfo.loc_name}" /></td>
		</tr>
	</c:forEach>
</table>

<form action="/tourInfo/pickList" method="get" id="actionForm">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	<input type="hidden" name="loc_no" value="<c:out value="${pageMaker.cri.loc_no }"/>" />
	<input type="hidden" name="userid" value="<c:out value="${pinfo.username}"/>" />
</form>

<div class="pull-right">
	<ul class="pagination">
		<c:if test="${pageMaker.prev }">
			<li class="paginate_button previous"><a
				href="${pageMaker.startPage-1}">&lt;</a></li>
		</c:if>
		<c:forEach var="num" begin="${pageMaker.startPage}"
			end="${pageMaker.endPage }" step="1">
			<li
				class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : ''}">
				<a href="${num}">${num }</a>
			</li>
		</c:forEach>
		<c:if test="${pageMaker.next }">
			<li class="paginate_button"><a href="${pageMaker.endPage+1}">&gt;</a>
			</li>
		</c:if>
	</ul>
</div>



<%@ include file="../include/footer.jsp" %>