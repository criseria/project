<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="/resources/p_getpage.css">
<link rel="stylesheet" href="/resources/button.css">

<script type="text/javascript">

	function goLogin(){
	    alert("로그인이 필요한 서비스입니다.");
	    var check = confirm("로그인 하시겠습니까?");
	    if(check == true){
	       location.href = '/login/customLogin';
	    }else{
	       return;
	    }
	 }

	// 결제 페이지로 이동
	function goPayment(){
		/* 사용자가 선택한 구매 수량 값 가져오기 */
		var selectedAmount = $("#prodAmount").val();
		console.log("------ 구매 수량 : " + selectedAmount);
		
		/* 구매 수량 값을 form에 담기 */
		var prodAmount = "<input type='hidden' name='prodAmount' value='" + selectedAmount + "'>";
		console.log(prodAmount);
		$(".prodInfo").append(prodAmount);
		
		/* form submit */
		$(".prodInfo").submit();
	};
	
	/* 넘겨줄 CartDTO 값 */
	var userid = '<c:out value="${pinfo.username}"/>';
	var pno = '${product.pno}';
	var image = '${product.image}';
	var pname = '${product.pname}';
	var price = '${product.price}';
	
	
	// 장바구니 담기
	function addCart(){
		
		var amount = $("#prodAmount").val();
		
		$.ajax({
			type: "POST",
			url: "/product/addCart",
			data: {"userid" : userid, "pno" : pno, "image" : image, "pname" : pname, "price" : price, "amount" : amount},
			dataType: "json",
			error: function(){},
			success : function(result){
				if(result == 1) {
					alert("상품이 장바구니에 담겼습니다.");
				}else if(result == 0){
					alert("장바구니 담기 실패");
				}
			}
		});
	};
	
</script>

<sec:authentication property="principal" var="pinfo"/>

<div>
	<h1 style="text-align: center;">ProductDetail</h1>
</div>

<div>	
	
	<div>
	
		<div style="float: left; margin: 0px 0px 0px 125px;">
			<img src='/resources/image/<c:out value="${product.image}"/>.jpg' style="width: 410px; height: 410px;">
		</div>
		
		<div class="p_detail">
			<div class="p_name">
				<a><c:out value="${product.pname}"/></a>
			<div class="p_replyCnt">
				<img src="/resources/score/<c:out value="${score}"/>.png" style="width: 170px; height: 40px;"></br>
				<a style="position: relative; left: 2%; top:4px; "><c:out value="${product.replyCnt}"/>개 상품평</a>
			</div>
			</div>
			<div class="p_price">
				<fmt:formatNumber value="${product.price }" pattern="###,###" />
				<a style="font-size: 15px;">원</a>
			</div>
			<div class="p_stock">
				<a>무료배송(20,000원 이상 구매 시)</a></br>
				<a style="font-size: 15px;">그 외 배송비 5,000원</a>
			</div>
			<!-- 장바구니 관련 -->
			<div> 
				<select id="prodAmount" style="padding: 4px 0px 0px 0px; height: 42px;">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
				</select>
				
				<sec:authorize access="!isAuthenticated()">
                     <button class="prod-cart-btn" type="button" id="cart_btn" onclick="goLogin()">장바구니 담기</button>
                   <button class="prod-buy-btn" type="button" onclick="goLogin()">바로구매 ></button>
               </sec:authorize>
               <sec:authorize access="isAuthenticated()">
                     <button class="prod-cart-btn" type="button" id="cart_btn" onclick="addCart()">장바구니 담기</button>
                   <button class="prod-buy-btn" type="button" onclick="goPayment()">바로구매 ></button>
               </sec:authorize>
		        
			</div>
			<div>
		        <button class="prod-list-btn" data-oper="list">목록</button>
		       <sec:authorize access="isAuthenticated()">
               <sec:authentication property="principal" var="pinfo" />
               <c:if test="${pinfo.username eq 'admin01'}">
                           <button class="modify-btn" data-oper="modify">수정</button>
               </c:if>
               </sec:authorize>
			</div>
		</div>	
	</div>	
	
	<!-- 결제 페이지 및 장바구니 페이지에 넘길 form -->
	<form action="/product/payment" method="post" class="prodInfo">
		<input type="hidden" name="pno" value="${product.pno}">
	</form>
	
	<div style="padding: 100px 0px 0px 0px; text-align: center; margin: 0px 0px 0px 100px;">
		<table>
			<tbody style="border-top: 1px solid #eee; border-bottom: 1px solid #eee;">
		        <tr>
		            <th>품명 및 모델명</th>
		            <td>컨텐츠 참조</td>
		            <th>크기, 중량</th>
		            <td>컨텐츠 참조</td>
		        </tr>
		        <tr>
		        	<th>색상</th>
		            <td>컨텐츠 참조</td>
		            <th>재질</th>
		            <td>컨텐츠 참조</td>
		        </tr>
		        <tr>
		        	<th>제품 구성</th>
		            <td>컨텐츠 참조</td>
		            <th>출시년월</th>
		            <td>컨텐츠 참조</td>
		        </tr>
		        <tr>
		        	<th>제조자(수입자)</th>
		            <td>컨텐츠 참조</td>
		            <th>제조국</th>
		            <td>컨텐츠 참조</td>
		        </tr>
		        <tr>
		        	<th>Tram 상품번호</th>
		            <td colspan="3"><c:out value="${product.pno}"></c:out> </td>
		        </tr>
		        <tr>
		        	<th>상품별 세부 사양</th>
		            <td colspan="3">컨텐츠 참조</td>
		        </tr>
		        <tr>    
		            <th>품질보증기준</th>
		            <td colspan="3">제품 이상 시 공정거래위원회 고시 소비자분쟁해결기준에 의거 보상합니다.</td>
		        </tr>
		        <tr>
		        	<th>A/S 책임자와 전화번호</th>
		        	<td colspan="3">Tram고객센터 1234-5678</td>
		        </tr>
			</tbody>
        </table>
	</div>
	
		<!-- 본문 이미지 보여주는 부분  -->
		<div class="inputArea">
			<img src='<c:out value="${product.p_Img}"/>'>
		</div>
		
	<form id="operForm" action="/product/modify" method="get" >
		<input id="pno" type="hidden" name="pno" value='<c:out value="${product.pno }"/>' />
		<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>' />
		<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>' />
		<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>' />
		<input type="hidden" name="type" value='<c:out value="${cri.type}"/>' />
		<input type="hidden" name="catenum" value='<c:out value="${cri.catenum }"/>'/>
	</form>
	
	<div class="dag">
	
	<button type="button" name="button" class="ac-sub-go-top">위로</button>
	
		<p style="position: relative; left: 3.5%; top:20px; font-weight: bold;">Review</p>
	</div>
		<ul class="chat">
			<li class="left clearfix" data-rno="12">
			</li>
		</ul>
	
	<!-- Modal -->
	<div class="modal fade" id="MyModal" tabindex="-1" role="dialog"
	   aria-labelledby="myModalLabel" aria-hidden="true">
	   <div class="modal-dialog">
	      <div class="modal-content">
	         <div class="modal-header">
	            <button type="button" class="close" data-dismiss="modal"
	               ari-hidden = "true">&times;</button>
	            <h4 class="modal-title" id="myModalLabel">새 리뷰 등록</h4>
	         </div>
	         <div class="modal-body">
	            <div>
	               <label>Review</label>
	            </div>
	            <div>
	               <input class="form-control" name='reply' value='New Reply!!!!' onfocus="this.placeholder=''" onblur="this.placeholder='리뷰의 내용을 입력해주세요'" placeholder="리뷰의 내용을 입력해주세요">
	            </div>
	         </div>
	         <div class = "modal-footer">
	            <button id='modalModBtn' type = "button" class = "btn btn-warning">수정</button>
	            <button id='modalRemoveBtn' type = "button" class = "btn btn-danger">삭제</button>
	            <button id='modalRegisterBtn' type = "button" class = "btn btn-primary">등록</button>
	            <button id='modalCloseBtn' type = "button" class = "btn btn-default">취소</button>
	         </div>
	      </div>
	   </div>
	</div>
	
</div> 

<script type="text/javascript" src="/resources/js/p_reply.js"></script>
<script type="text/javascript" src="/resources/js/util.js"></script>
<!-- 위로가기 버튼  -->
<script type="text/javascript">
	$(window).scroll(function () {
	    var quickHeight=$(document).scrollTop(); //스크롤 높이가 1000 이상이면 나타나기
	    if (1000 <= quickHeight ) {
	      $('.ac-sub-go-top').css('display','block');
	     }else {
	       $('.ac-sub-go-top').css('display','none');
	     }
	   });
	
	   $('.ac-sub-go-top').click(function(){//위로가기 버튼을 클릭했을때
	     $('html, body').animate({
	       scrollTop: '0'
	     }, 1000);
	   });
</script>
<script type="text/javascript">
	$(function(){
		var operForm = $("#operForm");
		
		// 수정 화면으로 이동하는 버튼 클릭 이벤트
		$("button[data-oper='modify']").click(function(e){
			operForm.attr("action", "/product/modify");
			operForm.submit();
		});
		
		// 리스트(목록)으로 이동하는 버튼 클릭 이벤트
		$("button[data-oper='list']").click(function(e){
			operForm.find("#bno").remove();
			operForm.attr("action", "/product/list");
			operForm.submit();
		});
	});
</script>

<script type="text/javascript"><!-- 댓글 처리 스크립트 -->
	console.log("--------------------");
	
	var pnoValue = '<c:out value="${product.pno}"/>';
	
	var replyUL = $(".chat");
	
	// 데이터 불러와서 댓글 처리해주기
	showList(1);
	function showList(page){
		// replyService 에서 리스트를 가져오고
		// html 코드를 작성
		
		replyService.getList({pno:pnoValue, page:page || 1},
			function(list){
				var str = "";
				
				if(list == null || list.length==0){
					// 댓글 목록이 없는 경우
					replyUL.html("");
					
					return;
				}
				
				var score;
				
				/* 리뷰 작성자가 매겼던 별점 가져오기 */
				function getScore(i){
					var pno = '${product.pno}';
					$.ajax({
						type: "GET",
						url: "/reply/getScore",
						async: false,
						data: {"pno" : pno, "userid" : list[i].replyer},
						dataType: "json",
						error: function(){},
						success : function(result){
							console.log(result);
							score = result;
						}
					});
					console.log(score);
				}
				for(var i=0; i<list.length; i++){
					str += '<li class="left clearfix" data-rno="' + list[i].rno + '">';
					str += '<div>';
					str += '<div class="header">';
					str += '<strong class="primary-font">' + list[i].replyer + '</strong></br>';
					getScore(i)
					str += '<img src="/resources/score/' + score + '.png" style="width: 100px; height: 20px; position:relative; left:-3px;">';
					score = "";
					str += '<small class="pull-right text-muted">' + displayTime(list[i].replyDate) + '</small>';
					str += '</div>';
					str += '<p>' + list[i].reply + '</p>';
					str += '</div>';
					str += '</li>';
				}
				replyUL.html(str);
			}
		);
	}
	
	// 모달 창 관련 스크립트
	var modal = $(".modal");
	var modalModBtn = $("#modalModBtn");			// 댓글 수정 버튼
	var modalRemoveBtn = $("#modalRemoveBtn");		// 댓글 삭제 버튼
	var modalRegisterBtn = $("#modalRegisterBtn");	// 댓글 등록 버튼
	
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplyer = modal.find("input[name='replyer']");
	var modalInputReplyDate = modal.find("input[name='replyDate']");
	
	
	/* get.jsp에서 리뷰 작성 못하게 해야 하므로 주석 처리 */
	/* $("#addReplyBtn").click(function(){
		modal.find("input").val("");
		modalInputReplyDate.closest("div").hide();
		
		
		// 추가 할 내용 - - - - - - - - - - -
		modalRegisterBtn.show();		// 등록 버튼 보이기
		modalModBtn.hide();				// 수정 버튼 숨기기
		modalRemoveBtn.hide();			// 삭제 버튼 숨기기
		
		modalInputReplyer.removeAttr("readonly");
		
		$(".modal").modal("show");
	}); */
	
	// 취소 버튼 클릭 이벤트 --- 모달 창 숨김
	$("#modalCloseBtn").click(function(){
		$(".modal").modal("hide");
	});
	
	// 댓글 등록 버튼 클릭 이벤트 --- 데이터 삽입
	modalRegisterBtn.click(function(){
		
		var reply = {
				reply : modalInputReply.val(),
				replyer : modalInputReplyer.val(),
				pno : pnoValue
		};
		
		replyService.add(reply, function(result){
			alert(result);
			
			modal.modal("hide");
			showList(1);	// 댓글 창 불러오는 함수 재 실행
		});
		
	});
	
	// 각 댓글들 클릭 이벤트(조회)
/* 	var rno;	// 범위적으로 사용하기 위해 전역 변수 선언
	$(".chat").on("click", "li", function(){
		rno = $(this).data("rno");	// data-rno 속성에 담긴(rno) 가져오기
		
		// get 함수를 이용해서 ajax 실행
		replyService.get(rno, function(reply){
			modalInputReply.val(reply.reply);
			modalInputReplyer.val(reply.replyer).attr("readonly","readonly");
			modalInputReplyDate.val(displayTime(reply.replyDate)).attr("readonly","readonly");
			
			modalInputReplyDate.closest("div").show();
			
			modalRegisterBtn.hide();
			modalModBtn.show();
			modalRemoveBtn.show();
			
			$(".modal").modal("show");
		});
	}); */
	
	
	// 수정 버튼 클릭
	modalModBtn.click(function(){
		var reply = {rno:rno, reply:modalInputReply.val()};
		
		replyService.update(reply, function(result){
			alert(result);
			
			modal.modal("hide");
			showList(1);
		});
	});
	
	// 삭제 버튼 클릭
	modalRemoveBtn.click(function(){
		
		replyService.remove(rno, function(result){
			alert(result);
			modal.modal("hide");
			showList(1);
		});
		
	});
</script>
<%@include file="../include/footer.jsp" %>