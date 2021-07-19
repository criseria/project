<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="/resources/button.css">
<link rel="stylesheet" href="/resources/payAll.css">

<sec:authentication property="principal" var="pinfo"/>

<!-- 화면 내 기본 스크립트 요소 및 daum 도로명주소 찾기 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

	/* 회원정보와 구매자 정보가 동일한 경우 */
	function insertUserInfo(){
		console.log('회원정보 : ' + '${uInfo.username}');
		
		/* form에 유저 이름 채우기 */
		$('.username').val('${uInfo.username}');
		$('.username').attr('readonly', 'readonly');
		
		/* form에 유저 이메일 채우기 */
		$('.email').val('${uInfo.email}');
		$('.email').attr('readonly', 'readonly');
		
		/* form에 유저 휴대폰번호 채우기 */
		$('.phone').val('${uInfo.phone}');
		$('.phone').attr('readonly', 'readonly');
		
		/* '회원정보와 동일' 버튼 바꾸기 */
		$('.userInfo').text('직접 입력');
		$('.userInfo').attr('onclick', 'writeSelfUserInfo()');
		
	};
	
	
	/* 구매자 정보를 직접 입력할 경우 */
	function writeSelfUserInfo(){
		
		/* form에 유저 이름 비우기 */
		$('.username').val('');
		$('.username').removeAttr('readonly');

		/* form에 유저 이메일 비우기 */
		$('.email').val('');
		$('.email').removeAttr('readonly');
		
		/* form에 유저 휴대폰번호 비우기 */
		$('.phone').val('');
		$('.phone').removeAttr('readonly');
		
		/* '직접입력' 버튼 바꾸기 */
		$('.userInfo').text('회원정보와 동일');
		$('.userInfo').attr('onclick', 'insertUserInfo()');
	};
	
	
	/* 받는 사람 정보와 구매자 정보가 동일한 경우 */
	function insertRecipientInfo(){
		
		/* form에 유저 이름 채우기 */
		$('.recipient').val('${uInfo.username}');
		$('.recipient').attr('readonly', 'readonly');
		
		/* form에 유저 휴대폰번호 채우기 */
		$('.rcpPhone').val('${uInfo.phone}');
		$('.rcpPhone').attr('readonly', 'readonly');
		
		/* form에 '우편번호 찾기' row 지우기 */
		$('.postcode').val('${uInfo.postcode}');
		$('.postcode').attr('readonly', 'readonly');
		
		/* form에 유저 도로명주소 채우기 */
		$('.addr').val('${uInfo.addr}');
		$('.addr').attr('readonly', 'readonly');

		/* form에 유저 상세주소 채우기 */
		$('.addr_detail').val('${uInfo.addr_detail}');
		$('.addr_detail').attr('readonly', 'readonly');
		
		/* '회원정보와 동일' 버튼 바꾸기 */
		$('.recipientInfo').text('직접 입력');
		$('.recipientInfo').attr('onclick', 'writeSelfRecipientInfo()');
	};
	
	
	/* 받는 사람 정보를 직접 입력할 경우 */
	function writeSelfRecipientInfo(){
		
		/* form에 유저 이름 채우기 */
		$('.recipient').val('');
		$('.recipient').removeAttr('readonly');
		
		/* form에 유저 휴대폰번호 채우기 */
		$('.rcpPhone').val('');
		$('.rcpPhone').removeAttr('readonly');
		
		/* form에 '우편번호 찾기' row 지우기 */
		$('.postcode').val('');
		
		/* form에 유저 도로명주소 채우기 */
		$('.addr').val('');

		/* form에 유저 상세주소 채우기 */
		$('.addr_detail').val('');
		$('.addr_detail').removeAttr('readonly');
		
		/* '회원정보와 동일' 버튼 바꾸기 */
		$('.recipientInfo').text('회원정보와 동일');
		$('.recipientInfo').attr('onclick', 'insertRecipientInfo()');
	};
	

	/* get.jsp로 돌아가기 */
	function cancelPay(){
		history.back();
	};
	
	
	/* 우편번호 찾기 */
	function execPostCode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
				var extraRoadAddr = ''; // 도로명 조합형 주소 변수

				// 법정동명이 있을 경우 추가한다. (법정리는 제외)
				// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
					extraRoadAddr += data.bname;
				}
				// 건물명이 있고, 공동주택일 경우 추가한다.
				if (data.buildingName !== '' && data.apartment === 'Y') {
					extraRoadAddr += (extraRoadAddr !== '' ? ', '
							+ data.buildingName : data.buildingName);
				}
				// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				if (extraRoadAddr !== '') {
					extraRoadAddr = ' (' + extraRoadAddr + ')';
				}
				// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
				if (fullRoadAddr !== '') {
					fullRoadAddr += extraRoadAddr;
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				console.log(data.zonecode);
				console.log(fullRoadAddr);
				$('#addr_check').text('');

				$("[name=postcode]").val(data.zonecode);
				$("[name=addr]").val(fullRoadAddr);
			}
		}).open();
	};
</script>

<!-- 결제서비스 라이브러리 -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
 <script>
 
	function doPay(){

		IMP.init('imp38258785'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;
		/* 결제 정보 변수 */
		var address = $(".addr").val();
		var postcode = $(".postcode").val();
		
		/* 양식 안 채운 것 예외처리 */
		if($('.username').val() == ''){
			alert('구매자 이름을 확인해주세요.');
			return;
		}
		else if($('.email').val() == ''){
			alert('구매자 이메일을 확인해주세요.');
			return;
		}
		else if($('.phone').val() == ''){
			alert('구매자 휴대폰번호를 확인해주세요.');
			return;
		}
		else if($('.recipient').val() == ''){
			alert('받는 사람 이름을 확인해주세요.');
			return;
		}
		else if($('.rcpPhone').val() == ''){
			alert('받는 사람 연락처를 확인해주세요.');
			return;
		}
		else if($('.postcode').val() == ''){
			alert('받는 사람 우편번호를 확인해주세요.');
			return;
		}
		else if($('.addr').val() == ''){
			alert('받는 사람 도로명주소를 확인해주세요.');
			return;
		}
		else if($('.addr_detail').val() == ''){
			alert('받는 사람 상세주소를 확인해주세요.');
			return;
		}
		
		// 구매 테이블에 던져야 하는 모든 파라미터 String 한 줄에 넣고 컨트롤러에 던지기
		// userid
		var userid = '${pinfo.username}';
		
		// pno, cartpno
		var cntProds = document.getElementsByClassName("cntProds").length;
		var pno = new Array();
		var cartpno = new Array();	// 결제 후 장바구니에서 해당 상품 삭제하기 위해 cartpno도 저장 및 전달해야 함
		<c:forEach items="${cartList}" var="cartList">
        	pno.push("${cartList.pno}");
        	cartpno.push("${cartList.cartpno}");
   		</c:forEach>
		
		for(var i = 0; i < cntProds; i++){
			console.log(pno[i]);
		};
		
		// amount
		var amount = new Array();
		<c:forEach items="${cartList}" var="cartList">
    		amount.push("${cartList.amount}");
		</c:forEach>
	
		for(var i = 0; i < cntProds; i++){
			console.log(amount[i]);
		};
		
		// recvName
		var recvName = $('.recipient').val();
		
		// recvPhone
		var recvPhone = $('.rcpPhone').val();
		
		// recvAddr
		var recvAddr = $('.addr').val() + ' ' + $('.addr_detail').val();
		
		// shipRequest
		var shipRequest = $('.request').val();
		
		// insert용 값 담기
		var allInfo = '';
		var allCartPno = '';
		
		for(var i = 0; i < cntProds; i++){
			allInfo += (userid + ',')
			allInfo += (pno[i] + ',')
			allInfo += (amount[i] + ',')
			allInfo += (recvName + ',')
			allInfo += (recvPhone + ',')
			allInfo += (recvAddr + ',')
			if(shipRequest == ''){
				allInfo += '없음!'
			}else{
				allInfo += (shipRequest + '!')
			}
			allCartPno += (cartpno[i] + ',')
		};
		
		var sendAllInfo = '<input type="hidden" name="allInfo" value="' + allInfo + '">';
		var sendAllCartPno = '<input type="hidden" name="allCartpno" value="' + allCartPno + '">';
		// insert 값 form에 넣기
		$('.buyListForm').append(sendAllInfo);
		
		// delete 값 form에 넣기
		$('.buyListForm').append(sendAllCartPno);
		
		var buyer_email = $('.email').val();
		var buyer_name = $('.username').val();
		var buyer_tel = $('.phone').val();
		
         IMP.request_pay({
            pg : 'kakaopay',
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
	        name : '${cartList[0].pname}' + '외 ' + (cntProds - 1) + '건 결제',
            amount : '${totalPrice}',
            buyer_email : buyer_email,
            buyer_name : buyer_name,
            buyer_tel : buyer_tel, // 오류 나면 여기 확인해보자
            buyer_addr : address,
            buyer_postcode : postcode
        }, function(rsp) {
            if ( rsp.success ) {
            	//[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
            	jQuery.ajax({
            		url: "/payments/complete", //cross-domain error가 발생하지 않도록 동일한 도메인으로 전송
            		type: 'POST',
            		dataType: 'json',
            		data: {
        	    		imp_uid : rsp.imp_uid
        	    		//기타 필요한 데이터가 있으면 추가 전달
            		}
            	}).done(function(data) {
            		//[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
            		if ( everythings_fine ) {
            			var msg = '결제가 완료되었습니다.';
            			msg += '\n고유ID : ' + rsp.imp_uid;
            			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
            			msg += '\결제 금액 : ' + rsp.paid_amount;
            			msg += '카드 승인번호 : ' + rsp.apply_num;

            			alert(msg);
            		} else {
            			//[3] 아직 제대로 결제가 되지 않았습니다.
            			//[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
            		}
            	});
            	 //성공시 이동할 페이지
            	 console.log($('.buyListForm'));
            	 $('.buyListForm').submit();
            } else {
                var msg = '결제에 실패하였습니다.';
                msg += '\n';
                msg += '에러내용 : ' + rsp.error_msg;
				
                //실패시 이동할 페이지
                // location.href='/product/payFail?msg=' + msg;
                
                alert(msg);
                return;
            }
        });
	}; 
        
</script>
<div class="container">
	<h1>주문/결제</h1>
	<div class="depth" style="font-size: 18px;"><span style="color: #a384ff; font-weight: bold;">주문결제 > </span><span>주문완료</span></div>
	<hr style="clear:both; border: 2px solid black;"/>
	<br/><br/>
	
	<!-- 구매자 정보 form -->
	<div class="buyerInfo">
		<span style="font-size: 25px; font-weight: bold; align-content: left;">구매자 정보</span>&emsp;&emsp;&emsp;
		<button class="userInfo" onclick="insertUserInfo()">회원정보와 동일</button>
	</div>
	<table class="table1">
		<tr>
			<th>이름</th>
			<td><input type="text" name="username" class="username"></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="email" name="email" class="email"></td>
		</tr>
		<tr>
			<th>휴대폰 번호</th>
			<td><input type="text" name="phone" class="phone"></td>
		</tr>
	</table>
	<br/><br/><br/>
	
	<!-- 배송 받는 사람 정보 form -->
	<div class="receiverInfo">
		<span style="font-size: 25px; font-weight: bold; align-content: left;">받는사람 정보</span>&emsp;&emsp;&emsp;
		<button class="recipientInfo" onclick="insertRecipientInfo()">회원정보와 동일</button>
	</div>
	<table class="table2">
		<tr>
			<th>이름</th>
			<td><input type="text" name="recipient" class="recipient"></td>
		</tr>
		<tr>
			<th>연락처</th>
			<td><input type="email" name="rcpPhone" class="rcpPhone"></td>
		</tr>
		<tr>
			<th>우편번호</th>
			<td>
               	<input type="text" name="postcode" class="postcode" readonly="readonly">
                <button type="button" class="btn btn-default" onclick="execPostCode();">우편번호 찾기</button>                               
			</td>
		</tr>
		<tr>
			<th>도로명 주소</th>
			<td>
				<input type="text" name="addr" class="addr" readonly="readonly" />
			</td>
		</tr>
		<tr>
			<th>상세 주소</th>
			<td>
				<input type="text" name="addr_detail" class="addr_detail"/>
			</td>
		</tr>
		<tr>
			<th>배송 요청사항</th>
			<td><input type="text" name="request" class="request"></td>
		</tr>
	</table>
	<br/><br/><br/>
	
	<!-- 구매하는 상품 정보 -->
	<div>
		<span style="font-size: 25px; font-weight: bold; align-content: left;">상품 정보</span>
	</div>
	<hr style="clear:both; border: 1px solid grey; margin-bottom: 15px;"/>
	<div>
		<table class="prodTitle">
			<tr>
				<td class="img">상품 이미지</td>
				<td class="title">상품명</td>
				<td class="price">가격</td>
				<td class="purchase-count">구매 수량</td>
			</tr>
		</table>
	</div>
	<br/>
	<div>
		<c:forEach var="cartList" items="${cartList}" varStatus="status">
			<table class="prodTbl">
				<tr>
					<td class="img"><img src='/resources/image/<c:out value="${cartList.image}"/>.jpg' style="width: 100px; height: 100px;"></td>
					<td class="cntProds"><c:out value="${cartList.pname}"></c:out></td>
					<td class="price"><c:out value="${cartList.price}"></c:out>원</td>
					<td class="purchase-count"><c:out value="${cartList.amount}"></c:out></td>
				</tr>
			</table>
			<input type="hidden" class="cartListPno" value="${cartList.pno}">
		</c:forEach>
	</div>
	<br/><br/><br/>
	
	<!-- 결제 정보 -->
	<div>
		<span style="font-size: 25px; font-weight: bold; align-content: left;">결제 정보</span>
	</div>
	<table class="table3">
		<tr>
			<th>총 상품 가격</th>
			<td><fmt:formatNumber value="${totalPrice}"/>원</td>
		<tr>
		<tr>
			<th>배송비</th>
			<c:if test="${totalPrice >= 20000}">
				<td><fmt:formatNumber value="0"/>원</td>
			</c:if>
			<c:if test="${totalPrice <= 20000}">
				<td><fmt:formatNumber value="5000"/>원</td>
			</c:if>
		<tr>
		<tr>
			<th>총 결제 금액</th>
			<c:if test="${totalPrice >= 20000}">
				<td><fmt:formatNumber value="${totalPrice}"/>원</td>
				<input type="hidden" class="totalPrice" value="<fmt:formatNumber value="${totalPrice}"/>">
			</c:if>
			<c:if test="${totalPrice <= 20000}">
				<td><fmt:formatNumber value="${totalPrice + 5000}"/>원</td>
				<input type="hidden" class="totalPrice" value="<fmt:formatNumber value="${totalPrice + 5000}"/>">
			</c:if>
		</tr>
		<tr>
			<th>결제방법</th>
			<td class="kakaoPay">
				<input type="radio" name="howToPay" value="kakao" checked="checked">카카오페이&emsp;
				<input type="radio" name="howToPay" class="transfer">계좌이체
			</td>
		</tr>
	</table>
	<br/><br/><br/>
	<button class="doPay" onclick="doPay()">결제하기</button>
	<button class="cancelPay" onclick="cancelPay()">결체 취소</button>
	
	<!-- 구매 테이블에 isert할 값 -->
	<form action="/product/payAllSuccess" method="post" class="buyListForm">
		<input type="hidden" name="user" value="${pinfo.username}">
	</form>
	
</div>	

<%@ include file="../include/footer.jsp" %>