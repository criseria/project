<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
<title>Insert title here</title>
<style type="text/css">
	.header{
		padding: 25px 0px 0px 0px;
	}
	.footer {
 	clear: both;
	}
	.wrap{
		width: 1100px;
		margin: 0px auto;
	}
	.login a, .nav a, .footer a{
		text-decoration: none;
		font-weight: bold;
		color: black;
	}
	.nav ul{
		list-style-type: none;
		padding: 10px;
		overflow: hidden;
		margin: 0px;
		text-align: center;
	}
	.nav li{
		margin-left: 65px;
		margin-right: 65px;
		display: inline-block;
		font-size: 25px;
	}
	.nav a:hover{
		color: #a384ff;
		text-decoration: underline;
	}
	.footer{
		margin-bottom: 40px;
	}
	
	h4{
		text-align: right;
	}
</style>
<script type="text/javascript">
	function logout(){
		var logout = confirm("로그아웃 하시겠습니까?");
		if(logout == true){
			document.getElementById('logoutform').submit();
		}
	}
	
	function chatAdmin(){
		window.open("message/chatAdmin", "", "width=400, height=560, left=600, top=100");
	}
	
	function chatUser(){
		$(".sendChatAlarm").submit();
		window.open("message/chatUser", "", "width=400, height=560, left=600, top=100");
	}
</script>
</head>
<body>
	<div class="wrap">
		<!-- header (로고, 로그인, 회원가입, 채팅, 메뉴) -->
		<div class="header">
			<sec:authorize access='isAuthenticated()'>
         	<sec:authentication property="principal" var="pinfo"/>
            	<div>
               		<h4><c:out value="${pinfo.username}님 반갑습니다"/></h4>   
            	</div>
         	</sec:authorize>
			<!-- 로그인 -->
			<div class="login" style="text-align: right;">
				<a href="/main"><img style="position: relative; width: 500px; height:90px; float : left; top:-13px;" src="/resources/image/new-logo.PNG"/></a>
				<sec:authorize access="!isAuthenticated()">
					<a href="/login/customLogin"><img src="/resources/icon/login.png"/></a>&emsp;&emsp;&nbsp;
					<a href="/login/signup"><img src="/resources/icon/signup.png" width="45" height="45"/></a>&nbsp;
					<br/>
					<a href="/login/customLogin">로그인 &nbsp;</a>
					| 
					<a href="/login/signup">&nbsp; 회원가입</a>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<a href="#" onclick="logout()"><img src="/resources/icon/login.png"/></a>&emsp;&emsp;&nbsp;&nbsp;
					<a href="/product/cartlist"><img src="/resources/icon/cart.png" width="45" height="45"/></a>&emsp;&emsp;&emsp;&nbsp;
					<sec:authentication property="principal" var="pinfo"/>
					<c:if test="${pinfo.username eq 'admin01'}">
						<c:if test="${check ne 'no'}">
							<a href="#" onclick="chatAdmin()"><img src="/resources/icon/message.png" width="45" height="45"/></a>&emsp;&nbsp;
						</c:if>
						<c:if test="${check eq 'yes'}">
							<a href="#" onclick="chatAdmin()"><img src="/resources/icon/message2.png" width="45" height="45"/></a>&emsp;&nbsp;
						</c:if>
					</c:if>
					<c:if test="${pinfo.username ne 'admin01'}">
						<a href="#" onclick="chatUser()"><img src="/resources/icon/message.png" width="45" height="45"/></a>&emsp;&nbsp;
					</c:if>
					<br/>
					<a href="#" onclick="logout()">로그아웃 &nbsp;</a>
					| 
					<a href="/product/cartlist" >&nbsp;&nbsp; 장바구니 &nbsp;&nbsp;</a>
					| 
					<c:if test="${pinfo.username eq 'admin01'}">
						<a href="#" onclick="chatAdmin()">&nbsp; Q &amp; A</a>&emsp;
					</c:if>
					<c:if test="${pinfo.username ne 'admin01'}">
						<a href="#" onclick="chatUser()">&nbsp; Q &amp; A</a>&emsp;
					</c:if>
				</sec:authorize>
			</div>
			<!-- 일반 user가 클릭하면 DB 접근해서 값 insert(관리자에게 알림 띄우기 위해) -->
			<form action="/message/chatAlarm" method="post" class="sendChatAlarm">
				<input type="hidden" name="userid" value="${pinfo.username}">
				<input type="hidden" name="towho" value="admin01">
			</form>
			
			<form id="logoutform" action="/logout" method="post">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			</form>
			<hr style="margin-top: 20px"/>
			<!-- 메뉴 -->
			<div class="nav">
			<ul>
            	<sec:authorize access="!isAuthenticated()">
               		<li><a href="#" onclick="goLogin()">여행지 소개</a></li>
            	</sec:authorize>   
            	<sec:authorize access="isAuthenticated()">
               		<li><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=0">여행지 소개</a></li>
            	</sec:authorize>
               		<li><a href="/product/list?pageNum=1&amount=6">상품 구매</a></li>
               		<li><a href="/board/list?pageNum=1&amount=10">게시판</a></li>
            	<sec:authorize access="!isAuthenticated()">   
               		<li><a href="#" onclick="goLogin()">MyPage</a></li>
            	</sec:authorize>
            	<sec:authorize access="isAuthenticated()">
               		<li><a href="/login/userinfo">MyPage</a></li>
            	</sec:authorize>
            </ul>
			</div>
			<hr style="margin-bottom: 20px"/>
		</div>
		<!-- header 끝 -->
		
		<!-- body (슬라이드 이미지, 여행지 추천, 상품 추천) -->
		<!-- 슬라이드 -->
		<div class="contents">
		
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
