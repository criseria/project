<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="/resources/registerpage.css">
<link rel="stylesheet" href="/resources/button.css">
<script type="text/javascript" src="/resources/smarteditor2/js/service/HuskyEZCreator.js" charset="utf-8"></script>




		<div class="panel panel-default">
			<div class="register_body">
				<form action="/board/register" method="post" role="form">
					<div>
						<input class="register-title" name="title" placeholder="제목" onfocus="this.placeholder=''" onblur="this.placeholder='제목'">
					</div>
					<div>
						<textarea class="textbox" placeholder="게시글에 작성하실 내용을 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='게시글에 작성하실 내용을 입력해주세요.'" name="content" rows="10" cols="100" style="width: 100%;"></textarea>
					</div>
					<div>
						<sec:authorize access="isAuthenticated()">
							<sec:authentication property="principal.username" var="userid"/>
							<input class="form_control_writer" name="writer" value="${userid}" readonly="readonly">
						</sec:authorize>
					</div>
					<div class="fileupload">
						<div class="fileupload-head">파일 업로드</div>
						<div class="panel-body">
							<div class="panel-body">
								<div class="uploadDiv">
									<input type="file" name="uploadFile" multiple="multiple">
								</div>
								<div class="uploadResult">
									<ul></ul>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="button">
				<button type="submit" data-oper="register" class="btn_register">작성완료</button>
				<button type="submit" data-oper="list" class="btn_list">목록</button>
			</div>	

					<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
					<input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
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
				formObj.attr("action", "/board/register");
			}else if(operation === 'list'){
				// 목록 화면으로 가기위한 속성 변경
				formObj.attr("action", "/board/list");
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
				formObj.attr("action", "/board/register");
			}else if(operation === 'list'){
				// 목록 화면으로 가기위한 속성 변경
				formObj.attr("action", "/board/list");
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

<script type="text/javascript"><!-- 파일 업로드 스크립트 -->
	$(function(){
		var formObj = $("form[role='form']");
		$("button[type='submit']").click(function(e){
			e.preventDefault();
			var str = '';
			
			$(".uploadResult ul li").each(function(i, obj){
				var jobj = $(obj);
				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"' />";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"' />";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"' />";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"' />";
			});
			
			formObj.append(str);
			formObj.submit();
			
		});// end button click event
		
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; //5MB
		
		function checkExtension(fileName, fileSize){
			if(fileSize > maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		} // end checkExtension function
		
	 	$("input[type='file']").change(function(){
// 	 		$(".uploadResult ul").empty();
	 		
	 		var formData = new FormData();
	 		var inputFile = $("input[name='uploadFile']");
	 		var files = inputFile[0].files;
	 		
	 		for(var i=0; i<files.length; i++){
	 			if(!checkExtension(files[i].name, files[i].size)){
	 				return false;
	 			}
	 			formData.append("uploadFile", files[i]);
	 		}
	 		
	 		$.ajax({
	 			url : '/uploadAjaxAction',
	 			processData : false,
	 			contentType : false,
	 			data : formData,
	 			type : 'post',
	 			dataType : 'json',
	 			success : function(result){
	 				console.log(result);
	 				showUploadResult(result);	// 업로드 결과 처리
	 			}
	 		});
	 	});// end uploadBtn Click Event
		
	 	function showUploadResult(uploadResultArr){
			if(!uploadResultArr || uploadResultArr.length == 0){return ;}
			var uploadUL = $(".uploadResult ul");
			var str = "";
			  
			$(uploadResultArr).each(function(i, obj){
				//image type
				if(obj.fileType){
					var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
					str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'><div>";
					str += "<span> "+ obj.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i>X</button><br>";
					str += "<img src='/display?fileName="+fileCallPath+"'>";
					str += "</div>";
					str += "</li>";
				}else{
					var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);            
					var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
					str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'><div>";
					str += "<img src='/resources/img/attach.png' style='width:20px;'>";
					str += "<span> "+ obj.fileName+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i>X</button><br>";
					str += "</div>";
					str += "</li>";
				} 
			});
			uploadUL.html(str);
		}
	 	
	 	// 파일 삭제 버튼 클릭 이벤트
	 	$(".uploadResult").on("click", "button", function(){
	 		console.log("delete file");
	 		
	 		var cloneObj = $(".uploadDiv").clone();
	 		var targetFile = $(this).data("file");
	 		var type = $(this).data("type");
	 		
	 		var targetLi = $(this).closest("li");
	 		
	 		$.ajax({
	 			url : '/deleteFile',
	 			data : {fileName:targetFile, type:type},
	 			type : 'post',
	 			dataType : 'text',
	 			success : function(result){
	 				targetLi.remove();
	 				$(".uploadDiv").html(cloneObj.html());
	 				ShowUploadresult(result);
	 			}
	 		});
	 		
	 	});
	});
</script>
<%@include file="../include/footer.jsp" %>