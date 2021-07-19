<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="/resources/cartlist.css">
<link rel="stylesheet" href="/resources/button.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>

<script type="text/javascript">
	function removeCart(f){
		var remove = confirm("해당 상품을 장바구니에서 제거 하시겠습니까?");
		if(remove == true){
			alert("상품이 장바구니에서 제거 되었습니다.")
			f.submit();
		}else{
			return;
		}
	}
	
	function goPayAll(){
		$("#payAll").submit();
	}

</script>
<sec:authentication property="principal" var="pinfo"/>
	
	<h1 class="head"><img style="position:relative; top: 11px; " src="/resources/icon/cart-icon.PNG">장바구니</h1>
<div class="navi">
	<span class="main"><a href="/main">홈</a></span>
	<span class="step"><a href="/product/cartlist">장바구니</a></span>
</div>
<hr style="clear:both; border: 2px solid black;"/>
<c:choose>
	<c:when test="${cartList ne '[]'}">
		<div class="panel-body">
			<div>
				<table class="prodTitle">
					<tr>
						<th class="img">상품 이미지</th>
						<th class="title">상품명</th>
						<th class="price">가격</th>
						<th class="purchase-count">구매 수량</th>
					</tr>
				</table>
			</div>
			<div class="body">
				<c:forEach var="cartList" items="${cartList}" varStatus="status">
					<form class="removeCart" method="post" action="/product/removeCart">
						<table class="prodTbl">
							<tr>
								<td class="img"><img src='/resources/image/<c:out value="${cartList.image}"/>.jpg' style="width: 100px; height: 100px;"></td>
								<td class="title"><c:out value="${cartList.pname}"></c:out></td>
								<td class="price"><fmt:formatNumber value='${cartList.price}'/>원</td>
								<td class="purchase-count"><c:out value="${cartList.amount}"></c:out></td>
								<td class="button"><input type="button" class="removeCart" onclick="removeCart(this.form)" value="X"><td>
							</tr>
						</table>
						<input type="hidden" name="cartpno" value="${cartList.cartpno}">
					</form>
				</c:forEach>
			</div>
		</div>
		<br/><br/><br/>
		<button class="cartlist-btn1" type="button" onclick="goPayAll()">구매하기</button>
	</c:when>
	<c:otherwise>
		<h1 style="position: relative; left: 30%;">장바구니에 담긴 상품이 없습니다.</h1>
	</c:otherwise>
</c:choose>

<form action="/product/payAll" method="post" id="payAll">
	<input type="hidden" name="userid" value="${pinfo.username}">
</form>

<%@ include file="../include/footer.jsp" %>