<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<link rel="stylesheet" href="/resources/tourPageRegister.css">


<div style="text-align: center;">
	<h1>여행지 소개글 등록</h1>
</div>

<div>
	<form action="/tourInfo/register" method="post" role="form">
		<div class="register-all">
			<div class="register-content">
				<label class="register-cate">지역번호</label> <select name="loc_no">
					<option value="1">서울</option>
					<option value="2">경기</option>
					<option value="3">충청도</option>
					<option value="4">강원도</option>
					<option value="5">전라도</option>
					<option value="6">경상도</option>
					<option value="7">제주도</option>
				</select>
			</div>
			<div class="register-content">
				<label class="register-title">제목</label> <input name="tou_title"
					placeholder="제목을 입력해주세요." onfocus="this.placeholder=''"
					onblur="this.placeholder='제목을 입력해주세요.'"
					style="position: relative; width: 73%; border: none; top: 2px;">
			</div>
			<div class="register-content">
				<label class="register-name">여행지명</label> <input name="tou_name"
					placeholder="여행지명을 입력해주세요." onfocus="this.placeholder=''"
					onblur="this.placeholder='여행지명을 입력해주세요.'"
					style="position: relative; width: 73%; border: none; top: 2px;">
			</div>
			<div class="register-content">
				<label class="register-add">여행지 주소</label> <input name="tou_addr"
					placeholder="주소를 입력해주세요." onfocus="this.placeholder=''"
					onblur="this.placeholder='주소를 입력해주세요.'"
					style="position: relative; width: 73%; border: none; top: 2px;">
			</div>
			<div style="height: 31px; background-color: #EEE;">
				<label
					style="position: relative; left: 44%; top: 15%; font-weight: bold;">여행지
					소개글</label>
			</div>
			<div>
				<textarea name="tou_content" placeholder="여행지 소개글을 입력해주세요."
					onfocus="this.placeholder=''"
					onblur="this.placeholder='여행지 소개글을 입력해주세요.'" class="textbox"
					rows="3" name="pcontent"></textarea>
			</div>
			<div class="register-content">
				<label class="register-lat">여행지 위도</label> <input name="tou_lat"
					placeholder="위도를 입력해주세요." onfocus="this.placeholder=''"
					onblur="this.placeholder='위도를 입력해주세요.'"
					style="position: relative; width: 73%; border: none; top: 2px;">
			</div>
			<div class="register-content">
				<label class="register-lng">여행지 경도</label> <input name="tou_lng"
					placeholder="경도를 입력해주세요." onfocus="this.placeholder=''"
					onblur="this.placeholder='경도를 입력해주세요.'"
					style="position: relative; width: 73%; border: none; top: 2px;">
			</div>
			<div class="register-content">
				<label class="register-img">여행지 이미지</label> <input type="file"
					name="tou_image" style="padding: 3px 1px 0px 2px; width: 200px;"
					multiple="multiple">
			</div>
			<div class="register-content">
				<label class="register-img2">상세 이미지</label> <input type="file"
					name="tou_image2" style="padding: 3px 1px 0px 2px; width: 200px;"
					multiple="multiple">
			</div>
			<div class="register-content">
				<label class="register-img3">주차정보 이미지</label> <input type="file"
					name="tou_image3" style="padding: 3px 1px 0px 2px; width: 200px;"
					multiple="multiple">
			</div>
			<div class="register-content">
				<label class="register-time">관람시간</label> <input name="tou_time"
					placeholder="관람시간을 입력해주세요." onfocus="this.placeholder=''"
					onblur="this.placeholder='관람시간을 입력해주세요.'"
					style="position: relative; width: 73%; border: none; top: 2px;">
			</div>
			<div class="register-content">
				<label class="register-homepage">홈페이지</label> <input
					name="tou_homepage" placeholder="홈페이지 주소를 입력해주세요."
					onfocus="this.placeholder=''"
					onblur="this.placeholder='홈페이지 주소를 입력해주세요.'"
					style="position: relative; width: 73%; border: none; top: 2px;">
			</div>
			<div class="register-content">
				<label class="register-inter">관심사</label> <select name="tou_inter">
					<option value="역사">역사</option>
					<option value="예술">예술</option>
					<option value="자연">자연</option>
					<option value="공원">공원</option>
				</select>
			</div>
			<div class="register-content">
				<label class="register-locname">지역이름</label> <select name="loc_name">
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
		<button type="submit" data-oper="register" class="save-btn">여행지
			등록</button>
		<button type="submit" data-oper="list" class="list-btn">목록</button>

		<input type="hidden" name="pageNum"
			value='<c:out value="${cri.pageNum}"/>' /> <input type="hidden"
			name="amount" value='<c:out value="${cri.amount}"/>' /> <input
			type="hidden" name="type" value=<c:out value="${cri.type}"/>>
		<input type="hidden" name="keyword"
			value=<c:out value="${cri.keyword}"/>>
	</form>

</div>

<script type="text/javascript">
	$(function() {
		//위에 버튼에 따라서 다른 동작을 할 수 있도록 수정해야된다.
		var formObj = $("form"); // form 객체 받아오기

		$("button").click(function(e) { // 버튼 클릭 이벤트
			// * 버튼 타입 클릭시 submit() 이벤트와 click()이벤트 동시 진행이기 때문에
			// e.preventDefault() 메소드를 이용하여 기존에 설정된 이벤트 해제(submit)
			e.preventDefault();

			// data-oper 속성 받아오기(modify or remove or list)
			var operation = $(this).data("oper");

			if (operation === 'register') {
				// 기존에 작성된 post 방식으로 전달해야 돼서 속성값을 바꿔준다. 
				formObj.attr("action", "/tourInfo/register");
			} else if (operation === 'list') {
				// 목록 화면으로 가기위한 속성 변경
				formObj.attr("action", "/tourInfo/list");
				formObj.attr("method", "get");

				// 목록 화면에서 사용할 데이터 객체 임시 저장
				var pageNumTag = $("input[name=pageNum]").clone();
				var amountTag = $("input[name=amount]").clone();
				var typeTag = $("input[name='type']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				var loc_noTag = $("input[name='loc_no']").clone();

				formObj.empty(); // form 객체 내부를 비워준다.
				formObj.append(pageNumTag); // pageNum 태그 추가
				formObj.append(amountTag); // amount 태그 추가
				formObj.append(typeTag);
				formObj.append(keywordTag);
			}

			// form 태그 전송(register)
			formObj.submit();
		});
	});
</script>
<script type="text/javascript">
<!-- 파일 업로드 스크립트 -->
	$(function() {
		var formObj = $("form[role='form']");
		$("button[type='submit']").click(
				function(e) {
					e.preventDefault();
					var str = '';

					$(".uploadResult ul li").each(
							function(i, obj) {
								var jobj = $(obj);

								str += "<input type='hidden' name='attachList["
										+ i + "].tou_image' value='"
										+ jobj.data("tou_image") + "' />";
								str += "<input type='hidden' name='attachList["
										+ i + "].uuid' value='"
										+ jobj.data("uuid") + "' />";
								str += "<input type='hidden' name='attachList["
										+ i + "].uploadPath' value='"
										+ jobj.data("path") + "' />";
								str += "<input type='hidden' name='attachList["
										+ i + "].fileType' value='"
										+ jobj.data("type") + "' />";

							});

					formObj.append(str);
					formObj.submit();

				});// end button click event

		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; //5MB

		function checkExtension(tou_image, fileSize) {
			if (fileSize > maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}
			if (regex.test(tou_image)) {
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		} // end checkExtension function

		$("input[type='file']").change(function() {
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;

			for (var i = 0; i < files.length; i++) {

				if (!checkExtension(files[i].name, files[i].size)) {
					return false;
				}

				formData.append("uploadFile", files[i]);
			}

			$.ajax({
				url : '/touruploadAjaxAction',
				processData : false,
				contentType : false,
				data : formData,
				type : 'post',
				dataType : 'json',
				success : function(result) {
					console.log(result);
					showUploadResult(result); // 업로드 결과 처리
				}
			});
		}); // end uploadBtn Click Event

		function showUploadResult(uploadResultArr) {
			if (!uploadResultArr || uploadResultArr.length == 0) {
				return;
			}
			var uploadUL = $(".uploadResult ul");
			var str = "";

			$(uploadResultArr)
					.each(
							function(i, obj) {
								//image type
								if (obj.fileType) {
									var fileCallPath = encodeURIComponent(obj.uploadPath
											+ "/s_"
											+ obj.uuid
											+ "_"
											+ obj.tou_image);
									str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.tou_image+"' data-type='"+obj.fileType+"'><div>";
									str += "<span> " + obj.tou_image
											+ "</span>";
									str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
									str += "<img src='/tourdisplay?tou_image="
											+ fileCallPath + "'>";
									str += "</div>";
									str += "</li>";
								} else {
									var fileCallPath = encodeURIComponent(obj.uploadPath
											+ "/"
											+ obj.uuid
											+ "_"
											+ obj.tou_image);
									var fileLink = fileCallPath.replace(
											new RegExp(/\\/g), "/");
									str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-tou_image='"+obj.tou_image+"' data-type='"+obj.fileType+"'><div>";
									str += "<img src='/resources/img/attach.png' style='width:20px;'>";
									str += "<span> " + obj.tou_image
											+ "</span>";
									str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
									str += "</div>";
									str += "</li>";
								}
							});
			uploadUL.html(str);
		}

		// 파일 삭제 버튼 클릭 이벤트
		$(".uploadResult").on("click", "button", function() {
			console.log("delete file");

			var targetFile = $(this).data("file");
			var type = $(this).data("type");

			var targetLi = $(this).closest("li");

			$.ajax({
				url : '/tourdeleteFile',
				data : {
					tou_image : targetFile,
					type : type
				},
				type : 'post',
				dataType : 'text',
				success : function(result) {
					alert(result);
					targetLi.remove();
				}
			});
		});
	});
</script>
<%@ include file="../include/footer.jsp"%>