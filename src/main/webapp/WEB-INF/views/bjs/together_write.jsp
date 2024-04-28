<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/resources/public/css/bjs/together_write.css">
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<script type="text/javascript">
	function together_write_ok(f) {
		f.action="together_Write_ok.do";
		f.submit();
	}
	
	
// 	$(function() {
// 		  $('input[name="datefilter"]').daterangepicker({
// 		      autoUpdateInput: false,
// 		      locale: {
// 		          cancelLabel: 'Clear'
// 		      }
// 		  });
// 		  $('input[name="datefilter"]').on('apply.daterangepicker', function(ev, picker) {
// 		      $(this).val(picker.startDate.format('YYYY/MM/DD') + ' - ' + picker.endDate.format('YYYY/MM/DD'));
// 		  });
// 		  $('input[name="datefilter"]').on('cancel.daterangepicker', function(ev, picker) {
// 		      $(this).val('');
// 		  });

// 		});
	
	$(function() {
	  $('input[name="datetimes"]').daterangepicker({
	    timePicker: true,
	    startDate: moment().startOf('hour'),
	    endDate: moment().startOf('hour').add(32, 'hour'),
	 	locale: {
	        "format": "YY/MM/DD hh:mm A",
	        "separator": " ~ ",
	        "applyLabel": "확인",
	        "cancelLabel": "취소",
	        "fromLabel": "From",
	        "toLabel": "To",
	        "customRangeLabel": "Custom",
	        "weekLabel": "W",
	        "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
	        "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
	    }
	  });
	});
	
	$('input[name="datetimes"]').on('apply.daterangepicker', function (ev, picker) {
		let startDate = picker.startDate.format('YYYY/MM/DD');
		let endDate = picker.endDate.format('YYYY/MM/DD');
		$.ajax({
		    type: 'GET',
		    url: '/경로',
		    data: {startDate: startDate, endDate: endDate},
		    success: function (data) {
		        if (data) {
// 		        	$('#테이블을 감싸는 DIV ID').replaceWith(data);
		        }
		    }
		})
	})
	
$(document).ready(function() {
    $('.togetherSub1Button').click(function() {
        $('.togetherSub1Button').removeClass('active');
        $(this).addClass('active');
    });
});
</script>
</head>
<body>
	<div class="towContainer">
	    <form class="togetherWriteForm">
	        <div class="togetherWriteInput">
	            <div class="togetherh2">
	                <h2>동 행 글쓰기</h2>
	            </div>
	            <input type="text" name="t_subject" value="" class="togetherWriteInput1" placeholder="제목을 입력하세요" required>
	            <textarea class="togetherWriteInput2" name="t_content" placeholder="내용을 입력하세요" required></textarea>
	            <input type="submit" value="작성하기" class="togetherWriteInputSubmit" onclick="together_write_ok()">
	        </div>
	        <div class="togetherWriteSelect">
	            <strong>캠핑타입</strong>
	            <div class="togetherSub1">
	            	<button type="button" value="" class="togetherSub1Button">카라반</button>
	            	<button type="button" value="" class="togetherSub1Button">글램핑</button>
	            	<button type="button" value="" class="togetherSub1Button">야영지</button>
	            </div>
	            <div class="togetherSub1">
	                <strong>캠핑장</strong>
	                <div class="togetherSub1Div">
	                	<div class="searchForm">
		                	<input type="search" class="searchbar" placeholder="캠핑장 이름">
	        				<input type="submit" class="res" value="검색">
        				</div>
<!-- 	                    <input type="text" value="" id="" placeholder="캠핑장 이름" class="togetherSub1DivInput"> -->
<!-- 	                    <input type="button" value="검색" id="" class="togetherSub1DivButton"> -->
	                    <p>서울특별시 강서구 화곡동</p>
	                    <p>426-85</p>
	                </div>
	            </div>
	            <div>
	                <img src="${path}/resources/images/tree-4.jpg" class="togetherSub1Img">
	            </div>
	            <div class="togetherSub1">
	                <strong>캠핑인원</strong>
	                <span>&nbsp;&nbsp;4명</span>
	            </div>
	            <div class="togetherSub2">
	                <strong>캠핑기간</strong>
<!-- 	                <input type="text" name="datefilter" value="" class="datetimes" /> -->
	                <p><input type="text" name="datetimes" value="" class="datetimes" /></p>
	            </div>
	            <div>
	                
<%-- 	                <img src="${path}/resources/images/tree-4.jpg" class="togetherSub1Img"> --%>
	            </div>
	        </div>
	    </form>
	</div>
</body>
</html>