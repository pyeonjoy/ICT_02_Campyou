<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/public/css/bm/my_main.css">
  <link rel="stylesheet" href="${path}/resources/css/menu_aside.css" />
  <script defer src="${path}/resources/public/js/bm/my_menu.js"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>마이페이지</title>
<script>
function handleMyBoardList(member_idx){
	href.location="my_acc_history.do?member_idx"+member_idx;
}

function handleMyFavList(member_idx){
	
}

$(document).ready(function() {
    promiseApplyList();
//     setInterval(promiseApplyList, 5000);
});

$(document).on('click', '.btn-accept', function() {
	let $accompanyList = $(this).closest('.accompany_list');
	let promiseIdx = $accompanyList.data('pm-idx');
    $.ajax({
        url: 'acceptPromise.do',
        type: 'post',
        data: {
            pm_idx: promiseIdx
        },
        dataType: 'json',
        success: function(data) {
            $accompanyList.remove();
            promiseApplyList();
        },
        error: function(xhr, status, error) {
            alert("수락 처리 중 오류가 발생했습니다.");
        }
    });
});

$(document).on('click', '.btn-decline', function() {
	let $accompanyList = $(this).closest('.accompany_list');
	let promiseIdx = $accompanyList.data('pm-idx');
    $.ajax({
        url: 'declinePromise.do',
        type: 'post',
        data: {
            pm_idx: promiseIdx
        },
        dataType: 'json',
        success: function(data) {
            $accompanyList.remove();
            promiseApplyList();
        },
        error: function(xhr, status, error) {
            alert("거절 처리 중 오류가 발생했습니다.");
        }
    });
});

function promiseApplyList() {
	let memberIdx = document.getElementById("memberIdx").value;
    $.ajax({
        url: 'promiseApplyList.do',
        type: 'post',
        data: {
            member_idx: memberIdx
        },
        dataType: 'json',
        success: function(data) {
        	$('.accompany_container').empty();
        	if (data != null && data.length > 0) {
	            for (let i = 0; i < Math.min(data.length, 4); i++) {
	            	let promise = data[i];
	            	let imgSrc = promise.member_img === null || promise.member_img === '' || promise.member_img === 'user2.png' ? '${path}/resources/images/' + promise.member_img : promise.member_img;
	            	let tf_name = promise.tf_name === null || promise.tf_name === '' ? '${path}/resources/images/to_camp2.jpg' : promise.tf_name;
	            	let html = '<div class="accompany_list" data-pm-idx="' + promise.pm_idx + '">';
	                html += '<div class="list_header">';
	                html += '<img src="' + imgSrc + '" alt="user_img" class="otheruser_img">';
	                html += '<div class="list_summery">';
	                html += '<p class="list_nickname">' + promise.member_nickname + '(' + promise.member_dob + ')' + '</p>';
	                html += '<p class="list_go">동행횟수 ' + promise.promise_count + '</p>';
	                html += '</div>';
	                html += '</div>';
	                html += '<div class="list_item">';
	                html += '<div class="list_image_container">';
	                html += '<img src="' + tf_name + '" alt="camping_img" class="camping_img">';
	                html += '<div class="list_text_overlay">';
	                html += '<p class="list_content">' + promise.t_campname + '</p>';
	                html += '<h4 class="list_title">' + promise.t_startdate + ' - ' + promise.t_enddate + '</h4>';
	                html += '</div>';
	                html += '</div>';
	                html += '</div>';
	                html += '<div class="btn-container">';
	                html += '<button class="btn btn-accept">수락</button>';
	                html += '<button class="btn btn-decline">거절</button>';
	                html += '</div>';
	                html += '</div>';
	                $('.accompany_container').append(html);
	            }
        	} else {
        		let html = '<div class="no-data-message">';
        		html += '<p class="no-data-messageP">동행신청이 없습니다.</p>';
        		html += '</div>';
                $('.accompany_container').replaceWith(html);
            }
        	if (data.length >= 5) {
                $('.together_listA').show();
            } else {
                $('.together_listA').hide();
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
		<%@ include file="../hs/mypage_menu.jsp"%>

	<div class="mypage">
		<div class="welcome">
			<div class="user_img">
				<c:choose>
					<c:when test="${empty mvo.member_img}">
						<img src="${path}/resources/img/cat.png" alt="user_img"
							class="user_img">
					</c:when>
					<c:otherwise>
						<img src="${path}/resources/uploadUser_img/${mvo.member_img}"
							alt="user_img" class="user_img">
					</c:otherwise>
				</c:choose>
			</div>
			<h2 class="welcome_user">${mvo.member_name}님, 환영합니다.</h2>
		</div>
		<a href="together_history.do?member_idx=${mvo.member_idx }" class="together_listA"><span class="together_list">+</span><span>더보기</span></a>
		<div class="accompany_container">

			<%--        <img src="${path}/resources/img/right.png" alt="arrow-left" class="arrow arrow-left"> --%>
			<%--        <img src="${path}/resources/img/right.png" alt="arrow-right" class="arrow arrow-right">     --%>
		</div>

		<div class="list_container">
			<div class="my_list my_board_list">
				<h4 class="my_title">내가 쓴 글</h4>
				<button class="more_list"
					onclick="handleMyBoardList(${mvo.member_idx})">+</button>
				<div class="my_list_summery">

					<c:choose>
						<c:when test="${empty selectedList }">
							<p class="nolist">작성 내역이 없습니다.</p>
						</c:when>
						<c:otherwise>
							<c:forEach var="list" items="${selectedList}">
								<a href="boardDetail.do?board_idx=${list.board_idx}&board_type=${list.board_type}">
								<p class="my_list_title">${list.b_subject}</p></a>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="my_list my_camping_list">
				<h4 class="my_title">관심 캠핑장</h4>
				<button class="more_list"
					onclick="handleMyFavList(${mvo.member_idx})">+</button>
				<div class="my_list_summery">
				<c:choose>
						<c:when test="${empty campMap }">
							<h4 class="nolist">관심캠핑장이 없습니다.</h4>
						</c:when>
						<c:otherwise>
							<c:forEach var="entry" items="${campMap}">
					<a class="my_list_camping" href="campDetail.do?contentid=${entry.key}"> ${entry.value}</a>
					</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

		</div>
	</div>
	  <%@ include file="../hs/footer.jsp"%>
</body>
</html>