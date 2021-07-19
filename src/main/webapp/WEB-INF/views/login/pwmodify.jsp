<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- daum 도로명주소 찾기 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript"> 


//모든 공백 체크 정규식 
var empJ = /\s/g; 
//아이디 정규식 
var idJ = /^[a-z0-9][a-z0-9_\-]{4,19}$/; 
// 비밀번호 정규식 
var pwJ = /^[A-Za-z0-9]{4,12}$/; 
// 이름 정규식 
var nameJ = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/; 
// 이메일 검사 정규식 
var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; 
// 휴대폰 번호 정규식 
var phoneJ = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/; 
 
var address = $('#addr'); 
$(document).ready(function() { 
	var address = $('#addr');
	
	$('form').on('submit',function(){ 
		
		var inval_Arr = new Array(1).fill(false);
		// 비밀번호가 같은 경우 && 비밀번호 정규식 
		if (($('#userpw1').val() == ($('#userpw2').val())) 
				&& pwJ.test($('#userpw2').val())) { 
			inval_Arr[0] = true; 
			console.log('비밀번호 확인')
			}else { 
				inval_Arr[0] = false; 
				alert('비밀번호를 확인하세요.'); 
				return false; 
				} 
		//전체 유효성 검사 
		var validAll = true; 
		for(var i = 0; i < inval_Arr.length; i++){ 
			if(inval_Arr[i] == false){
				console.log('전체유효성 검사 실패')
				validAll = false; 
				} 
		}
		if(validAll == true){ 
			// 유효성 모두 통과 
		}else{ 
			alert('정보를 다시 확인하세요.')
			$('#id_check').text('');
			return false;
		} 
		});
	// 비밀번호 유효성 검사
	$('#userpw').keyup(function(){ 
		if (pwJ.test($('#userpw').val())) { 
			console.log('true'); 
			$('#pw_check').text(''); 
		}else { 
			console.log('false'); 
			$('#pw_check').text('4~12자의 숫자 , 문자로만 사용 가능합니다.'); 
			$('#pw_check').css('color', 'red');
			$('#pw_check').css('font-weight', 'bold'); 
			} 
		}); 
	$('#userpw1').keyup(function(){ 
		if (pwJ.test($('#userpw1').val())) { 
			console.log('true'); 
			$('#pw1_check').text(''); 
		}else { 
			console.log('false'); 
			$('#pw1_check').text('4~12자의 숫자 , 문자로만 사용 가능합니다.'); 
			$('#pw1_check').css('color', 'red');
			$('#pw1_check').css('font-weight', 'bold'); 
			} 
		}); 
	//1~2 패스워드 일치 확인 
	$('#userpw2').keyup(function() { 
		if ($('#userpw1').val() != $(this).val()) { 
			$('#pw2_check').text('비밀번호가 일치하지 않습니다.'); 
			$('#pw2_check').css('color', 'red');
			$('#pw2_check').css('font-weight', 'bold'); 
		}else { 
			$('#pw2_check').text(''); 
			} 
		}); 

function back() {
    history.back(); 
}
})
</script>
<style>
h3 {
    font-size: 14px;
    font-weight: 700;
    text-align: left;
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
 .box.int_id {
	background: #efefef;
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
label {
	margin-left: 90px;
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
   margin: 17px 0px 0px 22px;
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
   margin: 30px 0px 0px 90px;
   cursor: pointer;
}
.btnJoin1:hover {
 background-color: #6D57AE;
   color: white;
}
</style>

<%@ include file="../include/mypage.jsp" %>
<h1> 비밀번호  수정</h1>
<body>
		<div class="join">
			<form action="/login/pwmodify" method="POST">
 				<div class="form-group">
					<input type="hidden" class="form-control" id="userid" name="userid" value="${UserDTO.userid}">
					<h3 class="join_title">
					<label for="oldpw">기존 비밀번호</label> 
					</h3>
					<span class="box int_pass">
					<input type="password" class="form-control" id="userpw" name="userpw" placeholder="현재 비밀번호">
					</span>
					<span class="check_font" id="pw_check"></span>
				</div>
 				<div class="form-group">
 					<h3 class="join_title">
					<label for="pw">새 비밀번호</label> 
					</h3>
					<span class="box int_pass">
					<input type="password" class="form-control" id="userpw1" name="userpw1" placeholder="새 비밀번호">
					</span>
					<span class="check_font" id="pw1_check"></span>
				</div>
				<div class="form-group">
					<h3 class="join_title">
					<label for="pw2">새 비밀번호 확인</label> 
					</h3>
					<span class="box int_pass">
					<input type="password"class="form-control" id="userpw2" name="userpw2" placeholder="새 비밀번호 확인">
					</span>
					<span class="check_font" id="pw2_check"></span>
				</div> 
				<div class="form-group text-center">
					<button type="submit" class="btnJoin1">변경하기</button>
				</div>
			</form>
					<button onclick="back()" class="btnBack">돌아가기</button>
		</div>
</body>


<%@ include file="../include/footer.jsp" %>




