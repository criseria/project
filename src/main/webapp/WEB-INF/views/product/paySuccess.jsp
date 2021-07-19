<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="/resources/button.css">
<link rel="stylesheet" href="/resources/paySuccess.css">


<script type="text/javascript">
	onload = function(){
		alert("상품 주문 및 결제가 완료되었습니다.");
	}
	function goList(){
		location.href = '/product/list?pageNum=1&amount=6';
	}
	function goMain(){
		location.href = '/main';
	}
</script>
	<br/><br/>
	<div>
		<span style="font-size: 25px; font-weight: bold; align-content: left;">구매 및 상품 정보</span>
		<span style="font-size: 18px; position: relative; left: 66%; top : -7px;">주문결제 > </span><span style="float: right; font-size: 18px; color: #a384ff; font-weight: bold;">주문완료</span>
	</div>
	<hr style="clear:both; border: 1px solid grey; margin-bottom: 15px;"/>
	<table class="prodTbl">
		<tr>
			<th class="img">상품 이미지</th>
			<th class="title">상품명</th>
			<th class="price">상품 가격</th>
			<th class="purchase-count">구매 수량</th>
			<th class="total">총 결제 금액</th>
		</tr>
		<tr>
			<td class="img">
				<img src='/resources/image/<c:out value="${prodInfo.image}"/>.jpg' style="width: 100px; height: 100px;">
			</td>
			<td class="title"><span>${prodInfo.pname}</span></td>
			<td class="price"><span>${prodInfo.price}</span></td>
			<td class="purchase-count"><span>${amount}</span></td>
			<td class="total">
				<c:if test="${prodInfo.price * amount >= 20000}">
					<span><fmt:formatNumber value="${prodInfo.price * amount}"/>원</span>
				</c:if>
				<c:if test="${prodInfo.price * amount <= 20000}">
					<span><fmt:formatNumber value="${prodInfo.price * amount + 5000}"/>원</span>
				</c:if>
			</td>
		</tr>
	</table>
	<br/><br/>
	<button class="goList" onclick="goList()">상품 목록으로</button>
	<button class="goMain" onclick="goMain()">메인으로</button>

<%@ include file="../include/footer.jsp" %>