<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../include/header.jsp" %>

<script type="text/javascript">
	function signup(){
		location.href = "/login/signup";
	}

	function findPW(){
		location.href = "/login/findPW";
	}
	
	function goMain(){
		location.href = "/main";
	}
	
</script>

<c:choose>
	<c:when test="${userid ne null}">
		<h1>고객님의 아이디는 <c:out value = "${userid}"/> 입니다.</h1>
	</c:when>
	<c:otherwise>
		<h1>입력하신 정보와 일치하는 아이디가 없습니다.</h1>
	</c:otherwise>
</c:choose>
	<input type="submit" value="회원가입" class="signup_btn" onclick="signup()">
	<input type="submit" value="비밀번호 찾기" class="findPW_btn" onclick="findPW()">
	<input type="submit" value="메인으로" class="goMain_btn" onclick="goMain()">

<%@ include file="../include/footer.jsp" %>