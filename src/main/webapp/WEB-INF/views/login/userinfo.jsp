<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../include/header.jsp" %>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="../include/mypage.jsp" %>

<style>
.type {
  border-collapse: collapse;
  text-align: center;
  line-height: 1.5;
  border-top: 1px solid #ccc;
  border-bottom: 1px solid #ccc;
  margin: 20px 10px;
  width: 800px;
  margin: 0 auto;

}
.type th {
  width: 250px;
  padding: 10px;
  font-weight: bold;
  vertical-align: top;
}
.type td {
  width: 550px;
  padding: 10px;
  vertical-align: top;
}
.type .even {
  background: #efefef;
}
.info {
	text-align: center;
}
h1 {
	color: black;	
	text-align: center;
}

</style>
<h1>회원정보 보기</h1>
<div class="info">
<table class="type">

	<tr>
		<th scope="row" >아이디</th>
		<td>${UserDTO.userid }</td>
	</tr>
	<tr>
		<th scope="row" class="even" id="title">이름</th>
		<td class="even">${UserDTO.username }</td>
	</tr>
	<tr>
		<th scope="row" >이메일</th>
		<td>${UserDTO.email }</td>
	</tr>
	<tr>
		<th scope="row" class="even">휴대폰 번호</th>
		<td class="even">${UserDTO.phone }</td>
	</tr>
	<tr>
		<th scope="row" >우편번호 </th>
		<td>${UserDTO.postcode}</td>
	</tr>
	<tr>
		<th scope="row" class="even" >도로명 주소 </th>
		<td class="even">${UserDTO.addr}</td>
	</tr>
	<tr>
		<th scope="row" >상세 주소 </th>
		<td>${UserDTO.addr_detail}</td>
	</tr>
	<tr>
		<th scope="row" class="even" >관심사 </th>
		<td class="even">${UserDTO.interest}</td>
	</tr>
</table>
<!-- 	<div>
	<input type="button" value="회원정보수정" class="btn" onclick="location.href='/login/usermodify'">
	<input type="button" value="비밀번호변경" class="btn" onclick="location.href='/login/pwmodify'">
	<input type="button" value="회원탈퇴" class="btn" onclick="location.href='/login/deleteForm'">
	</div>
	 -->
	</div>
</body>
<%@ include file="../include/footer.jsp" %>