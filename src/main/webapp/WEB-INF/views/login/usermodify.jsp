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
		
		var inval_Arr = new Array(5).fill(false);
		// 비밀번호가 같은 경우 && 비밀번호 정규식 
		if (($('#userpw').val() == ($('#userpw2').val())) 
				&& pwJ.test($('#userpw2').val())) { 
			inval_Arr[0] = true; 
			console.log('비밀번호 확인')
			}else { 
				inval_Arr[0] = false; 
				alert('비밀번호를 확인하세요.'); 
				return false; 
				} 
		// 이름 정규식 
		if (nameJ.test($('#username').val())) { 
			inval_Arr[1] = true;
			console.log('이름확인')
		}else { 
			inval_Arr[1] = false; 
			alert('이름을 확인하세요.'); 
			return false; 
		} 
		// 이메일 정규식 
		if (mailJ.test($('#email').val())){ 
			console.log(mailJ.test($('#email').val())); 
			inval_Arr[2] = true;
			console.log('이메일 확인')
		}else { 
			inval_Arr[2] = false; 
			alert('이메일을 확인하세요.'); 
			return false; 
			} 
		// 휴대폰번호 정규식 
		if (phoneJ.test($('#phone').val())) { 
			console.log(phoneJ.test($('#phone').val())); 
			inval_Arr[3] = true;
			console.log('핸드폰 번호 확인')
		}else {
			inval_Arr[3] = false;
			alert('휴대폰 번호를 확인하세요.');
			return false; 
			}
		//주소확인 
		if(address.val() == ''){ 
			inval_Arr[4] = false; 
			alert('주소를 확인하세요.');
			$('#addr_check').text('우편번호 찾기를 해주십시요.'); 
			$('#addr_check').css('color', 'red');
			$('#addr_check').css('font-weight', 'bold');
			return false; 
		}else
			console.log('주소확인')
			inval_Arr[4] = true; 
		
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
			alert('회원정보가 수정되었습니다.'); 
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
	//1~2 패스워드 일치 확인 
	$('#userpw2').keyup(function() { 
		if ($('#userpw').val() != $(this).val()) { 
			$('#pw2_check').text('비밀번호가 일치하지 않습니다.'); 
			$('#pw2_check').css('color', 'red');
			$('#pw2_check').css('font-weight', 'bold'); 
		}else { 
			$('#pw2_check').text(''); 
			} 
		}); 
	//이름에 특수문자 들어가지 않도록 설정 
	$("#username").keyup(function() { 
		if (nameJ.test($(this).val())) { 
			console.log(nameJ.test($(this).val())); 
			$("#name_check").text(''); 
		}else { 
			$('#name_check').text('한글 2~4자 이내로 입력하세요. (특수기호, 공백 사용 불가)'); 
			$('#name_check').css('color', 'red');
			$('#name_check').css('font-weight', 'bold'); 
			} 
		}); 
	$("#email").keyup(function() { 
		if (mailJ.test($(this).val())) { 
			$("#email_check").text(''); 
		}else { 
			$('#email_check').text('이메일 양식을 확인해주세요.'); 
			$('#email_check').css('color', 'red'); 
			$('#email_check').css('font-weight', 'bold'); 
			} 
		}); 
	// 휴대전화 
	$('#phone').keyup(function(){ 
		if(phoneJ.test($(this).val())){ 
			console.log(phoneJ.test($(this).val()));
			$("#phone_check").text(''); 
		}else { 
			$('#phone_check').text('휴대폰번호를 확인해주세요 '); 
			$('#phone_check').css('color', 'red'); 
			$('#phone_check').css('font-weight', 'bold'); 
			} 
		}); 
	});  
	// 우편번호 찾기
function execPostCode() {
         new daum.Postcode({
             oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 
                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
 
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }
 
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                console.log(data.zonecode);
                console.log(fullRoadAddr);
            	$('#addr_check').text(''); 
                
                $("[name=postcode]").val(data.zonecode);
                $("[name=addr]").val(fullRoadAddr);
                
               // document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
               // document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
               // document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; 
            }
         }).open();
     }

function back() {
    history.back(); 
}

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

#inter {
	margin: 14px 0px 14px 270px;
}
.btnJoin {
   position: center
   line-height: 40px;
   width: 150px;
   height: 51px;
   border: 1px solid #a384ff;
   font-size: 16px;
   font-weight: bold;
   text-align: center;
   background-color: white;
   color: a384ff;
   margin: 15px 5px 10px 88px;
   cursor: pointer;
}
.btnJoin:hover {
 background-color: #6D57AE;
   color: white;
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
   margin: 5px 0px 0px 22px;
   cursor: pointer;
}
.btnBack:hover {
 background-color: #58A4D7;
   color: white;
}
.btnJoin1 {
   float: left;
   line-height: 40px;
   width: 29%;
   height: 42px;
  border: 1px solid #a384ff;
   font-size: 16px;
   font-weight: bold;
   text-align: center;
   background-color: white;
   color: a384ff;
   margin: 18px 0px 0px 345px;
   cursor: pointer;
}
.btnJoin1:hover {
 background-color: #6D57AE;
   color: white;
}
label {
	margin-left: 90px;
}
</style>



<%@ include file="../include/mypage.jsp" %>
<h1>회원정보 수정</h1>
<body>
		<div class="join">
			<form action="/login/usermodify" method="post">
				<div class="form-group">
					<h3 class="join_title">
					<label for="id">아이디</label>
					</h3>
					<span class="box int_id">
					<input type="text" class="form-control"id="userid" name="userid" value="${UserDTO.userid}" readonly=""> 
					</span>
					<label>아이디는 변경하실 수 없습니다!</label>
					<span class="check_font" id="id_check"></span>
				</div>
				<div class="form-group">
					<h3 class="join_title">
					<label for="mem_name">이름</label> 
					</h3>
					<span class="box int_name">
					<input type="text" class="form-control" id="username" name="username" value="${UserDTO.username}">
					</span>
					<span class="check_font" id="name_check"></span>
				</div>
				<div class="form-group">
					<h3 class="join_title">
					<label for="mem_email">이메일 주소</label> 
					</h3>
					<span class="box int_email">
					<input type="email" class="form-control" id="email" name="email" value="${UserDTO.email}">
					</span>
					<span class="check_font" id="email_check"></span>
				</div>
				<div class="form-group">
					<h3 class="join_title">
					<label for="mem_phone">휴대폰 번호('-'없이 번호만 입력해주세요)</label> 
					</h3>
					<span class="box int_phone">
					<input type="tel" class="form-control" id="phone" name="phone" value="${UserDTO.phone}">
					</span>
					<span class="check_font" id="phone_check"></span>
				</div>
				<div class="form-group"> 
					<button type="button" class="btnJoin" onclick="execPostCode();"><i class="fa fa-search"></i> 우편번호 찾기</button>                               
					<span class="box int_addr">                  
					<input class="form-control" placeholder="우편번호" name="postcode" id="postcode" type="text" readonly="readonly" value="${UserDTO.postcode}">
					</span>
					<span class="check_font" id="addr_check"></span>
					</div>
					<div class="form-group">
					<span class="box int_addr">
					    <input class="form-control" placeholder="도로명 주소" name="addr" id="addr" type="text" readonly="readonly" value="${UserDTO.addr}"/>
					</span>
					</div>
					<div class="form-group">
					<span class="box int_addr">
					    <input class="form-control" placeholder="상세주소" name="addr_detail" id="addr_detail" type="text" value="${UserDTO.addr_detail}" />
					</span>
					</div>
				<div class="form-group">
					<h3 class="join_title" id="inter">
					<label for="interest">관심사</label>
					</h3>
					<span class="box int_addr">
						<select name="interest">
							<option value="선택없음">::선택없음::</option>
							<option value="호캉스">호캉스</option>
							<option value="게임">게임</option>
							<option value="낚시">낚시</option>
							<option value="캠핑">캠핑</option>
						</select>
						</span>
				</div>
				<div class="form-group text-center">
					<button type="submit" class="btnJoin1">수정하기</button>
				</div>
			</form>
					<button onclick="back()" class="btnBack">돌아가기</button>
			
		</div>
</body>


<%@ include file="../include/footer.jsp" %>




