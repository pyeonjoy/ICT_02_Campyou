<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>together_history</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/80123590ac.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${path}/resources/public/css/bjs/together_people_detail.css">
<link rel="stylesheet" href="${path}/resources/css/menu_aside.css" />
<%@ include file="../hs/header.jsp" %>
<%@ include file="../hs/mypage_menu.jsp"%>
<script type="text/javascript">
$(function() {
	promisePeopleDetail();
    
//     $('.thwrapper').on('click', '.acceptButton', function() {
//     	let pmIdx = $(this).closest('.thul2').find("#pm_idx").val();
//     	let promiseText = $(this).closest('.thul2').find(".compare").text();
//         let promiseCount = promiseText.split('/')[0];
//         let totalNumPeople = promiseText.split('/')[1];
//         if (parseInt(promiseCount) >= parseInt(totalNumPeople)) {
//             alert("정원이 초과되었습니다.");
//             return;
//         }
//         updatePromiseStatus(pmIdx, '수락');
//     });

});

// function updatePromiseStatus(pmIdx, status) {
// 	let url;
//     if (status === "수락") {
//         url = 'acceptPromise.do';
//     } else if (status === "거절") {
//         url = 'declinePromise.do';
//     }
//     $.ajax({
//         url: url,
//         type: 'post',
//         data: {
//             pm_idx: pmIdx,
//         },
//         dataType: 'json',
//         success: function(data) {
//         	promiseApplyList();
//         },
//         error: function(xhr, status, error) {
//             console.error(error);
//         }
//     });
// }

function promisePeopleDetail() {
	let tIdx = document.getElementById("t_idx").value;
	let memberIdx = document.getElementById("member_idx").value;
	let page = document.getElementById("cPage").value;
   	$('.thul2').empty();
    $.ajax({
        url: 'promise_people_detail.do',
        type: 'post',
        data: {
            t_idx: tIdx,
        },
        dataType: 'json',
        success: function(data) {
			let html = '';
        	if (data != null && data.length > 0) {
//                 let imgSrc = data.proPeopleDetail.member_img === null || data.proPeopleDetail.member_img === '' || data.proPeopleDetail.member_img === 'user2.png' ? '${path}/resources/images/user2.png' : '${path}/resources/images/' + data.proPeopleDetail.member_img;
                for (let i = 0; i < data.length; i++) {
                    let proPeopleDetail = data[i];
	                html += '<div class="thliImage3"><img src="${path}/resources/images/' + proPeopleDetail.member_img + '" class="thliImage2"></div>';
	                html += '<ul><li class="th1">' + proPeopleDetail.member_nickname + '</li></ul>';
	                html += '<ul><li class="th1">' + proPeopleDetail.member_dob + '</li></ul>';
	                html += '<ul><li class="th1">' + proPeopleDetail.promise_my_count + '</li></ul>';
                    html += '<div class="thul2Div">';
                    if(proPeopleDetail.pm_master == 1){
                    	html += '<ul><li class="th1">방장(나)</li></ul>';
                    }else{
                   		html += '<button type="button" class="thul2DivButton" onclick="banishMember(' + proPeopleDetail.member_idx + ')">추방하기</button>';
                    }
                    html += '</div>';
                }
                html += '<div class="partnerListButtonDiv">';
                html += '<button type="button" class="thul2DivButton" onclick="partner_list(' + page + ',' + memberIdx + ')">목 록</button>';
                html += '</div>';
         		$('.thul2').append(html);
        	} else {
                html += '<div class="thul5">';
        		html += '<div class="no-data-message">';
        		html += '<p class="no-data-messageP">모집된 동행이 없습니다.</p>';
        		html += '</div>';
        		html += '</div>';
        		html += '<div class="partnerListButtonDiv">';
                html += '<button type="button" class="thul2DivButton" onclick="partner_list(' + page + ',' + memberIdx + ')">목 록</button>';
                html += '</div>';
                $('.thul2').replaceWith(html);
            }
        },
        error: function(xhr, status, error) {
        	console.error(error);
        }
    });
};

function banishMember(memberIdx) {
	let result = confirm("정말 추방하시겠습니까?");
    if (result) {
	    let tIdx = document.getElementById("t_idx").value;
		$.ajax({
	        url: 'promise_banish_member.do',
	        type: 'post',
	        data: {
	        	member_idx: memberIdx,
	            t_idx: tIdx
	        },
	        dataType: 'json',
	        success: function(data) {
	        	promisePeopleDetail();
	        },
	        error: function(xhr, status, error) {
	            console.error(error);
	        }
	    });
    }else{
    	return;
    }
}
function partner_list(page, memberIdx) {
    location.href="together_partner.do?cPage=" + page + "&member_idx=" + memberIdx;
}
</script>
</head>
<body>
	<form method="post" class="thcontainer">
		<div class="thwrapper">
			<h3>${tvo.t_campname } 동행 모집현황</h3>
			<h4>${tvo.promise_count } / ${tvo.t_numpeople } 명</h4>
			<div class="thDiv">
				<p>${tvo.t_startdate } - ${tvo.t_enddate }</p>
				<p>${tvo.t_induty }</p>
			</div>
			<ul class="thul1">
				<li class="thli th1">이미지</li>
				<li class="thli th1">닉네임</li>
				<li class="thli th1">나이대</li>
				<li class="thli th1">동행경험</li>
				<li class="thli th1">비 고</li>
			</ul>
			<div class="thul2">
<%-- 				<ul><li class="th1 thliImage"><a href="qa_detail.do?qa_idx=${k.qa_idx}&cPage=${paging.nowPage}" class="qa11">사진</a></li></ul> --%>
<%-- 				<ul><li class="th1"><a href="qa_detail.do?qa_idx=${k.qa_idx}&cPage=${paging.nowPage}" class="qa11">깡패(20대)(5)</a></li></ul> --%>
<%-- 				<ul><li class="th1"><a href="qa_detail.do?qa_idx=${k.qa_idx}&cPage=${paging.nowPage}" class="qa11">서울난지캠핑장</a></li></ul> --%>
<%-- 	            <ul><li class="th1"><a href="qa_detail.do?qa_idx=${k.qa_idx}&cPage=${paging.nowPage}" class="qa11">2024/05/08-2024/05/09</a></li></ul> --%>
<%-- 	            <ul><li class="th1"><a href="qa_detail.do?qa_idx=${k.qa_idx}&cPage=${paging.nowPage}" class="qa11">2 / 5</a></li></ul> --%>
<%-- 	<%--                 <li class="th1"><a href="qa_detail.do?qa_idx=${k.qa_idx}&cPage=${paging.nowPage}" class="th11">신청중</a></li> --%>
<!-- 				<div class="thul2Div"> -->
<!-- 					<button type="button" value="" class="thul2DivButton" onclick="">수락</button> -->
<!-- 					<button type="button" value="" class="thul2DivButton" onclick="">거절</button> -->
<!-- 	     		</div> -->
     		</div>
		</div>
   		<input type="hidden" id="t_idx" value="${tvo.t_idx }">
   		<input type="hidden" id="member_idx" value="${tvo.member_idx }">
        <input type="hidden" id="cPage" value="${cPage }">
        <input type="hidden" id="t_campname" value="${tvo.t_campname }">
        <input type="hidden" id="t_subject" value="${tvo.t_subject }">
        <input type="hidden" id="t_startdate" value="${tvo.t_startdate }">
        <input type="hidden" id="t_enddate" value="${tvo.t_enddate }">
        <input type="hidden" id="t_induty" value="${tvo.t_induty }">
        <input type="hidden" id="promise_count" value="${tvo.promise_count }">
        <input type="hidden" id="t_numpeople" value="${tvo.t_numpeople }">
	</form>
<%@ include file="../hs/footer.jsp" %>
</body>
</html>