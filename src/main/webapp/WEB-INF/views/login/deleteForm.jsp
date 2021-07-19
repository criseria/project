<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../include/header.jsp" %>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
function back() {
    history.back(); 
}
</script>
<style>
h1{
text-align:center;
	color: black;
}

h3 {
    font-size: 14px;
    font-weight: 700;
    text-align: left;
}

label {
	margin-left: 90px;
}
.box {
    display: block;
    width: 60%;
    height: 51px;
    border: solid 1px #dadada;
    padding: 10px 14px 10px 14px;
    box-sizing: border-box;
    background: #fff;
	margin: 0px 0px 3px 345px; 
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
#userid {
	background: #efefef;
}
  select {
    font-family: Dotum,'돋움',Helvetica,sans-serif;
    display: block;
    position: relative;
    width: 100%;
    height: 29px;
    border: none;
    background: #fff;
    font-size: 15px;   
}
h1{
	text-align:center;
	color: black;
}

#inter {
	margin: 14px 0px 14px 270px;
}
.btnBack {
   line-height: 40px;
   width: 29%;
   height: 42px;
   border: 1px solid #6ec5ff;
   font-size: 16px;
   font-weight: bold;
   text-align: center;
   background-color: white;
   color: #6ec5ff;
   cursor: pointer;
   margin: 22px 0px 0px 22px;
}
.btnBack:hover {
 background-color: #58A4D7;
   color: white;
}
.btnJoin1 {
	float:left;
   line-height: 40px;
   width: 29%;
   height: 42px;
   border: 1px solid #a384ff;
   font-size: 16px;
   font-weight: bold;
   background-color: white;
   color: a384ff;
   margin: 35px 0px 0px 88px;
   cursor: pointer;
}
.btnJoin1:hover {
 background-color: #6D57AE;
   color: white;
}
#userid {
	background: #efefef;
}
 .box.int_id {
	background: #efefef;
} 
</style>

</head>
<body>
<%@ include file="../include/mypage.jsp" %>
<h1>회원탈퇴</h1>
	<form action="/login/deleteForm" method="post">
		<h3 class="join_title">
		<label for="id">아이디</label>
		</h3>
		<span class="box int_id">
		<input type="text" name="userid" id="userid" value="${UserDTO.userid}" readonly><br>
		</span>
		<h3 class="join_title">
		<label for="pass">비밀번호</label>
		</h3>
		<span class="box int_pass">
		<input type="password" name="userpw"><br>
		</span>
		<button type="submit" class="btnJoin1">탈퇴하기</button>
	</form>
		<button onclick="back()" class="btnBack">돌아가기</button>
</body>
<%@ include file="../include/footer.jsp" %>