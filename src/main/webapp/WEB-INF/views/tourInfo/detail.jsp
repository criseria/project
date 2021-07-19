<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="/resources/tourPageDetail.css">
<sec:authentication property="principal" var="pinfo"/>
		
<div class="tour_detail_top">

	<div class="tour_detail_image">
		<img src='/resources/image/<c:out value="${tourInfo.tou_image}"/>' style='width:100%; height:100%;' >
	</div>

	<div class="tour_detail_info">
		<div>
			<input type="hidden" value="${tourInfo.tou_no}">
		</div>
		<div class="info1">
			<p><c:out value="${tourInfo.tou_title}"></c:out></p>
		</div>
		<div class="info2">
			<p><c:out value="${tourInfo.tou_name}"></c:out></p>
		</div>
		<div class="info3">
			<p><c:out value="${tourInfo.tou_addr}"></c:out> </p>
		</div>
		<div class="info4">
			<p style="white-space: pre-line;">관람시간 :  <c:out value="${tourInfo.tou_time}"></c:out> </p>
		</div>
		<div class="info5">
			<p><a href="<c:out value="${tourInfo.tou_homepage}"/>"><c:out value="${tourInfo.tou_name}홈페이지" ></c:out>→</a></p>
		</div>
		
		<%--찜 버튼 --%>
		<form action="/tourInfo/pickPlus" method="get" id="pickForm">
			<input type="hidden" id="btn" name="tou_no" value='<c:out value="${tourInfo.tou_no}"/>'/>
			<input type="hidden" id="btn" name="userid" value='<c:out value="${pinfo.username}"/>'/>
			<input type="hidden" id="btn" name="checkpick" value='<c:out value="${pick.checkpick}"/>'/>
			<a href="#a" class="btn_pick" data-oper="pickPlus" onclick="changePick()" style="margin-left: 50px;">
				<c:choose>
					<c:when test="${pick.checkpick eq null}"><img src='/resources/image/nonpick.png' style="width: 30px;"></c:when>
					<c:otherwise><img src='/resources/image/pick1.png' style="width: 30px;"></c:otherwise>			
				</c:choose>
			</a>
		</form>
		<div class="btns">
			<button class="list-btn" type="button" data-oper="list">목록으로</button>
			<c:if test="${pinfo.username eq 'admin01'}">
				<button class="modify-btn" type="button" data-oper="update">수정</button>
   			</c:if>
		</div>
	</div>
</div>
	


<div class="tour_content">
	<p>이것만은 알고보자!</p>
	<div class="img2">
		<img src='/resources/image/<c:out value="${tourInfo.tou_image2}"/>'>
	</div>
	<span><c:out value="${tourInfo.tou_content}"></c:out></span>
</div>
	
	
	
	<!-- 지도 API -->
	<div class="map" id="map"></div>
	<div class="img3">
		<img src='/resources/image/<c:out value="${tourInfo.tou_image3}"/>'>
	</div>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ccb45df0e01b8a0c46bb657608d243b2"></script>
	<script>
      var container = document.getElementById('map');
      var options = {
         center: new kakao.maps.LatLng(${tourInfo.tou_lat}, ${tourInfo.tou_lng}),
         level: 5 //지도의 확대 레벨
      };
		
   	  // 지도를 생성
      var map = new kakao.maps.Map(container, options); 
      
   	  // 마우스 드래그를 이용한 지도 이동을 막는다
   	  map.setDraggable(false);
   	  
      // 마커가 표시될 위치
      var markerPosition  = new kakao.maps.LatLng(${tourInfo.tou_lat}, ${tourInfo.tou_lng}); 

      // 마커를 생성
      var marker = new kakao.maps.Marker({
          position: markerPosition
      });
      
      // 마커가 지도 위에 표시되도록 설정
      marker.setMap(map);
      // 마커에 커서가 오버됐을 때 마커 위에 표시할 인포윈도우를 생성
      var iwContent = '<div style="padding:5px; text-align:center;">"${tourInfo.tou_name}"</div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능

      // 인포윈도우를 생성
      var infowindow = new kakao.maps.InfoWindow({
          content : iwContent
      });

      // 마커에 마우스오버 이벤트를 등록
      kakao.maps.event.addListener(marker, 'mouseover', function() {
        // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시
          infowindow.open(map, marker);
      });

      // 마커에 마우스아웃 이벤트를 등록합니다
      kakao.maps.event.addListener(marker, 'mouseout', function() {
      // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거
      infowindow.close();
      });
   </script>
   
   <!-- 수정버튼과 API 아래 위치하는 주소 -->
	<div>
    	<c:out value="${tourInfo.tou_addr}"></c:out>
    </div>
	
	
	<div class="but_list">
		<button class="but_list02" type="button" data-oper="list">목록으로</button>
	</div>
	
	<form action="/tourInfo/update" method="get" id="operForm">
		<input id="btn" type="hidden" name="tou_no" value='<c:out value="${tourInfo.tou_no}"/>'/>
		<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'/>
		<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'/>
		<input type="hidden" name="type" value=<c:out value="${cri.type}"/>>
        <input type="hidden" name="keyword" value=<c:out value="${cri.keyword}"/>>
        <input type="hidden" name="loc_no" value="<c:out value="${cri.loc_no }"/>"/>
        <input type="hidden" id="btn" name="userid" value='<c:out value="${pinfo.username}"/>'/>
	</form>
	
	
				
	
		
	
<script type="text/javascript">
	$(function(){
		/* form을 변수에 담음 */
		var operForm = $("#operForm");
		
		/* 수정 화면으로 이동하는 버튼 클릭 이벤트 */
		/* button태그의 data-oper 속성이 update인 것이 선택자에 들어감 */
		$("button[data-oper='update']").click(function(e){
			operForm.attr("action", "/tourInfo/update").submit();	/* operForm의 action 속성의 값을 바꿔주고 submit */
		});
		
		/* 라스트(목록)으로 이동하는 버튼 클릭 이벤트 */
		/* button태그의 data-oper 속성이 list인 것이 선택자에 들어감 */
		$("button[data-oper='list']").click(function(e){
			operForm.find('#btn').remove(); /* 리스트로 돌아갈 때 tou_no값은 필요없으므로 operForm의 id가 btn인 태그(ou_no가 담긴 태그)를 삭제 */
			operForm.attr("action", "/tourInfo/list").submit();
			
		});
	});
	
</script>

<script type="text/javascript">
var tou_no = ${tourInfo.tou_no};
var userid = '<c:out value="${pinfo.username}"/>';

function changePick(){
	var checkpick = $("input[name=checkpick]").val();
	if(checkpick == "") checkpick = 0;
	$.ajax({
		type: "POST",
		url: "/tourInfo/pickPlus",
		data: { "tou_no" : tou_no, "userid" : userid, "checkpick": checkpick},
		dataType: "json",
		error: function(){
			//Rnd.alert("통신 에러", "error", "확인", function(){});
		},
		success : function(result){
			if(result > 0) {
				$("input[name=checkpick]").val(1);
				$(".btn_pick img").attr("src", "/resources/image/pick1.png");
			} else {
				$("input[name=checkpick]").val(0);
				$(".btn_pick img").attr("src", "/resources/image/nonpick.png");
			}
		}
	});
}
</script>
<%@ include file="../include/footer.jsp" %>