<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/mypage.jsp" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<link rel="stylesheet" href="/resources/button.css">
<link rel="stylesheet" href="/resources/mywriting.css">

<sec:authentication property="principal" var="pinfo"/>

<div class="navi">
	<span class="main"><a href="/main">홈</a></span>
	<span class="step"><a href="/login/userinfo">MyPage</a></span>
	<span class="step"><a href="/board/mywriting?pageNum=1&amount=20">내가 쓴 글</a></span>
</div>

	<table>
		<thead>
			<tr>
				<th class="no">글번호</th>
				<th class="writer">작성자</th>
				<th class="subject">제목</th>
				<th class="date">작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="board" items="${list}">
				<tr>
					<td><c:out value="${board.bno}" /></td>
					<td>
						<sec:authorize access="!isAuthenticated()">
							<a class="notAuth_get" id="notAuth_get" href='/login/customLogin'>
								<c:out value="${board.title}"/> 
								<c:if test="${board.replycnt > 0 }">
									<b> [<c:out value="${board.replycnt }"/>]</b>
								</c:if>
							</a>
						</sec:authorize>
						<sec:authorize access="isAuthenticated()">
							<a class="move" href='<c:out value="${board.bno}"/>'>
								<c:out value="${board.title}"/> 
								<c:if test="${board.replycnt > 0 }">
									<b> [<c:out value="${board.replycnt }"/>]</b>
								</c:if>
							</a>
						</sec:authorize>
					</td>
					<td><c:out value="${board.writer}"></c:out></td>
					<td><fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd"/></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
<!-- page -->
<div class="pull-right">
	<ul class="pagination">
		<c:if test="${pageMaker.prev }">
			<li class="paginate_button previous">
				<a href="${pageMaker.startPage-1}">&lt;</a>
			</li>
		</c:if>
		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage }" step="1">
			<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : ''}">
				<a href="${num}">${num }</a>
			</li>
		</c:forEach>
		<c:if test="${pageMaker.next }">
			<li class="paginate_button">
				<a href="${pageMaker.endPage+1}">&gt;</a>
			</li>
		</c:if>
	</ul>
</div>
<form id="actionForm" action="/board/mywriting" method="get">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
</form>

<script type="text/javascript">
	$(function(){
		
		//----------------- 페이징 이벤트 코드-------------------
		var actionForm = $("#actionForm");
		
		$(".paginate_button a").click(function(e){
			// <a> 클릭 시 페이지 이동이 이루어지지 않게 하기 위해
			// 기존(디폴트) 이벤트 해제
			e.preventDefault();
			
			// $(this) 의 요소 중 'href'의 속성 값(value)을 input태그의 name속성 값이 pageNum인
			// 요소에 값으로 집어 넣는다.
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		
		
		//----------------- 조회 화면 이동 이벤트 코드-------------------
		$(".move").click(function(e){
			e.preventDefault();
			
			// <form> 에 추가
			var value = $(this).attr("href");
			
			actionForm.append("<input type='hidden' name='bno' value='" + value + "'>");
			actionForm.attr("action", "/board/get");
			actionForm.submit();
		});
	});
</script>



<%@ include file="../include/footer.jsp" %>
