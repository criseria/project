<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="/resources/p_registerpage.css">
<link rel="stylesheet" href="/resources/button.css">

	<div style="text-align: center;">
		<h1>상품 등록하기</h1>
	</div>

		<div>
			<div class="register-all">
				<form action="/product/register" method="post" role="form" enctype="multipart/form-data">
					<div class="register-content">
						<label class="register-cate">카테고리</label>
						<select name="catenum" style="position: relative;  top: 1px;">
							<option value="100">여행아이템</option>
							<option value="200">관광지티켓</option>
							<option value="300">인싸아이템</option>
						</select>
					</div>
					<div class="register-content">
						<label class="register-title">상품 제목</label>
						<input name="pname" placeholder="상품의 제목을 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='상품의 제목을 입력해주세요.'" style="position: relative; width : 73%; border:none; top: 2px;">
					</div>
					<div class="register-content">
						<label class="register-price">가격</label>
						<input name="price" placeholder="상품의 가격을 입력해주세요" onfocus="this.placeholder=''" onblur="this.placeholder='상품의 가격을 입력해주세요.'" style="position: relative; width: 73%; border: none; top: 2px;">
					</div>
					<div style="height: 31px; background-color : #EEE;">
						<label style="position: relative; left: 48%; top: 15%; font-weight : bold;">상품 설명</label>
					</div>
					<div>
						<textarea placeholder="상품에 관한 내용을 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='상품에 관한 내용을 입력해주세요.'" class="textbox" rows="3" name="pcontent"></textarea>
					</div>
					<div class="register-content">
						<label class="register-p-img">상품 대표 이미지</label>
						<input placeholder="상품의 대표 이미지를 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='상품의 대표 이미지를 입력해주세요.'" type="text" name="image" style="position: relative; width: 73%; border : none; top: 2px;">
					</div>
					<div>
						<div style="border-bottom: 1px solid black; background-color : #EEE;">
							<label for="gdsImg" style="position: relative; left: 41%; font-weight : bold;">상품 설명 이미지</label></br>
						</div>
						<input type="file" id="gdsImg" name="file" />
						<div class="select_img"><img style="position: relative; left: 20%;" src="" /></div>
					 
						<script>
						 $("#gdsImg").change(function(){
						 	if(this.files && this.files[0]) {
						  		var reader = new FileReader;
						   		reader.onload = function(data) {
						   			$(".select_img img").attr("src", data.target.result).width(500);        
						   		}
						   		reader.readAsDataURL(this.files[0]);
						  	}
						 });
						</script>
						<div style="border-top: 1px solid black; background-color : #EEE;">
							<label style="position: relative; left: 36%; color: red; font-weight : bold; top: 4px; ">★업로드시 저장되는 경로★</label></br>
							<div style="position: relative; top: 10px; border-top: 1px solid black; background-color : white;">
								<%=request.getRealPath("/") %>
							</div>
						</div>
						
					</div>
				</form>
			</div>
					<button type="submit" data-oper="register" class="save-btn">작성완료</button>
					<button type="submit" data-oper="list" class="register_list-btn">목록</button>
					
					<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
					<input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
					<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>' />
					<input type="hidden" name="type" value='<c:out value="${cri.type}"/>' />
					<input type="hidden" name="catenum" value="<c:out value="${cri.catenum }"/>"/>
		</div>
	
<script type="text/javascript">
	$(function(){
		//위에 버튼에 따라서 다른 동작을 할 수 있도록 수정해야된다.
		var formObj = $("form");	// form 객체 받아오기
		
		$("button").click(function(e){	// 버튼 클릭 이벤트
			// * 버튼 타입 클릭시 submit() 이벤트와 click()이벤트 동시 진행이기 때문에
			// e.preventDefault() 메소드를 이용하여 기존에 설정된 이벤트 해제(submit)
			e.preventDefault();
			
			// data-oper 속성 받아오기(modify or remove or list)
			var operation = $(this).data("oper");
			
			if(operation === 'register'){
				// 기존에 작성된 post 방식으로 전달해야 돼서 속성값을 바꿔준다. 
				formObj.attr("action", "/product/register");
			}else if(operation === 'list'){
				// 목록 화면으로 가기위한 속성 변경
				formObj.attr("action", "/product/list");
				formObj.attr("method", "get");
				
				// 목록 화면에서 사용할 데이터 객체 임시 저장
				var pageNumTag = $("input[name=pageNum]").clone();
				var amountTag = $("input[name=amount]").clone();
				
				formObj.empty();	// form 객체 내부를 비워준다.
				formObj.append(pageNumTag);	// pageNum 태그 추가
				formObj.append(amountTag);	// amountNum 태그 추가
			}
			
			// form 태그 전송(register or remove)
			formObj.submit();
		});
	});
</script>

<script type="text/javascript">
	$(function(){
		//위에 버튼에 따라서 다른 동작을 할 수 있도록 수정해야된다.
		var formObj = $("form");	// form 객체 받아오기
		
		$("button").click(function(e){	// 버튼 클릭 이벤트
			// * 버튼 타입 클릭시 submit() 이벤트와 click()이벤트 동시 진행이기 때문에
			// e.preventDefault() 메소드를 이용하여 기존에 설정된 이벤트 해제(submit)
			e.preventDefault();
			
			// data-oper 속성 받아오기(modify or remove or list)
			var operation = $(this).data("oper");
			
			if(operation === 'register'){
				// 기존에 작성된 post 방식으로 전달해야 돼서 속성값을 바꿔준다. 
				formObj.attr("action", "/product/register");
			}else if(operation === 'list'){
				// 목록 화면으로 가기위한 속성 변경
				formObj.attr("action", "/product/list");
				formObj.attr("method", "get");
				
				// 목록 화면에서 사용할 데이터 객체 임시 저장
				var pageNumTag = $("input[name=pageNum]").clone();
				var amountTag = $("input[name=amount]").clone();
				
				formObj.empty();	// form 객체 내부를 비워준다.
				formObj.append(pageNumTag);	// pageNum 태그 추가
				formObj.append(amountTag);	// amountNum 태그 추가
			}
			
			// form 태그 전송(register or remove)
			formObj.submit();
		});
	});
</script>
<%@include file="../include/footer.jsp" %>