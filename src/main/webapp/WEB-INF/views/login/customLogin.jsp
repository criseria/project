<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../include/header.jsp" %>
<style type="text/css">
	.loginForm{
		width: 100%;
		display: inline-block;
		text-align: center;
	}
	.inputBox, .login_btn{
		padding: 5px;
		border-radius: 50px:
	}
	
.box {
	margin-bottom: 5px;
    display: block;
    width: 500px;
    height: 51px;
    border: solid 1px #dadada;
    padding: 10px 14px 10px 14px;
    box-sizing: border-box;
    background: #fff;
    position: center;
    margin: auto;
}

.int {
    display: block;
    position: relative;
    width: 100%;
    height: 29px;
    border: none;
    background: #fff;
    font-size: 15px;
}
input {
    font-family: Dotum,'돋움',Helvetica,sans-serif;
    display: block;
    position: relative;
    width: 100%;
    height: 29px;
    border: none;
    background: #fff;
    font-size: 15px;   
}
.login_btn {
   position: center
   line-height: 40px;
   width: 500px;
   height: 51px;
   border: 1px solid #a384ff;
   font-size: 16px;
   font-weight: bold;
   text-align: center;
   background-color: white;
   color: a384ff;
   margin: auto;
   cursor: pointer;
}
.login_btn:hover {
 background-color: #6D57AE;
   color: white;
}
.signup_btn {
   position: center
   line-height: 40px;
   width: 500px;
   height: 51px;
   border: 1px solid #6ec5ff;
   font-size: 16px;
   font-weight: bold;
   text-align: center;
   background-color: white;
   color: #6ec5ff;
   cursor: pointer;
   margin: auto;
}
.signup_btn:hover {
 background-color: #58A4D7;
   color: white;
}
 a {
 	color: lightgray; 
 	text-decoration: none; 
 	outline: none
 }
 a:hover, a:active {
 	text-decoration: none; 
 	color:black; 
 	background-color:white;
 }
h1 {
	color: black;
}
h2 {
	color: red;
}

</style>
<script type="text/javascript">
	function signup(){
		location.href = "/login/signup";
	}
	
	function goFindID(){
		location.href = "/login/goFindID";
	}
	
	function findPW(){
		location.href = "/login/findPW";
	}
</script>

	<div class="loginForm">
		<h1>Tram Login</h1>
		<h2><c:out value = "${error}"/></h2>
		<h2><c:out value = "${logout}"/></h2>
		
		<form method="post" action="/login" class="loginForm">	
			<div class="inputBox">
				<span class="box int_id">
		    	<input class="" placeholder="아이디" name="username" type="text" autofocus>
		    	</span>
		    </div>
		    <div class="inputBox">
		    	<span class="box int_pass">
		        <input class="" placeholder="비밀번호" name="password" type="password" value="">
  	        	</span>
  	        </div>
         	 &nbsp;
		    <input type="submit" value="로그인" class="login_btn">
			&nbsp;
			<input value="회원가입" class="signup_btn" onclick="signup()">
		    <!--  csrf 공격 방어를 위해 동적 생성 -->
		</form>
		    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
<!-- 		<a href="/login/signup">회원가입  </a> <a></a>  -->
		<a href="/login/goFindID">아이디 찾기  </a> <a>/</a>
		<a href="/login/findPW">비밀번호 찾기  </a>
<!-- 		
		<input type="submit" value="아이디 찾기" class="findID_btn" onclick="goFindID()">
		<input type="submit" value="비밀번호 찾기" class="findPW_btn" onclick="findPW()"> -->
	</div>

<%@ include file="../include/footer.jsp" %>

