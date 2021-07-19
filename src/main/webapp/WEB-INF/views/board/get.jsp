<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/header.jsp" %>
<link rel="stylesheet" href="/resources/getpage.css">
<link rel="stylesheet" href="/resources/button.css">

<sec:authentication property="principal" var="pinfo"/> <!-- authentication : 인증에 관한 내용 (많이 쓴다면 var을 통해 변수 지정해놓으면 된다) -->
<div class="get_main">
	<div>
		<div class="panel-body">
			<div>
				<input class="title" name="title" value='<c:out value="${board.title }"/>' readonly="readonly">
			</div>
			<div style="border-bottom: 1px solid #eee;">
				<input class="writer" name="writer" value='<c:out value="${board.writer }"/>' readonly="readonly">
				<input class="regdate" name="date" value='<c:out value="${board.regdate}"/>' readonly="readonly" >
				<a style="float: right; color: lightgray;">댓글<input class="replycnt" name="reply" value='<c:out value="${board.replycnt}"/>' readonly="readonly"></a>
			</div>
			<div>
				<textarea class="textbox" name="content" rows="3" readonly="readonly"><c:out value="${board.content }"/></textarea>
			</div>
			
			<div class="panel-heading-file">첨부 파일</div>
			<div class="panel-body">
				<div class="panel-body">
				<div class="uploadResult">
					<ul></ul>
				</div>
			</div>
	</div>
			
			<form id="operForm" action="/board/modify" method="get" >
				<input id="bno" type="hidden" name="bno" value='<c:out value="${board.bno }"/>' />
				<input type="hidden" name="writer" value='<c:out value="${board.writer}"/>' />
				<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>' />
				<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>' />
				<input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>' />
				<input type="hidden" name="type" value='<c:out value="${cri.type}"/>' />
				
			</form>
		</div>
	</div>
</div>
	
	<div class="button">
		<c:if test="${pinfo.username eq board.writer || pinfo.username eq 'admin01'}">	<!-- 로그인 된 계정과 작성자가 같은가 -->
			<button data-oper="modify" class="get_btn_modify">수정</button>
		</c:if>	
		
		<!-- <button data-oper="modify" class="btn_modify">수정</button> -->
		<button data-oper="list" class="get_btn_list">목록</button>
	</div>	
			
	<div class="dag">
		<i></i> 댓글
		<button id="addReplyBtn" class="get_new_dag">댓글 작성</button>
	</div>
	<div class="panel-body">
		<ul class="chat">
			<li class="left clearfix" data-rno="12">
				<div>
					<input type='hidden' id='authCheck' value='<c:out value="${pinfo.username}"/>'/>
				</div>
			</li>
		</ul>
	</div>

<!-- Modal -->
<div class="modal fade" id="MyModal" tabindex="-1" role="dialog"
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"
               ari-hidden = "true">&times;</button>
            <h4 class="modal-title" id="myModalLabel">댓글 등록</h4>
         </div>
         <div class="modal-body">
            <div class="form-group">
            		<input class='form-control-name' name='replyer' value='<c:out value="${pinfo.username}"/>' readonly='readonly'>
            </div>
            <div>
               <input class="form-control" name='reply' value=''  onfocus="this.placeholder=''" onblur="this.placeholder='댓글의 내용을 입력하세요'" placeholder="댓글의 내용을 입력하세요">
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

<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript" src="/resources/js/util.js"></script>

<script type="text/javascript">
	$(function(){
		var operForm = $("#operForm");
		
		// 수정 화면으로 이동하는 버튼 클릭 이벤트
		$("button[data-oper='modify']").click(function(e){
			operForm.attr("action", "/board/modify");
			operForm.submit();
		});
		
		// 리스트(목록)으로 이동하는 버튼 클릭 이벤트
		$("button[data-oper='list']").click(function(e){
			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list");
			operForm.submit();
		});
	});
</script>


<script type="text/javascript"><!-- 댓글 처리 스크립트 -->
	console.log("--------------------");
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");
	
	var authCheck = $("#authCheck");
	var loginUser = authCheck.val();
	
	// 데이터 불러와서 댓글 처리해주기
	showList(1);
	function showList(page){
		// replyService 에서 리스트를 가져오고
		// html 코드를 작성
		
		replyService.getList({bno:bnoValue, page:page || 1},
			function(list){
				var str = "";
				
				if(list == null || list.length==0){
					// 댓글 목록이 없는 경우
					return;
				}
				
				for(var i=0; i<list.length; i++){
					str += '<li class="left clearfix" data-rno="' + list[i].rno + '">';
					str += '<div>';
					str += '<div class="header">';
					str += '<strong class="primary-font">' + list[i].replyer + '</strong>';
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
	
	// get에서 댓글 작성 버튼 클릭했을 때
	$("#addReplyBtn").click(function(){
		modalInputReplyDate.closest("div").hide(); // 등록 날짜 input 숨기기
		$("#regdate").hide();					   // 등록 날짜 label 숨기기
		
		// 클릭했을 떄 타이틀을 '댓글 등록'으로 변경하기
	    var replyTitle = document.getElementById('myModalLabel');
	    replyTitle.innerHTML = '댓글 작성';
	    console.log(replyTitle);
		
		modalInputReply.val("");
		modalInputReplyer.val(loginUser);
		
		// 추가 할 내용 - - - - - - - - - - -
		modalRegisterBtn.show();		// 등록 버튼 보이기
		modalModBtn.hide();				// 수정 버튼 숨기기
		modalRemoveBtn.hide();			// 삭제 버튼 숨기기
		
		$(".modal").modal("show");
	});
	
	// 취소 버튼 클릭 이벤트 --- 모달 창 숨김
	$("#modalCloseBtn").click(function(){
		$(".modal").modal("hide");
	});
	
	// 댓글 등록 버튼 클릭 이벤트 --- 데이터 삽입
	modalRegisterBtn.click(function(){
		
		var reply = {
				reply : modalInputReply.val(),
				replyer : modalInputReplyer.val(),
				bno : bnoValue
		};
		
		replyService.add(reply, function(result){
			alert(result);
			
			modal.modal("hide");
			showList(1);	// 댓글 창 불러오는 함수 재 실행
		});
		
	});
	
	// 각 댓글들 클릭 이벤트(조회)
	var rno;	// 범위적으로 사용하기 위해 전역 변수 선언
	$(".chat").on("click", "li", function(){
		rno = $(this).data("rno");	// data-rno 속성에 담긴(rno) 가져오기
		
		// 클릭했을 떄 타이틀을 '댓글'로 변경하기
	    var replyTitle = document.getElementById('myModalLabel');
	    replyTitle.innerHTML = '댓글';
	    console.log(replyTitle);
		
		// get 함수를 이용해서 ajax 실행
		replyService.get(rno, function(reply){
			
			if(loginUser == reply.replyer){
				modalInputReply.val(reply.reply).removeAttr("readonly");
				modalInputReplyer.val(reply.replyer).attr("readonly","readonly");
				modalInputReplyDate.val(displayTime(reply.replyDate)).attr("readonly","readonly");
				
				modalInputReplyDate.closest("div").show();
				$("#regdate").show();
				modalRegisterBtn.hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				$(".modal").modal("show");
				
			}else if(loginUser != reply.replyer && loginUser == 'admin01'){
				modalInputReply.val(reply.reply).attr("readonly","readonly");
				modalInputReplyer.val(reply.replyer).attr("readonly","readonly");
				modalInputReplyDate.val(displayTime(reply.replyDate)).attr("readonly","readonly");
				
				modalInputReplyDate.closest("div").show();
				$("#regdate").show();
				modalRegisterBtn.hide();
				modalModBtn.hide();
				modalRemoveBtn.show();
				
				$(".modal").modal("show");
				
			}else if(loginUser != reply.replyer && loginUser != 'admin01'){
				alert("본인이 작성한 댓글만 수정 및 삭제 가능합니다.");
			}	
		});
	});
	
	
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
<script type="text/javascript"><!-- 첨부 파일 조회 스크립트 -->
	$(function(){
		var bno = '<c:out value="${board.bno}"/>';
		
		$.ajax({
 			type : 'get',
 			url : '/board/getAttachList',
 			data : {bno:bno},
 			dataType : 'json',
 			success : function(result){
 				console.log(result)
 				
 				var str = '';
 				$(result).each(function(i, obj){
 					//image type
 					
 					if(obj.fileType){
 						var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
 						
 						str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'><div>";
 						str += "<img src='/display?fileName="+fileCallPath+"'>";
 						str += "</div>";
 						str += "</li>";
 					}else{
 						str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'><div>";
 						str += "<img src='/resources/img/attach.png' style='width:20px;'>";
 						str += "<span> "+ obj.fileName+"</span>";
 						str += "</li>";
 					} 
 				});
 				$(".uploadResult ul").append(str);
 			}
 		});
		
		$(".uploadResult").on("click", "li", function(){
			console.log("download Files");
			
			var liObj = $(this);
			var path = encodeURIComponent( liObj.data("path")+"/"+liObj.data("uuid")+"_"+liObj.data("filename") );
			self.location = '/download?fileName=' + path;
		});
	});
</script>
<%@include file="../include/footer.jsp" %>