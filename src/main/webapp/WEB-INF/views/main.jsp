<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
<title>Home</title>
<style type="text/css">
	.header{
		padding: 50px 0px 0px 0px;
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
		padding: 20px;
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
	
	.recommend .title div:nth-of-type(2){
		font-size: 20px;
		float: right;
		font-weight: bold;
		margin-bottom: 10px;
	}
	
	h4{
		text-align: right;
	}
	
	/* 슬라이드 부분 css */
	* {margin:0;padding:0;box-sizing:border-box;}
	.slidebox ul, li {list-style:none;}
	
	[name="slide"] {display:none;}
	.slidebox {max-width: 1100px; width: 100%; margin: 0 auto;}
	.slidebox img {max-width: 100%;}
	.slidebox .slidelist{
		white-space: nowrap;
		font-size: 0;
		overflow: hidden;
	}
	
	.slidebox .slideitem{
		position: relative;
		display: inline-block;
		vertical-align: middle;
		width: 100%;
		transition:all .35s;			/* 이 부분 확인 필요 */
	}
	
	.slidebox .slideitem label{
		position: absolute;
		z-index: 1;
		top: 50%;
		transform: translateY(-50%);	/* 이 부분 확인 필요 */
		padding: 20px;
		border-radius: 50%;
		cursor: pointer;
	}
	
	label.left{
		left: 20px;
		background-image: url("/resources/image/left-arrow.png");
		background-position: center center;
		background-size: 50%;
		background-repeat: no-repeat;
	}
	
	label.right{
		right: 20px;
		background-image: url("/resources/image/right-arrow.png");
		background-position: center center;
		background-size: 50%;
		background-repeat: no-repeat;
	}
	
	#slide01:checked ~ .slidelist .slideitem {transform:translateX(0);animation:slide01 15s infinite;}
	#slide02:checked ~ .slidelist .slideitem {transform:translateX(-100%);animation:slide02 15s infinite;}
	#slide03:checked ~ .slidelist .slideitem {transform:translateX(-200%);animation:slide03 15s infinite;}
	
	/* 슬라이드 Style */
	.slidebox {max-width:1100px;margin:0 auto;}
	.slidebox .slidelist {white-space:nowrap;font-size:0;overflow:hidden;}
	.slidebox .slidelist .slideitem {position:relative;display:inline-block;vertical-align:middle;width:100%;transition:all 1s;}
	.slidebox .slidelist .slideitem > a {display:block;width:auto;position:relative;}
	.slidebox .slidelist .slideitem > a img {max-width:100%;}
	.slidebox .slidelist .slideitem > a label {position:absolute;top:50%;transform:translateY(-50%);padding:20px;border-radius:50%;cursor:pointer;}
	.slidebox .slidelist .slideitem > a label.prev {left:20px;background:#333 url('./img/left-arrow.png') center center / 50% no-repeat;}
	.slidebox .slidelist .slideitem > a label.next {right:20px;background:#333 url('./img/right-arrow.png') center center / 50% no-repeat;}
	
	@keyframes slide01 {
		0% {left:0%;}
		33% {left:0%;}
		34% {left:-100%}
		66% {left:-100%;}
		67% {left:-200%;}
		99% {left:-200%;}
		100% {left:0%;}
	}
	
	@keyframes slide02 {
		0% {left:0%;}
		33% {left:0%;}
		34% {left:-100%;}
		66% {left:-100%;}
		67% {left:100%;}
		99% {left:100%;}
		100% {left:0%;}
	}
	
	@keyframes slide03 {
		0% {left:0%;}
		33% {left:0%;}
		34% {left:200%;}
		66% {left:200%;}
		67% {left:100%;}
		99% {left:100%;}
		100% {left:0%;}
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
	 function goLogin(){
	      alert("로그인이 필요한 서비스입니다.");
	      var check = confirm("로그인 하시겠습니까?");
	      if(check == true){
	         location.href = '/login/customLogin';
	      }else{
	         return;
	      }
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
						<c:if test="${check eq 'no'}">
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
               <li><a href="/product/list?pageNum=1&amount=9">상품 구매</a></li>
               <li><a href="/board/list?pageNum=1&amount=20">게시판</a></li>
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
			<div class="slidebox">
				<input type="radio" name="slide" id="slide01" checked="checked">
				<input type="radio" name="slide" id="slide02">
				<input type="radio" name="slide" id="slide03">
				<ul class="slidelist">
					<li class="slideitem">
						<div>
							<label for="slide03" class="left"></label>
							<label for="slide02" class="right"></label>
							<a href="#"><img style="width: 1100px;" src="/resources/image/slideimg01.jpg"></a>
						</div>
					</li>
					<li class="slideitem">
						<div>
							<label for="slide01" class="left"></label>
							<label for="slide03" class="right"></label>
							<a href="#"><img style="width: 1100px;" src="/resources/image/slideimg02.jpg"></a>
						</div>
					</li>
					<li class="slideitem">
						<div>
							<label for="slide02" class="left"></label>
							<label for="slide01" class="right"></label>
							<a href="#"><img style="width: 1100px;" src="/resources/image/slideimg03.jpg"></a>
						</div>
					</li>
				</ul>
			</div>
			<div class="recommend">
			<br/>
				<table style="float: left;">
					<tr class="title">
						<td colspan="2">
							<div style="font-size: 22px; font-weight: bold; float: left;">추천 여름 여행지</div>
                     		<sec:authorize access="!isAuthenticated()">
                        		<div><a href="#" style="text-decoration: none; color: grey;" onclick="goLogin()">more</a></div>
                    		</sec:authorize>
                     		<sec:authorize access="isAuthenticated()">
                        		<div><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=0" style="text-decoration: none; color: grey;">more</a></div>
                     		</sec:authorize>
							<hr style="clear: both; margin-bottom: 10px;"/>
						</td>
					</tr>
					<tr>
						<sec:authorize access="!isAuthenticated()">
		                  <td style="border: solid 1px black;">
		                     <a href="#" onclick="goLogin()"><img src="/resources/image/jeju.jpg"><br/></a>
		                     <div style="text-align: center;">
		                        <b>특별한 여름 휴가를 보내려면<br/>
		                        성산일출봉이 있는 제주 동부!</b>
		                     </div>
		                  </td>
		                  <td style="border: solid 1px black;">
		                     <a href="#" onclick="goLogin()"><img src="/resources/image/samcheok.jpg"></a>
		                     <div style="text-align: center;">
		                        <b>여름바다에서 즐기는 스노쿨링<br/>
		                        한국의 나폴리 삼척 장호항!</b>
		                     </div>
		                  </td>
		                  </sec:authorize>
		                  <sec:authorize access="isAuthenticated()">
		                  <td style="border: solid 1px black;">
		                     <a href="/tourInfo/list?pageNum=1&amount=9&loc_no=7"><img src="/resources/image/jeju.jpg"><br/></a>
		                     <div style="text-align: center;">
		                        <b>특별한 여름 휴가를 보내려면<br/>
		                        성산일출봉이 있는 제주 동부!</b>
		                     </div>
		                  </td>
		                  <td style="border: solid 1px black;">
		                     <a href="/tourInfo/list?pageNum=1&amount=9&loc_no=4"><img src="/resources/image/samcheok.jpg"></a>
		                     <div style="text-align: center;">
		                        <b>여름바다에서 즐기는 스노쿨링<br/>
		                        한국의 나폴리 강원도 삼척!</b>
		                     </div>
		                  </td>
		                </sec:authorize>
					</tr>
				</table>
				<table style="float: right;">
					<tr class="title">
						<td colspan="2">
							<div style="font-size: 22px; font-weight: bold; float: left;">여름 여행 필수템</div>
							<div><a href="/product/list?pageNum=1&amount=9" style="text-decoration: none; color: grey;">more</a></div>
							<hr style="clear: both; margin-bottom: 10px;"/>
						</td>
					</tr>
					<tr>
						<td style="border: solid 1px black;">
							<a href="/product/get?pageNum=1&amount=9&type=&keyword=&catenum=300&pno=66"><img src="/resources/image/selfie.jpg"><br/></a>
							<div style="text-align: center;">
								<b>혼자서도, 커플사진도 OK<br/>
								여행 필수품 셀카봉!</b>
							</div>
						</td>
						<td style="border: solid 1px black;">
							<a href="/product/get?pageNum=1&amount=6&type=&keyword=&catenum=0&pno=84"><img src="/resources/image/sunglasses.jpg"></a>
							<div style="text-align: center;">
								<b>멋 내면서 시력도 보호하자<br/>
								연예인 선글라스!</b>
							</div>
						</td>
					</tr>
				</table>
				<p style="clear: both;"></p>
			</div>
		</div>
		<!-- body 끝 -->
		
		<!-- footer (기타 정보, 로고) -->
		<div class="footer">
			<hr style="border: solid 1px black; margin-top: 20px;"/>
			<a href="/main"><img align="right" src="/resources/image/logo2.png"/></a>
			<span style="font-weight: bold; font-size: 20px;">Travel Maker</span> | <a href="#" style="font-weight: normal;">http://travelmaker.co.kr</a>
		</div>
		<!-- footer 끝 -->
	</div>
</body>
</html>
