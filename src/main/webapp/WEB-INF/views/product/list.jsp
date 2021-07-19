<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<link rel="stylesheet" href="/resources/p_listpage.css">
<link rel="stylesheet" href="/resources/button.css">



	<!-- 맨 위 배너부분 -->
	<div class="banner">
		<a target="_blank" href="https://korean.visitkorea.or.kr/list/user_cos.do"><img src="/resources/image/banner.gif" style="width: 1100px;"></a>
	</div>
	<div class="navi">
		<span class="main"><a href="/main">홈</a></span>
		<span class="step"><a href="/product/list?pageNum=1&amount=6">상품 구매</a></span>
	</div>
	<div>
		<!-- 카테고리 부분 -->
		<div style="width: 1100px; height: auto; margin: 20px 0px 0px 0px;">
			<div class="category">
				<ul style="position: relative; left: 10%;">
					<li>
						<a href="/product/list?pageNum1&amount=9&catenum=0">전체</a>
					</li>
						<c:forEach items="${category}" var="category" >
						<li>
							<a href='/product/list?pageNum1&amount=9&catenum=<c:out value="${category.catenum}"/>'><c:out value="${category.catename}"/></a>
						</li>
						</c:forEach>
				</ul>
				
			<sec:authorize access="isAuthenticated()">
		        <sec:authentication property="principal" var="pinfo" />
		            <c:if test="${pinfo.username eq 'admin01'}">
		               <div class="list_head">
		                  <button class="prod-new-btn" id="regBtn">상품등록하기</button>
		               </div>
		            </c:if>
      		</sec:authorize>
			</div>
			
			<div class="pro">
				<c:forEach var="product" items="${list}">
					<div class="product">
							<a class="move" href='<c:out value="${product.pno}"/>' style="font-size: 15px;">
								<img src='/resources/image/<c:out value="${product.image}"/>.jpg' style="width: 265px; height: 300px;"></br>
								<div style="margin: 0px 0px 0px 7px; width: 100%;">
									<label style="font-size : 17px; text-decoration: none; color: black;">
										<c:out value="${product.pname}"/> </br>
									</label>
									<strong style="font-size: 20px; color: #ae0000;">
										<label>
											<fmt:formatNumber value="${product.price }" pattern="###,###" />
										</label>
										<label style="font-size: 15px; color: #ae0000;">원</label></br>
									</strong>
									<label>
										<c:out value="${product.replyCnt}"/>개의 상품평</br>
									</label>
									<label>
										<fmt:formatDate value="${product.regdate}" pattern="yyyy-MM-dd"/>
									</label>
								
								</div>
							</a>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>		
	
	<div class="search">
		<form id="searchForm" action="/product/list" method="get" style="text-align: right; padding: 0px 15px 0px 0px;">
			<select name="type" style="position: relative; top:-17px; padding-top: 10px; padding-bottom: 10px;">
				<option value=""
					<c:out value="${pageMaker.cri.type == null?'selected' : '' }"/>>--</option>
				<option value="T"
					<c:out value="${pageMaker.cri.type eq 'T'?'selected' : '' }"/>>제목</option>	
				<option value="C"
					<c:out value="${pageMaker.cri.type eq 'C'?'selected' : '' }"/>>내용</option>	
				<option value="TC"
					<c:out value="${pageMaker.cri.type eq 'TC'?'selected' : '' }"/>>제목 or 내용</option>	
			</select>
			<input type="text" name="keyword" style="position: relative; top:-17px; padding-top: 10px; padding-bottom: 10px; 
			padding-left: 10px; padding-right: 20px;" value='<c:out value="${pageMaker.cri.keyword}"/>' />
			<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>' /> 
			<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>' /> 
			<input type="hidden" name="catenum" value="<c:out value="${pageMaker.cri.catenum}"/>"/>
			<button class="search-btn"><img src="/resources/icon/search_button.png"></button>
		</form>
	</div>
	
	<!-- page -->
	<div style="text-align: center;">
		<ul class="pagination">
			<c:if test="${pageMaker.prev}">
				<li class="paginate_button previous">
					<a href="${pageMaker.startPage-1}">&lt;</a>
				</li>
			</c:if>
			<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage }" step="1">
				<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : ''}">
					<a href="${num}">${num}</a>
				</li>
			</c:forEach>
			<c:if test="${pageMaker.next}">
				<li class="paginate_button">
					<a href="${pageMaker.endPage+1}">&gt;</a>
				</li>
			</c:if>
		</ul>
	</div>
	
	<div>			
		<form id="actionForm" action="/product/list" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="type" value="<c:out value="${pageMaker.cri.type }"/>">
			<input type="hidden" name="keyword" value="<c:out value="${pageMaker.cri.keyword }"/>">
			<input type="hidden" name="catenum" value="<c:out value="${pageMaker.cri.catenum }"/>"/>
		</form>
	</div>

<script type="text/javascript">
	$(function(){
		
		//----------------- 새 게시글 화면 이동을 위한 코드-------------------
		$("#regBtn").click(function(){
			actionForm.attr("action", "/product/register");
			actionForm.submit();
		});
		
		//----------------- 알림 이벤트 코드-------------------
		// 결과창 출력을 위한 코드
		var result = '<c:out value="${result}"/>';
		
		// rttr 객체를 통해 받아온 값이 빈 값이 아닐 때(데이터 변경) 알림 메소드 실행
		if(result != ''){
			checkResult(result);
		}
		// 뒤로가기 할 때 문제가 될 수 있으므로
		// history  객체를 조작({정보를 담은 객체}, 뒤로가기 버튼 문자열 형태의 제목, 바꿀 url)
		history.replaceState({},null,null);	
		function checkResult(result){
			if(result === '' || history.state){	// 뒤로가기 방지
				return;
			}
			if(result === 'success'){	// 수정 및 삭제
				alert("처리가 완료되었습니다.");
				return;
			}
			if(parseInt(result) > 0){	// 삽입
				alert("게시글 " + parseInt(result) + "번이 등록되었습니다.");
			}
		}
		
		//----------------- 페이징 이벤트 코드-------------------
		var actionForm = $("#actionForm");
		
		$(".paginate_button a").click(function(e){
			// <a> 클릭 시 페이지 이동이 이루어지지 않게 하기 위해
			// 기존(디폴트) 이벤트 해제
			e.preventDefault();
			
			// $(this) 의 요소 중 'href'의 속성 값(value)을 input태그의 name속성 값이 pageNum인
			// 요소에 값으로 집어 넣는다.
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		//----------------- 조회 화면 이동 이벤트 코드-------------------
		$(".move").click(function(e){
			e.preventDefault();
			
			// <form> 에 추가
			var value = $(this).attr("href");
			
			actionForm.append("<input type='hidden' name='pno' value='" + value + "'>");
			actionForm.attr("action", "/product/get");
			actionForm.submit();
		});
		
		// 검색 버튼의 이벤트 처리
		var searchForm = $("#searchForm");
		
		$("#searchForm button").on("click", function(e) {
			
			if(!searchForm.find("option:selected").val()) {
				alert("검색종류를 선택하세요");
				return false;
			}
			
			if(!searchForm.find("input[name='keyword']").val()) {
				alert("키워드를 선택하세요");
				return false;
			}
			
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			
			searchForm.submit();
		});
	});
</script>

<%@ include file="../include/footer.jsp" %>