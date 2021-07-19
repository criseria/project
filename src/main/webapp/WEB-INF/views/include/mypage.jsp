<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.mypage_myinfo{	
	margin: 0 20px 20px 0;
	padding: 0 15px 20px 15px; 
	width: 135px;
	float: left; 
	height: 450px;
	position: relative;
	
/* 	border: 1px solid; */
/* 	border-color: #b3e0ff; */
/* 	border-width: 0px 3px 0px 0px;		 */
}

.mypage_myinfo{
	position: relative;
	line-height: 3;
	float: left;
	width: 200px;
	height: 600px;
	border-right: 7px solid #EEE;
}

.mypage_myinfo li {	
	list-style-type: none;
	margin-bottom: 10px;
}

.mypage_myinfo li a{
	display: block;
	color: #000;
	padding: 1px 2px;
	text-decoration: none;
}

 .mypage_myinfo li a:hover{
	font-size: 15px;
	font-weight: bold;
} 


</style>
<div class="mypage_category">
	<div class="mypage_myinfo">
		<ul>
			<li><a href="/login/userinfo" class="cate_title">회원정보보기</a>
				<li><a href="/login/usermodify">회원정보수정 </a></li>
				<li><a href="/login/pwmodify">비밀번호수정 </a></li>
				<li><a href="/login/deleteForm">회원탈퇴하기 </a></li>
				<li><a href="/board/mywriting?pageNum=1&amount=20&bno_no=1">내가 쓴 글</a></li>
				<li><a href="/tourInfo/pickList?pageNum=1&amount=20&loc_no=8">여행지 찜 목록</a></li>
				<li><a href="/product/buyList">구매한 상품 목록</a></li>
		</ul>
			</div>
</div>