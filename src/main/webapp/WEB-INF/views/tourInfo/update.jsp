<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<link rel="stylesheet" href="/resources/tourPageUpdate.css">

<div style="text-align: center;">
	<h1>여행지 상세페이지 수정</h1>
</div>
<div>
	<form action="/tourInfo/update" method="post">
		<div class="update-all">
			<div class="update-content">
				<label class="update-no">tou_no</label> <input name='tou_no'
					value="${tourInfo.tou_no }">
			</div>
			<div class="update-content">
				<label class="update-loc">지역번호</label> <select name="loc_no">
					<option value="1">서울</option>
					<option value="2">경기</option>
					<option value="3">충청도</option>
					<option value="4">강원도</option>
					<option value="5">전라도</option>
					<option value="6">경상도</option>
					<option value="7">제주도</option>
				</select>
			</div>
			<div class="update-content">
				<label class="update-title">글 제목</label> <input name='tou_title'
					value="${tourInfo.tou_title}">
			</div>
			<div class="update-content">
				<label class="update-name">여행지 명</label> <input name='tou_name'
					value="${tourInfo.tou_name}">
			</div>
			<div class="update-content">
				<label class="update-addr">여행지 주소</label> <input name='tou_addr'
					value="${tourInfo.tou_addr }">
			</div>
			<div style="height: 31px; background-color: #EEE;">
				<label style="position: relative; left: 44%; top: 15%; font-weight: bold;">여행지 소개글</label>
			</div>
			<div> 
				<textarea name='tou_content' class="textbox" rows="3">${tourInfo.tou_content }</textarea>
			</div>
			<div class="update-content">
				<label class="update-lat">여행지 위도</label> <input name='tou_lat'
					value="${tourInfo.tou_lat }">
			</div>
			<div class="update-content">
				<label class="update-lng">여행지 경도</label> <input name='tou_lng'
					value="${tourInfo.tou_lng }">
			</div>
			<div class="update-content">
				<label class="update-image">여행지 이미지</label> <input name='tou_image'
					value="${tourInfo.tou_image }">
			</div>
			<div class="update-content">
				<label class="update-image2">상세 이미지</label> <input name='tou_image2'
					value="${tourInfo.tou_image2 }">
			</div>
			<div class="update-content">
				<label class="update-image3">주차정보 이미지</label> <input name='tou_image3'
					value="${tourInfo.tou_image3 }">
			</div>
			<div class="update-content">
				<label class="update-time">관람시간</label> <input name="tou_time"
					value="${tourInfo.tou_time }">
			</div>
			<div class="update-content">
				<label class="update-homepage">홈페이지</label> <input
					name="tou_homepage" value="${tourInfo.tou_homepage }">
			</div>
			<div class="update-content">
				<label class="update-inter">관심사</label> <select name="tou_inter">
					<option value="역사">역사</option>
					<option value="예술">예술</option>
					<option value="자연">자연</option>
					<option value="공원">공원</option>
				</select>
			</div>
			<div class="update-content">
				<label class="update-loc">지역이름</label> <select name="loc_name">
					<option value="서울">서울</option>
					<option value="경기">경기</option>
					<option value="충청도">충청도</option>
					<option value="강원도">강원도</option>
					<option value="전라도">전라도</option>
					<option value="경상도">경상도</option>
					<option value="제주도">제주도</option>
				</select>
			</div>
		</div>
		<button type="submit" data-oper='update' class="save-btn">수정</button>
		<button type="submit" data-oper='remove' class="save-btn">삭제</button>
		<button type="submit" data-oper='list' class="list-btn">목록</button>

		<input type="hidden" name="pageNum"
			value='<c:out value="${cri.pageNum }"/>'> <input
			type="hidden" name="amount" value='<c:out value="${cri.amount }"/>'>
		<input type="hidden" name="type" value=<c:out value="${cri.type}"/>>
		<input type="hidden" name="keyword"
			value=<c:out value="${cri.keyword}"/>> <input type="hidden"
			name="loc_no" value=<c:out value="${cri.loc_no}"/>>
	</form>
</div>



<script type="text/javascript">
	$(function() {

		var formObj = $("form");

		$("button").on("click", function(e) {
			e.preventDefault();

			var operation = $(this).data("oper");

			if (operation === 'remove') {
				formObj.attr("action", "/tourInfo/remove");
			} else if (operation === 'list') {
				formObj.attr("action", "/tourInfo/list").attr("method", "get");

				var pageNumTag = $("input[name=pageNum]").clone();
				var amountTag = $("input[name=amount]").clone();
				var typeTag = $("input[name='type']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				var loc_noTag = $("input[name='loc_no']").clone();

				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(typeTag);
				formObj.append(keywordTag);
				formObj.append(loc_noTag);
			}
			formObj.submit();
		});
	});
</script>
<%@ include file="../include/footer.jsp"%>