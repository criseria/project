<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/mypage.jsp" %>
<link rel="stylesheet" href="/resources/buylist.css">
<link rel="stylesheet" href="/resources/button.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>

<script type="text/javascript">
	function writeReview(f){
		var pno = f.pno.value;
		var pname = f.pname.value;
		window.open("/product/writeReview?pno="+pno+"&pname="+pname, "", "width=615, height=330, left=450, top=100,resizable=no");
		
		
	}
</script>
	<div class="navi">
		<span class="main"><a href="/main">홈</a></span>
		<span class="step"><a href="/login/userinfo">MyPage</a></span>
		<span class="step"><a href="/product/buyList">구매한 상품 목록</a></span>
	</div>
	
	<br><br>
	<div class="List-head">
		<table class="prodTitle">
			<thead>
				<tr>
					<th class="img">상품 이미지</th>
					<th class="title">상품명</th>
					<th class="price">가격</th>
					<th class="purchase-count">구매 수량</th>
					<th class="date">구매일</th>
				</tr>
			</thead>
		</table>
		<br/>
		<c:forEach var="buyList1" items="${buyList1}" varStatus="status">
		<form class="writeReview" method="get" action="/product/writeReview">
			<table class="prodTbl">
				<tr>
					<td class="img"><img src='/resources/image/<c:out value="${buyList1.image}"/>.jpg' style="width: 100px; height: 100px;"></td>
					<td class="title"><c:out value="${buyList1.pname}"></c:out></td>
					<td class="price"><fmt:formatNumber value='${buyList1.price}'/>원</td>
					<td class="purchase-count"><c:out value="${buyList2[status.index].amount}"></c:out></td>
					<td class="date"><c:out value="${buyList2[status.index].buyDate}"></c:out></td>
					<td class="button"><input class="review" type="button" onclick="writeReview(this.form)" value="리뷰"><td>
				</tr>
			</table>
			<input type="hidden" name="pno" class="pno" value="${buyList1.pno}"/>
			<input type="hidden" name="pname" class="pname" value="${buyList1.pname}"/>
		</form>		
		</c:forEach>
		<br><br><br>
	</div>
<%@ include file="../include/footer.jsp" %>