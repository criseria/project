<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<link rel="stylesheet" href="/resources/listpage.css">
<link rel="stylesheet" href="/resources/button.css">

<div class="all">
		<div id="navigate-viewer">
			<span style="float: left; display: inline; margin: 0 0 5px 5px; font-weight: bold; font-size : 1.4em;">자유게시판</span>
			<div class="navi">
				<span class="main"><a href="/main">홈</a></span>
				<span class="step"><a href="/board/list?pageNum=1&amount=20">자유게시판</a></span>
			</div>
		</div>
		
		<div class='notice'>
			<dl>
				<dt>NOTICE</dt> 
				<dd>
					<ul>
						<li style=" margin: 0px 0px 10px 0px;">
							<a>
								<span>자유롭게 글을 올리시고 이야기하는 공간입니다. 경어체를 사용해 주시길 바라며, 자유로운 만큼 더욱 더 예절을 지켜주시기 바랍니다.</span></br>
							</a>
						</li>
						<li>
							<a>
								<span>자유게시판의 성격에 맞지 않거나, 광고성글, 타인에게 거부감을 주는 글은 임의 삭제/이동 조치 합니다.</span>
							</a>
						</li>
					</ul>
				</dd>
			</dl>
		</div>
		
		
		<div class="list-head">
			<sec:authorize access="!isAuthenticated()">
				<button class="btn_new" id="notAuth_reg">새 게시글 등록</button>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<button class="btn_new" id="regBtn">새 게시글 등록</button>
			</sec:authorize>
			<a class="TramFreeBoard-btn" href="/board/list?pageNum=1&amount=20">목록</a>
		</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<table>
					<thead>
						<tr>
							<th class="no">글번호</th>
							<th class="writer">작성자</th>
							<th class="subject">제목</th>
							<th class="date">작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="board" items="${list }">
							<tr>
								<td><c:out value="${board.bno}" /></td>
								<td>
									<sec:authorize access="!isAuthenticated()">
										<a class="notAuth_get" id="notAuth_get" href='/login/customLogin'>
											<c:out value="${board.title}"/> 
											<c:if test="${board.replycnt > 0 }">
												<b> [<c:out value="${board.replycnt }"/>]</b>
											</c:if>
										</a>
									</sec:authorize>
									<sec:authorize access="isAuthenticated()">
										<a class="move" href='<c:out value="${board.bno}"/>'>
											<c:out value="${board.title}"/> 
											<c:if test="${board.replycnt > 0 }">
												<b> [<c:out value="${board.replycnt }"/>]</b>
											</c:if>
										</a>
									</sec:authorize>
								</td>
								<td><c:out value="${board.writer}"></c:out></td>
								<td><fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<!-- 검색기능 추가부분 -->
				<div>
					<form id="searchForm" action="/board/list" method="get" style="text-align: right;">
						<select name="type" style="position: relative; top:-17px; padding-top: 10px; padding-bottom: 10px;">
							<option value="T"
								<c:out value="${pageMaker.cri.type eq 'T'?'selected' : '' }"/>>제목</option>	
							<option value="C"
								<c:out value="${pageMaker.cri.type eq 'C'?'selected' : '' }"/>>내용</option>	
							<option value="W"
								<c:out value="${pageMaker.cri.type eq 'W'?'selected' : '' }"/>>작성자</option>	
							<option value="TC"
								<c:out value="${pageMaker.cri.type eq 'TC'?'selected' : '' }"/>>제목 or 내용</option>	
							<option value="TW"
								<c:out value="${pageMaker.cri.type eq 'TW'?'selected' : '' }"/>>제목 or 작성자</option>		
							<option value="TWC"
								<c:out value="${pageMaker.cri.type eq 'TWC'?'selected' : '' }"/>>제목 or 내용 or 작성자</option>	
						</select>
						<input type="text" name="keyword" style="position: relative; top:-17px; padding-top: 10px; padding-bottom: 10px; padding-left: 10px; padding-right: 20px;" value='<c:out value="${pageMaker.cri.keyword}"/>' />
						<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>' /> 
						<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>' /> 
						<button class="search-btn"><img src="/resources/icon/search_button.png"></button>
					</form>
				</div>
				
				<!-- page -->
				<div class="pull-right">
					<ul class="pagination">
						<c:if test="${pageMaker.prev }">
							<li class="paginate_button previous">
								<a href="${pageMaker.startPage-1}">&lt;</a>
							</li>
						</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage }" step="1">
							<li class="paginate_button ${pageMaker.cri.pageNum == num ? 'active' : ''}">
								<a href="${num}">${num }</a>
							</li>
						</c:forEach>
						<c:if test="${pageMaker.next }">
							<li class="paginate_button">
								<a href="${pageMaker.endPage+1}">&gt;</a>
							</li>
						</c:if>
					</ul>
				</div>
				<form id="actionForm" action="/board/list" method="get">
					<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
					<input type="hidden" name="type" value="<c:out value="${pageMaker.cri.type }"/>">
					<input type="hidden" name="keyword" value="<c:out value="${pageMaker.cri.keyword }"/>">
				</form>
				<!-- /page -->
			</div>
			<!-- /.panel-body -->
		</div>

<script type="text/javascript">
	$(function(){
		
		//----------------- 새 게시글 화면 이동을 위한 코드-------------------
		$("#regBtn").click(function(){
			actionForm.attr("action", "/board/register");
			actionForm.submit();
		});
		
		//----------------- 로그인하지 않은 사용자는 로그인 페이지로 이동 -------------------
		// 게시글 등록 로그인 확인
		$("#notAuth_reg").click(function(){
			alert('로그인한 회원만 게시글 작성이 가능합니다.');
			var goLogin = confirm('로그인 페이지로 이동하시겠습니까?');
			if(goLogin == true){
				location.href = '/login/customLogin';
			}
		});
		// 게시글 열람 로그인 확인
		$(".notAuth_get").click(function(e){
			e.preventDefault();	// 기존 a태그의 href 동작 제거
			alert('로그인한 회원만 게시글 열람이 가능합니다.');
			var goLogin = confirm('로그인 페이지로 이동하시겠습니까?');
			if(goLogin == true){
				actionForm.attr("action", "/login/customLogin");
				actionForm.submit();
			}
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
			
			actionForm.append("<input type='hidden' name='bno' value='" + value + "'>");
			actionForm.attr("action", "/board/get");
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