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
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="${path}/resources/public/css/bjs/together_history.css">
<%@ include file="../hs/header.jsp" %>
<script type="text/javascript">
$(function() {
	promiseApplyList();
	console.log(1);
});

function promiseApplyList() {
	let memberIdx = document.getElementById("member_idx").value;
    	$('.thwrapper').empty();
    $.ajax({
        url: 'get_together_history.do',
        type: 'post',
        data: {
            member_idx: memberIdx
        },
        dataType: 'json',
        success: function(data) {
        	if (data != null && data.length > 0) {
                let imgSrc = data.member_img === null || data.member_img === '' || data.member_img === 'user2.png' ? '${path}/resources/images/' + data.member_img : data.member_img;
                let html = '';
            	html += '<div class="thwrapper1">';
                html += '<button type="button" name="" class="thwrapper1Button" onclick="">동행 신청 받은 내역</button>';
                html += '<button type="button" name="" class="thwrapper1Button" onclick="">동행 신청 내역</button>';
                html += '</div>';
                html += '<ul class="thul1">';
                html += '<li class="thli th1">이미지</li>';
                html += '<li class="thli th1">닉네임(나이)(동행경험)</li>';
                html += '<li class="thli th1">캠핑장</li>';
                html += '<li class="thli th1">동행날짜</li>';
                html += '<li class="thli th1">인원</li>';
                html += '<li class="thli th1">신청상태</li>';
                html += '</ul>';
                for (let i = 0; i < data.length; i++) {
                    let promise = data[i];
	                let html2 = '<div class="thul2">';
	                html2 += '<ul><li class="th1 thliImage"><img src="' + imgSrc + '" class="qa11">사진</a></li></ul>';
	                html2 += '<ul><li class="th1">' + promise.member_nickname + '(' + promise.member_dob + ')(' + promise.promise_my_count + ')</li></ul>';
	                html2 += '<ul><li class="th1"><a href="together_detail.do?t_idx=' + promise.t_idx + '" class="qa11">' + promise.t_campname + '</a></li></ul>';
	                html2 += '<ul><li class="th1"><a href="together_detail.do?t_idx=' + promise.t_idx + '" class="qa11">' + promise.t_startdate + '-' + promise.t_enddate + '</a></li></ul>';
	                html2 += '<ul><li class="th1"><a href="together_detail.do?t_idx=' + promise.t_idx + '" class="qa11">' + promise.promise_count + '/' + promise.t_numpeople + '</a></li></ul>';
	                html2 += '<div class="thul2Div">';
	                html2 += '<button type="button" value="" class="thul2DivButton" onclick="">수락</button>';
	                html2 += '<button type="button" value="" class="thul2DivButton" onclick="">거절</button>';
	                html2 += '<input type="hidden" id="member_idx" value="${member_idx }">';
	                html2 += '</div>';
	                html2 += '</div>';
	                html += html2;
                }
         	 $('.thwrapper').append(html);
        	} else {
        		let html = '<div class="no-data-message">';
        		html += '<p class="no-data-messageP">동행신청이 없습니다.</p>';
        		html += '</div>';
                $('.thul2').replaceWith(html);
            }
        },
        error: function(xhr, status, error) {
        	console.error(error);
        }
    });
};
</script>
</head>
<body>
	<div class="thcontainer">
		<div class="thwrapper">
			<div class="thwrapper1">
				<button type="button" name="" class="thwrapper1Button" onclick="">동행 신청 받은 내역</button>
				<button type="button" name="" class="thwrapper1Button" onclick="">동행 신청 내역</button>
			</div>
			<ul class="thul1">
				<li class="thli th1">이미지</li>
				<li class="thli th1">닉네임(나이)</li>
				<li class="thli th1">캠핑장</li>
				<li class="thli th1">동행날짜</li>
				<li class="thli th1">인원</li>
				<li class="thli th1">신청상태</li>
			</ul>
			<div class="thul2">
				<ul><li class="th1 thliImage"><a href="qa_detail.do?qa_idx=${k.qa_idx}&cPage=${paging.nowPage}" class="qa11">사진</a></li></ul>
				<ul><li class="th1"><a href="qa_detail.do?qa_idx=${k.qa_idx}&cPage=${paging.nowPage}" class="qa11">깡패(20대)</a></li></ul>
				<ul><li class="th1"><a href="qa_detail.do?qa_idx=${k.qa_idx}&cPage=${paging.nowPage}" class="qa11">서울난지캠핑장</a></li></ul>
	            <ul><li class="th1"><a href="qa_detail.do?qa_idx=${k.qa_idx}&cPage=${paging.nowPage}" class="qa11">2024/05/08-2024/05/09</a></li></ul>
	            <ul><li class="th1"><a href="qa_detail.do?qa_idx=${k.qa_idx}&cPage=${paging.nowPage}" class="qa11">2 / 5</a></li></ul>
	<%--                 <li class="th1"><a href="qa_detail.do?qa_idx=${k.qa_idx}&cPage=${paging.nowPage}" class="th11">신청중</a></li> --%>
				<div class="thul2Div">
					<button type="button" value="" class="thul2DivButton" onclick="">수락</button>
					<button type="button" value="" class="thul2DivButton" onclick="">거절</button>
		     		<input type="hidden" id="member_idx" value="${member_idx }">
	     		</div>
     		</div>
		</div>
		<div class="thwrapper1">
			<ul class="th_paging">
				<!-- 이전 버튼 -->
				<c:choose>
					<c:when test="${paging.beginBlock <= paging.pagePerBlock }">
						<li class="th_disable">이전으로</li>
					</c:when>
					<c:otherwise>
						<li>
							<a href="qa_list.do?cPage=${paging.beginBlock - paging.pagePerBlock }" class="th_able">이전으로</a>
						</li>
					</c:otherwise>
				</c:choose>
	
				<!-- 페이지번호들 -->
				<c:forEach begin="${paging.beginBlock }" end="${paging.endBlock }" step="1" var="k">
					<c:choose>
						<c:when test="${k == paging.nowPage }">
							<li class="nowpagecolor">${k }</li>
						</c:when>
						<c:otherwise>
							<li><a href="qa_list.do?cPage=${k }" class="nowpage">${k }</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				
				<!-- 이후 버튼 -->
				<c:choose>
					<c:when test="${paging.endBlock >= paging.totalPage }">
						<li class="th_disable">다음으로</li>
					</c:when>
					<c:otherwise>
						<li>
							<a href="qa_list.do?cPage=${paging.beginBlock + paging.pagePerBlock }" class="th_able">다음으로</a>
						</li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>	
	</div>
<%@ include file="../hs/footer.jsp" %>
</body>
</html>