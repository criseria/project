<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<html>
<head>
<title></title>
<style type="text/css">

	th, td{
		border: 1px solid #e4e4e4;
	}
	th{
		background-color: #f5f5f5;
	}
	
	/* 별점 css */
	.rating .rate_radio {
    position: relative;
    display: inline-block;
    z-index: 20;
    opacity: 0.001;
    width: 60px;
    height: 60px;
    background-color: #fff;
    cursor: pointer;
    vertical-align: top;
    display: none;
	}
	.rating .rate_radio + label {
    position: relative;
    display: inline-block;
    margin-left: -4px;
    z-index: 10;
    width: 60px;
    height: 60px;
    background-image: url('../../resources/img/starrate.png');
    background-repeat: no-repeat;
    background-size: 60px 60px;
    cursor: pointer;
    background-color: #f0f0f0;
	}
	.rating .rate_radio:checked + label {
	    background-color: #ff8;
	}
	.review-btn{
		left : 81%;
		top : 5px;
		position: relative;
		padding: 4px 8px;
		border: 1px solid #999;
		color: #333;
		border-radius: 2px;
		box-shadow: 0 -2px 0 rgb(0 0 0 / 10%) inset;
		font-size: 11px;
		background-color: white;
	}
	.backout-btn{
		left : 81.7%;
		top : 5px;
		position: relative;
		padding: 4px 8px;
		border: 1px solid #999;
		color: #333;
		border-radius: 2px;
		box-shadow: 0 -2px 0 rgb(0 0 0 / 10%) inset;
		font-size: 11px;
		background-color: white;
	}
	.review_content{
		resize: none;
		border : none;
	}
	.review_content:focus{
		outline: none;
	}
</style>
<script type="text/javascript">
	
	// 다른 함수에서 값이 넘어오므로 전역변수 선언
	var score = '';
	
	/* 리뷰 등록 */
	function regReview(){
		var pno = '${pno}';
		var replyer = '${userid}';
		var reply = $('.review_content').val();
		
		$.ajax({
			type: "POST",
			url: "/reply/regReply",
			data: {"pno" : pno, "replyer" : replyer,  "reply" : reply, "score" : score},
			dataType: "json",
			error: function(){},
			success : function(result){
				if(result == 1) {
					alert("리뷰를 작성해주셔서 감사합니다.");
						self.close();
				}else if(result == 0){
					alert("리뷰 작성 실패 실패");
				}
			}
		});
		
	}
	
	/* 뒤로 가기 */
	function back(){
		self.close();
	}
	
	/* 별점 이벤트 */
	function Rating(){};
	Rating.prototype.rate = 0;
	Rating.prototype.setRate = function(newrate){
	    //별점 마킹 - 클릭한 별 이하 모든 별 체크 처리
	    this.rate = newrate;
	    var items = document.querySelectorAll('.rate_radio');
	    items.forEach(function(item, idx){
	        if(idx < newrate){
	            item.checked = true;
	        }else{
	            item.checked = false;
	        }
	    });
	}
	
	var rating = new Rating(); //별점 인스턴스 생성
	 
	document.addEventListener('DOMContentLoaded', function(){
	    document.querySelector('.rating').addEventListener('click',function(e){
	        var elem = e.target;
	        if(elem.classList.contains('rate_radio')){
	            rating.setRate(parseInt(elem.value));
	            console.log(rating.rate);
	            
	            score = rating.rate
	            console.log("test : " + score);
	        }
	    })
	});
	 
</script>
</head>
<body>
	<h1 style="text-align: center;">Review</h1>
	<table>
		<tr>
			<th>상품명</th>
			<td style="text-align: center;"><c:out value="${pname}"></c:out> </td>
		</tr>
		<tr>
			<td colspan="2">
				<div style="text-align: center;">별점을 선택해 주세요.</div>
				<div class="rating" style="text-align: center;">
	                <!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
	                <input type="checkbox" name="rating" id="rating1" value="1" class="rate_radio" title="1점">
	                <label for="rating1"></label>
	                <input type="checkbox" name="rating" id="rating2" value="2" class="rate_radio" title="2점">
	                <label for="rating2"></label>
	                <input type="checkbox" name="rating" id="rating3" value="3" class="rate_radio" title="3점">
	                <label for="rating3"></label>
	                <input type="checkbox" name="rating" id="rating4" value="4" class="rate_radio" title="4점">
	                <label for="rating4"></label>
	                <input type="checkbox" name="rating" id="rating5" value="5" class="rate_radio" title="5점">
	                <label for="rating5"></label>
            	</div>
	    	</td>
		</tr>
		<tr>
			<th colspan="2">리뷰</th>
		</tr>
		<tr>
			<td colspan="2">
				<textarea placeholder="솔직하고 담백한 리뷰 감사합니다~!!" onfocus="this.placeholder=''" onblur="this.placeholder='솔직하고 담백한 리뷰 감사합니다~!!'" rows="5px" cols="80px" name="reply" class="review_content"></textarea>
			</td>
		</tr>
	</table>
	<button class="review-btn" type="button" name="reviewBTN" onclick="regReview()">리뷰 작성</button>
	<button class="backout-btn" type="button" onclick="back()">취소</button>
</body>
</html>