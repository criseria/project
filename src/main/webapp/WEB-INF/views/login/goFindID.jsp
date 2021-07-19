<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp" %>

<script type="text/javascript">
	function findID(){
		var username = document.getElementById('username');
		var email = document.getElementById('email');
		
		if(username.value == ''){
			alert("성명을 입력하세요.");
			document.getElementById('username').focus();	// 해당 부분에 커서 이동하는 기능
			return;
		}else if(email.value == ''){
			alert("이메일을 입력하세요.");
			document.getElementById('email').focus();
			return;
		}else{
			document.getElementById("findID_form").submit();
		}
	}
	function back() {
	    history.back(); 
	}	

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
   margin: auto;
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
<h1>아이디 찾기</h1>

<div>
	<form action="/login/findID" method="post" id="findID_form">
		<div>
			<span class="box int_name">
			<input type="text" name="username" id="username" placeholder="성명">
			</span>
		</div>
		<div>
			<span class="box int_email">
			<input type="text" name="email" id="email" placeholder="이메일">
			</span>
		</div>
		<div>
			<input type="button"  class="btnJoin" value="아이디 찾기" onclick="findID()" />
		</div>
	</form>
			<button onclick="back()" class="btnBack">돌아가기</button>			
</div>

<%@ include file="../include/footer.jsp" %>
