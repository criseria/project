<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<link rel="stylesheet" href="/resources/tourPageList.css">
<sec:authentication property="principal" var="pinfo" />

<!-- 배너 -->
<div style="display: block;">
	<a target="_blank" href="https://www.jejudfs.com/promotion/planView?exhibitionId=1100"><img src="/resources/image/제주면세.PNG" style="width: 1100px; height: 175px;"></a>
</div>

<div id="navigate-viewer">
	<div class="navi">
		<span class="main"><a href="/main">홈</a></span>
		<c:choose>
			<c:when test="${pageMaker.cri.loc_no eq 0 }">
				<span class="step"><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=0">여행지소개</a></span>
			</c:when>
			<c:when test="${pageMaker.cri.loc_no eq 1 }">
				<span class="step"><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=0">여행지소개</a></span>
				<span class="step"><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=1">서울</a></span>
			</c:when>
			<c:when test="${pageMaker.cri.loc_no eq 2 }">
				<span class="step"><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=0">여행지소개</a></span>
				<span class="step"><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=2">경기</a></span>
			</c:when>
			<c:when test="${pageMaker.cri.loc_no eq 3 }">
				<span class="step"><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=0">여행지소개</a></span>
				<span class="step"><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=3">충청도</a></span>
			</c:when>
			<c:when test="${pageMaker.cri.loc_no eq 4 }">
				<span class="step"><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=0">여행지소개</a></span>
				<span class="step"><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=4">강원도</a></span>
			</c:when>
			<c:when test="${pageMaker.cri.loc_no eq 5 }">
				<span class="step"><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=0">여행지소개</a></span>
				<span class="step"><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=5">전라도</a></span>
			</c:when>
			<c:when test="${pageMaker.cri.loc_no eq 6 }">
				<span class="step"><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=0">여행지소개</a></span>
				<span class="step"><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=6">경상도</a></span>
			</c:when>
			<c:when test="${pageMaker.cri.loc_no eq 7 }">
				<span class="step"><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=0">여행지소개</a></span>
				<span class="step"><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=7">제주도</a></span>
			</c:when>
			<c:otherwise>
				<span class="step"><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=0">전체보기</a></span>
				<span class="step"><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=8">찜</a></span>
			</c:otherwise>
		</c:choose>
		
	</div>
</div>

<div>
<!-- 카테고리 -->
	<div class="tour_intro">
		<div>
			<ul>
				<li><a href="/tourInfo/list?pageNum=1&amount=9&loc_no=0">전체보기</a>
				</li>
				<c:forEach items="${cat }" var="cat">
					<li><a class="cate"
						href='/tourInfo/list?pageNum=1&amount=9&loc_no=<c:out value="${cat.loc_no }"/>'><c:out
								value="${cat.loc_name }" /></a></li>
				</c:forEach>
			</ul>
		</div>
		
		
		<c:if test="${pinfo.username eq 'admin01'}">
     	<div>
        	<button class="tour_btn" id="btn" type="button">여행지 등록</button>
      	</div>
      </c:if>
	
	</div>
	<div class="tour_main">
		<c:forEach items="${list}" var="tourInfo">
			<div class="tour_main03">
				<a class='move' href='<c:out value="${tourInfo.tou_no}" />'>
						<div>
							<img src='/resources/image/<c:out value="${tourInfo.tou_image}"/>'>
						</div>
						<div style="color: black; font-weight: bold; font-size: 20px; margin: 3px 0 3px 0;">
							<c:out value="${tourInfo.tou_name}" />
						</div>
						<div style="margin: 3px 0 3px 0; height: 60px;">
							<c:out value="${tourInfo.tou_title}" />
						</div>
				</a>
			</div>
		</c:forEach>
	</div>
</div>

<!-- 검색 -->
<div class="search">
	<form id='searchForm' action="/tourInfo/list" method="get" style="text-align: right; padding: 0px 15px 0px 0px;">
		<select name='type' style="position: relative; top:-17px; padding-top: 10px; padding-bottom: 10px;">
			<option value="T"
				<c:out value="${pageMaker.cri.type eq 'T'? 'selected':'' }"/>>제목</option>
			<option value="C"
				<c:out value="${pageMaker.cri.type eq 'C'? 'selected':'' }"/>>내용</option>
			<option value="N"
				<c:out value="${pageMaker.cri.type eq 'N'? 'selected':'' }"/>>여행지</option>
			<option value="TC"
				<c:out value="${pageMaker.cri.type eq 'TC'? 'selected':'' }"/>>제목
				or 내용</option>
			<option value="TN"
				<c:out value="${pageMaker.cri.type eq 'TN'? 'selected':'' }"/>>제목
				or 여행지</option>
			<option value="TCN"
				<c:out value="${pageMaker.cri.type eq 'TCN'? 'selected':'' }"/>>제목
				or 내용 or 여행지</option>
		</select> 
			<input type="text" name="keyword" style="position: relative; top:-17px; padding-top: 10px; padding-bottom: 10px; padding-left: 10px; padding-right: 20px;" value='<c:out value="${pageMaker.cri.keyword}"/>' /> 
			<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>' /> 
			<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>' /> 
			<input type="hidden" name="loc_no" value="<c:out value="${pageMaker.cri.loc_no }"/>" />
		<button class="btn btn-default search-btn"><img src="/resources/icon/search_button.png"></button>
	</form>
</div>

<!-- 페이징 -->
<div class="pull-right">
	<ul class="pagination">
		<c:if test="${pageMaker.prev }">
			<li class="paginate_button previous"><a
				href="${pageMaker.startPage-1}">&lt;</a></li>
		</c:if>
		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage }" step="1">
			<li
				class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : ''}">
				<a href="${num}">${num }</a>
			</li>
		</c:forEach>
		<c:if test="${pageMaker.next }">
			<li class="paginate_button"><a href="${pageMaker.endPage+1}">&gt;</a>
			</li>
		</c:if>
	</ul>
</div>

<form action="/tourInfo/list" method="get" id="actionForm">
	<input type="hidden" name="type" value=<c:out value="${pageMaker.cri.type}"/>> 
	<input type="hidden" name="keyword" value=<c:out value="${pageMaker.cri.keyword}"/>> 
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	<input type="hidden" name="loc_no" value="<c:out value="${pageMaker.cri.loc_no }"/>" /> 
	<input type="hidden" name="userid" value="<c:out value="${pinfo.username}"/>" />
	<input type="hidden" name="interest" value="<c:out value="${pageMaker.cri.interest}"/>" />
</form>


<script type="text/javascript">	
	$(function(){
		// 새 게시글 화면 이동을 위한 코드
		$("#btn").click(function(){
			actionForm.attr("action", "/tourInfo/register").submit();
		});
		
		
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
		
		//------------조회 화면 이동 이벤트 코드
		$(".move").click(function(e){
			e.preventDefault();
			
			// <form>에 추가
			var value = $(this).attr("href");
			actionForm.append("<input type='hidden' name='tou_no' value='"+ value + "'>");
			actionForm.attr("action", "/tourInfo/detail");
			actionForm.submit();
		});
	});
	
	var searchForm = $("#searchForm");
	   $("#searchForm button").on("click", function(e){
	      
	      
	      if(!searchForm.find("input[name='keyword']").val()){
	         alert("키워드를 입력해주세요");
	         return false;
	      }
	      
	      searchForm.find("input[name='pageNum']").val("1");
	      e.preventDefault();
	      
	      searchForm.submit();
	});
</script>

<%@ include file="../include/footer.jsp"%>