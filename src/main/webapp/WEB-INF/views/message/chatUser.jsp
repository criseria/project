<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.yes{
	left: 40%;
	position: relative;
	padding: 4px 8px;
	border: 1px solid #999;
	color: #333;
	border-radius: 2px;
	box-shadow: 0 -2px 0 rgb(0 0 0 / 10%) inset;
	font-size: 11px;
	background-color: white;
	cursor: pointer;
}	
.no{
	left: 40%;
	position: relative;
	padding: 4px 8px;
	border: 1px solid #999;
	color: #333;
	border-radius: 2px;
	box-shadow: 0 -2px 0 rgb(0 0 0 / 10%) inset;
	font-size: 11px;
	background-color: white;
	cursor: pointer;
}
	.chatHeader{
		background-color: #6ec5ff;
		position: fixed;
		top:0;
		left:0;
		width: 100%;
		height: 60px;
		clear: both;
		text-align: center;
	}
	
	label{
		font-size: 30px;
		font-weight: bold;
		top:7px;
		left: 23%;
		color: white;
		position: fixed;
	}
	
	.chatContent{
		width:96%;
		position: fixed;
		top: 70px;
		bottom: 70px;
		display: block;
		clear: both;
		overflow: auto;
	}
	
	#enterChat{
		font-weight: bold;
		font-size: 19px;
	}
	
	.myself2{
		background-color: #FAED7D;
		margin: 10px;
		padding: 5px;
		clear: both;
		float: right;
		border-radius: 5px;
	}
	
	.other2{
		background-color: #F6F6F6;
		margin: 10px;
		padding: 5px;
		clear: both;
		float: left;
		border-radius: 5px;
	}
	
	.chatFooter{
		position: fixed;
		bottom:10px;
		height : 40px;
		clear: both;
	}
	
	#button-send{
		position: relative;
		padding: 4px 8px;
		border: 1px solid #999;
		color: #333;
		border-radius: 2px;
		box-shadow: 0 -2px 0 rgb(0 0 0 / 10%) inset;
		font-size: 11px;
		background-color: white;
		cursor: pointer;
		width: 45px;
		height: 45px;
	}
	
	#msg{
		border: 2px solid black;
		border-radius: 5px;
		width: 330px;
		height: 40px;
	}

</style>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<body>
<sec:authentication property="principal" var="pinfo"/>
	<div class="chatHeader">
		<label><b>Q &amp; A Chatting</b></label>
	</div>
	<div class="chatContent">
		<div id="enterChat" align="center"></div>
		<div style="text-align: center;">상담사와 연결을 원하시나요?</div>
		<div>
			<button class="yes" type="button" id="yes">Yes</button>&nbsp;
			<button class="no" type="button" id="no">No</button>
		</div>
		<div style="position: relative; left: 9%; width : 330px;" class="yesOrNo"></div>
		<div id="msgArea"></div>
	</div>
	<div class="chatFooter">
		<input type="text" id="msg" aria-label="Recipient's username" aria-describedby="">
		<button type="button" id="button-send">전송</button>
	</div>
</body>
<!-- 소켓통신 라이브러리 -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<script type="text/javascript">
	
	// 상담사 연결을 원할 때
	$('#yes').on("click", function(){
		var answer = "잠시만 기다리시면 금방 연결해드리겠습니다.";
		$(".yesOrNo").empty();
		$(".yesOrNo").append(answer);
	});

	// 상담사 연결을 원하지 않을 때
	$('#no').on("click", function(){
		var answer = "Q&A 서비스를 이용해주셔서 감사합니다.";
		$(".yesOrNo").empty();
		$(".yesOrNo").append(answer);
		
		setTimeout("self.close()", 3000)
	});

	// 전송 버튼 누르는 이벤트
	$('#button-send').on("click", function(e){
		sendMessage();
		$('#msg').val('')
	});
	
	var sock = new SockJS('http://localhost:8090/chatting');
	sock.onmessage = onMessage;
	sock.onclose = onClose;
	sock.onopen = onOpen;
	
	function sendMessage(){
		if($("#msg").val() == ''){
			return;
		}else{
			sock.send($("#msg").val());
		}
	}
	
	// 서버에서 메시지를 받았을 때
	function onMessage(msg){
		
		var data = msg.data;
		var sessionId = null; // 데이터를 보낸 사람
		var message = null;
		
		var arr = data.split(":");
		
		for(var i = 0; i < arr.length; i++){
			console.log('arr[' + i + ']: ' + arr[i]);
		}
		
		var cur_session = '${userid}' // 현재 세션에 로그인한 사람
		console.log("cur_session : " + cur_session);
		
		sessionId = arr[0];
		message = arr[1];
		
		// 로그인한 클라이언트와 타 클라이언트를 분류하기
		if(sessionId == cur_session){
			var str = "<div class='myself2' align='right'>";
			str += "<div class=''>";
			str += "<b>" + message + "</b>";
			str += "</div></div>";
			
			$("#msgArea").append(str);
		}
		else{
			var str = "<div class='other2' align='left'>";
			str += "<div class=''>";
			str += "<b>" + sessionId + " : " + message + "</b>";
			str += "</div></div>";
			
			$("#msgArea").append(str);
		}
	}
	
	// 채팅방에서 나갔을 때
	function onClose(evt){
		var user = '${userid}'
		var str = user + "님이 퇴장하셨습니다.";
		
		$('#msgArea').append(str);
	}
	
	// 채팅방에 들어왔을 때
	function onOpen(evt){
		var user = '${userid}'
		var str = user + "님이 입장하셨습니다.";
		
		$('#enterChat').append(str);
	}
</script>
</html>