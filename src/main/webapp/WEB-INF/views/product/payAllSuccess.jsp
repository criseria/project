<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="/resources/button.css">
<link rel="stylesheet" href="/resources/payAllSuccess.css">

<script type="text/javascript">
	function goList(){
		location.href = '/product/list?pageNum=1&amount=6';
	}
	function goMain(){
		location.href = '/main';
	}
</script>
	
	<div class="depth" >
		<span style="font-size: 18px;">주문결제 > </span><span style="color: #a384ff; font-weight: bold; font-size: 18px;">주문완료</span>
	</div>
	<br/>
	
	<!-- 구매한 상품 List 정보 -->
	<div>
		<span style="font-size: 25px; font-weight: bold; align-content: left;">구매 상품</span>
	</div>
	<hr style="clear:both; border: 1px solid grey; margin-bottom: 15px;"/>
	<table class="prodTbl">
		<thead>
		<tr class="head">
			<th class="img">상품 이미지</th>
			<th class="title">상품명</th>
			<th class="price">상품 가격</th>
			<th class="purchase-count">구매 수량</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach var="buyList" items="${buyList}">
			<tr>
				<td class="img">
					<img src='/resources/image/<c:out value="${buyList.image}"/>.jpg' style="width: 100px; height: 100px;">
				</td>
				<td class="title"><span>${buyList.pname}</span></td>
				<td class="price"><fmt:formatNumber value="${buyList.price}"/></td>
				<td class="purchase-count"><span>${buyList.amount}</span></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<br/><br/>
	
	<!-- 결제 정보 -->
	<div>
		<span style="font-size: 25px; font-weight: bold; align-content: left;">결제 정보</span>
	</div>
	<hr style="clear:both; border: 1px solid grey; margin-bottom: 15px;"/>
	<table class="priceInfo">
		<tr>
			<th>총 상품 가격</th>
			<td style="border-bottom : 1px solid #e4e4e4;"><fmt:formatNumber value="${totalPrice}"/>원</td>
		<tr>
		<tr>
			<th>배송비</th>
			<c:if test="${totalPrice >= 20000}">
				<td style="border-bottom : 1px solid #e4e4e4;"><fmt:formatNumber value="0"/>원</td>
			</c:if>
			<c:if test="${totalPrice <= 20000}">
				<td style="border-bottom : 1px solid #e4e4e4;"><fmt:formatNumber value="5000"/>원</td>
			</c:if>
		<tr>
		<tr>
			<th>총 결제 금액</th>
			<c:if test="${totalPrice >= 20000}">
				<td><fmt:formatNumber value="${totalPrice}"/>원</td>
				<input type="hidden" class="totalPrice" value="<fmt:formatNumber value="${totalPrice}"/>">
			</c:if>
			<c:if test="${totalPrice <= 20000}">
				<td><fmt:formatNumber value="${totalPrice + 5000}"/>원</td>
				<input type="hidden" class="totalPrice" value="<fmt:formatNumber value="${totalPrice + 5000}"/>">
			</c:if>
		</tr>
	</table>
	<br/><br/>
	<button class="goList" onclick="goList()">상품 목록으로</button>
	<button class="goMain" onclick="goMain()">메인으로</button>

<%@ include file="../include/footer.jsp" %>