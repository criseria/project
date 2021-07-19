<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	// 로그인 페이지로 이동
	function login(){
		location.href = "/login/customLogin"
	}
	
	// 이메일 발송 (아이디, 이메일 기입 여부 체크)
	$(function(){
		$("#findPW_btn").click(function(){
			
			var userid = document.getElementById('userid');
			var email = document.getElementById('email');
			
			if(userid.value == ''){
				alert("아이디를 입력하세요.");
				document.getElementById('userid').focus();	// 해당 부분에 커서 이동하는 기능
				return;
			}else if(email.value == ''){
				alert("이메일을 입력하세요.");
				document.getElementById('email').focus();
				return;
			}
			
			$.ajax({
				url : "/login/findPW",
				type : "POST",
				data : {
					userid : $("#userid").val(),
					email : $("#email").val()
				},
				success : function(result){
					alert(result);
				}
			})	
		});
	});
</script>
<style>
h1 {
	text-align:center;

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
    margin-bottom: 10px;
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
.btnJoin {
   position:center;
   line-height: 40px;
   width: 500px;
   height: 51px;
   border: 1px solid #a384ff;
   font-size: 16px;
   font-weight: bold;
   text-align: center;
   background-color: white;
   color: a384ff;
   margin: 0px 0px 15px 300px;
   margin-top:20px;
   cursor: pointer;
}
.btnJoin:hover {
 background-color: #6D57AE;
   color: white;
}
.btnBack {
   position: relative;
   line-height: 40px;
   width: 500px;
   height: 51px;
   border: 1px solid #6ec5ff;
   font-size: 16px;
   font-weight: bold;
   text-align: center;
   background-color: white;
   color: #6ec5ff;
   margin: 0px 0px 5px 300px;
   cursor: pointer;
}
.btnBack:hover {
 background-color: #58A4D7;
   color: white;
}
</style>

<div>
	<div>
		<div>
			<h1>비밀번호 찾기</h1>
		</div>
		<div>
			<!-- 	<label>아이디</label> -->
				<span class="box int_id">
				<input type="text" id="userid" name="userid" placeholder="아이디를 입력하세요">
				</span>
		</div>
			<div>
	<!-- 			<label>이메일</label> -->
				<span class="box int_email">
				<input type="text" id="email" name="email" placeholder="이메일을 입력하세요">
				</span>
			</div>	
			<div>
				<button type="button" class="btnJoin" id="findPW_btn">비밀번호 찾기</button>
				<button type="button" class="btnBack" onclick="login()">로그인으로</button>
			</div>
	</div>
</div>

<%@ include file="../include/footer.jsp" %>
