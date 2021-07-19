<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="/resources/p_modifypage.css">
<link rel="stylesheet" href="/resources/button.css">

		<div>
			<h1 style="text-align: center;">상품 수정 및 삭제 화면</h1>
		</div>

		<div class="modify-all">
			<form action="/product/modify" method="post" role="form" enctype="multipart/form-data">
				<div class="modify-content">
					<label class="modify-pno">상품 번호</label>
					<input style="position: relative; width : 72%; border:none; top: 2px;" name="pno" value='<c:out value="${product.pno}"/>' readonly="readonly">
				</div>
				<div class="modify-content">
					<label class="modify-cate">현재 카테고리 번호</label>
					<input style="position: relative; width : 72%; border:none; top: 2px;" value='<c:out value="${product.catenum}"/>' readonly="readonly" ></br>
				</div>
				<div class="modify-content">
					<label class="modify-new-cate">수정 할 카테고리 번호</label>
					<select name="catenum" style="position: relative;  top: 1px;">
						<option value="100">여행아이템</option>
						<option value="200">관광지티켓</option>
						<option value="300">인싸아이템</option>
					</select>
				</div>
				<div class="modify-content">
					<label class="modify-title">상품 제목</label>
					<input style="position: relative; width : 72%; border:none; top: 2px;" name="pname" value='<c:out value="${product.pname}"/>'>
				</div>
				<div class="modify-content">
					<label class="modify-price">가격</label>
					<input style="position: relative; width : 72%; border:none; top: 2px;" name="price" value='<c:out value="${product.price}"/>'>
				</div>
				<div style="height: 31px; background-color : #EEE;">
					<label style="position: relative; left: 45.5%; top: 15%; font-weight : bold;">상품 설명</label>
				</div>
				<div>
					<textarea class="textbox" name="pcontent" rows="3"><c:out value="${product.pcontent }"/></textarea>
				</div>
				<div class="modify-content">
					<label class="modify-p-img">상품 대표 이미지</label>
					<input style="position: relative; width : 72%; border:none; top: 2px;" type="text" name="image" value='<c:out value="${product.image}"/>'>
				</div>
				<div>
					<div style="border-bottom: 1px solid black; background-color : #EEE;">
						<label style="position: relative; left: 42.5%; font-weight : bold;" for="gdsImg">상품 설명 이미지</label></br>
					</div>
					<input type="file" id="gdsImg" name="file" />
					<div class="select_img">
						<img style="position: relative; left: 2.8%;" src='<c:out value="${product.p_Img}"/>'>
						<input type="hidden" name="gdsImg" value="${product.p_Img}" />
	  					<input type="hidden" name="gdsThumbImg" value="${product.PThumbImg}" /> 
					</div>
				 
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

			<div>
				<input type="hidden" class="form-control" name="regDate" value='<c:out value="${product.regdate }"/>' readonly="readonly">
				<button type="submit" data-oper="modify" class="modify-complete">수정 완료</button>
				<button type="submit" data-oper="remove" class="delete-btn">상품 삭제</button>
				<button type="submit" data-oper="list" class="modify_list-btn">목록</button>
				
				<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
				<input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
				<input type="hidden" name="type" value="<c:out value="${cri.type}"/>">
				<input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
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
			
			if(operation === 'remove'){
				// 기존에 작성된 post 방식으로 전달해야 돼서 속성값을 바꿔준다. 
				formObj.attr("action", "/product/remove");
			}else if(operation === 'list'){
				// 목록 화면으로 가기위한 속성 변경
				formObj.attr("action", "/product/list");
				formObj.attr("method", "get");
				
				// 목록 화면에서 사용할 데이터 객체 임시 저장
				var pageNumTag = $("input[name=pageNum]").clone();
				var amountTag = $("input[name=amount]").clone();
				var keywordTag = $("input[name=keyword]").clone();
				var typeTag = $("input[name=type]").clone();
				
				formObj.empty();	// form 객체 내부를 비워준다.
				
				formObj.append(pageNumTag);	// pageNum 태그 추가
				formObj.append(amountTag);	// amountNum 태그 추가
				formObj.append(keywordTag);
				formObj.append(typeTag);
				
			}else if(operation === 'modify'){
				var str = '';
				
				$(".uploadResult ul li").each(function(i, obj){
					var jobj = $(obj);
					str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"' />";
					str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"' />";
					str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"' />";
					str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"' />";
				});
				formObj.append(str);
			}
			
			// form 태그 전송(modify or remove)
			formObj.submit();
		});
	});
</script>

<%@include file="../include/footer.jsp" %>