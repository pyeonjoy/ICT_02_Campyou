<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>동행 신청 내역</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/80123590ac.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${path}/resources/public/css/bjs/together_history.css">
<link rel="stylesheet" href="${path}/resources/css/menu_aside.css" />
<%@ include file="../hs/header.jsp" %>
<%@ include file="../hs/mypage_menu.jsp"%>
<script type="text/javascript">
$(function() {
    promiseApplyList();
    
    $('.thwrapper').on('click', '.acceptButton', function() {
    	let pmIdx = $(this).closest('.thul2').find("#pm_idx").val();
    	let promiseText = $(this).closest('.thul2').find(".compare").text();
        let promiseCount = promiseText.split('/')[0];
        let totalNumPeople = promiseText.split('/')[1];
        if (parseInt(promiseCount) >= parseInt(totalNumPeople)) {
            alert("정원이 초과되었습니다.");
            return;
        }
        updatePromiseStatus(pmIdx, '수락');
    });

    $('.thwrapper').on('click', '.rejectButton', function() {
    	let pmIdx = $(this).closest('.thul2').find("#pm_idx").val();
        updatePromiseStatus(pmIdx, '거절');
    });
});

function updatePromiseStatus(pmIdx, status) {
	let url;
    if (status === "수락") {
        url = 'acceptPromise.do';
    } else if (status === "거절") {
        url = 'declinePromise.do';
    }
    $.ajax({
        url: url,
        type: 'post',
        data: {
            pm_idx: pmIdx,
        },
        dataType: 'json',
        success: function(data) {
        	promiseApplyList();
        },
        error: function(xhr, status, error) {
            console.error(error);
        }
    });
}


function promiseApplyList(page) {
	let memberIdx = document.getElementById("member_idx").value;
    	$('.thwrapper').empty();
    $.ajax({
        url: 'get_together_history.do',
        type: 'post',
        data: {
            member_idx: memberIdx,
            cPage: page
        },
        dataType: 'json',
        success: function(data) {
        	let toHistory = data.toHistory;
        	if (toHistory != null && toHistory.length > 0) {
//                 let imgSrc = toHistory.member_img === null || toHistory.member_img === '' || toHistory.member_img === 'user2.png' ? '${path}/resources/images/user2.png' : '${path}/resources/images/' + toHistory.member_img;
                let html = '';
            	html += '<div class="thwrapper1">';

                html += '<button type="button" class="thwrapper1Button thwrapper1Button_active" onclick="promiseApplyList()">동행 신청 받은 내역</button>';
                html += '<button type="button" class="thwrapper1Button" onclick="promiseApplySendList()">동행 신청 내역</button>';
                html += '</div>';
                html += '<ul class="thul1">';
                html += '<li class="thli th1">이미지</li>';
                html += '<li class="thli th1">닉네임(나이)(동행경험)</li>';
                html += '<li class="thli th1">캠핑장</li>';
                html += '<li class="thli th1">동행날짜</li>';
                html += '<li class="thli th1">인원</li>';
                html += '<li class="thli th1">신청상태</li>';
                html += '</ul>';
                for (let i = 0; i < toHistory.length; i++) {
                    let promise = toHistory[i];
	                let html2 = '<div class="thul2">';
	                html2 += '<ul class="thliImage3 profile_show"><li class="th1 thliImage"><img src="${path}/resources/images/' + promise.member_img + '" class="qa11 thliImage2"></a></li></ul>';
	                html2 += '<ul><li class="th1 member_gradeLi profile_show">' + promise.member_nickname + '<img src="${path}/resources/images/' + promise.member_grade + '" class="member_gradeImg" >(' + promise.member_dob + ')(' + promise.promise_my_count + ')</li></ul>';
	                html2 += '<ul><li class="th1"><a href="together_detail.do?t_idx=' + promise.t_idx + '&cPage=1" class="qa11">' + promise.t_campname + '</a></li></ul>';
	                html2 += '<ul><li class="th1"><a href="together_detail.do?t_idx=' + promise.t_idx + '&cPage=1" class="qa11">' + promise.t_startdate + '-' + promise.t_enddate + '</a></li></ul>';
	                html2 += '<ul><li class="th1"><a href="together_detail.do?t_idx=' + promise.t_idx + '&cPage=1" class="qa11 compare">' + promise.promise_count + '/' + promise.t_numpeople + '</a></li></ul>';
	                if (promise.pm_state === "신청중") {
	                    html2 += '<div class="thul2Div">';
	                    html2 += '<button type="button" class="thul2DivButton acceptButton" onclick="">수락</button>';
	                    html2 += '<button type="button" class="thul2DivButton rejectButton" onclick="">거절</button>';
	                    html2 += '<input type="hidden" id="pm_idx" value="' + promise.pm_idx + '">';
	                    html2 += '</div>';
	                } else {
	                    html2 += '<ul><li class="th1">' + promise.pm_state + '</li></ul>';
	                }
	                html2 += '</div>';
	                html += html2;
                }
         		$('.thwrapper').append(html);
        	} else {
        		let html = '';
            	html += '<div class="thwrapper1">';
            	html += '<button type="button" class="thwrapper1Button thwrapper1Button_active" onclick="promiseApplyList()">동행 신청 받은 내역</button>';
                html += '<button type="button" class="thwrapper1Button" onclick="promiseApplySendList()">동행 신청 내역</button>';
                html += '</div>';
                html += '<ul class="thul1">';
                html += '<li class="thli th1">이미지</li>';
                html += '<li class="thli th1">닉네임(나이)(동행경험)</li>';
                html += '<li class="thli th1">캠핑장</li>';
                html += '<li class="thli th1">동행날짜</li>';
                html += '<li class="thli th1">인원</li>';
                html += '<li class="thli th1">신청상태</li>';
                html += '</ul>';
                html += '<div class="thul5">';
        		html += '<div class="no-data-message">';
        		html += '<p class="no-data-messageP">받은 동행신청이 없습니다.</p>';
        		html += '</div>';
        		html += '</div>';
                $('.thwrapper').append(html);
            }

            let paging = data.paging;
            $('.th_paging').empty();
            let pagingHtml = '';
         	// 이전 버튼
            if (paging.beginBlock <= paging.pagePerBlock) {
                pagingHtml += '<li class="th_disable"><i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
                pagingHtml += '<li class="th_disable"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
            } else {
                pagingHtml += '<li><a href="javascript:promiseApplyList(' + 1 + ')" class="th_able"><i class="fa-solid fa-angles-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
                pagingHtml += '<li><a href="javascript:promiseApplyList(' + (paging.beginBlock - paging.pagePerBlock) + ')" class="th_able"><i class="fa-solid fa-chevron-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
            }
            // 페이지번호들
            for (let k = paging.beginBlock; k <= paging.endBlock; k++) {
                if (k === paging.nowPage) {
                	pagingHtml += '<li class="nowpagecolor">' + k + '</li>';
                } else {
                	pagingHtml += '<li><a href="javascript:promiseApplyList(' + k + ')" class="nowpage">' + k + '</a></li>';
                }
            }
            // 이후 버튼
            if (paging.endBlock >= paging.totalPage) {
                pagingHtml += '<li class="th_disable"><i class="fa-solid fa-chevron-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
                pagingHtml += '<li class="th_disable"><i class="fa-solid fa-angles-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
            } else {
                pagingHtml += '<li><a href="javascript:promiseApplyList(' + (paging.beginBlock + paging.pagePerBlock) + ')" class="th_able"><i class="fa-solid fa-chevron-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
                pagingHtml += '<li><a href="javascript:promiseApplyList(' + paging.totalPage + ')" class="th_able"><i class="fa-solid fa-angles-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
            }
            $('.th_paging').append(pagingHtml);
        },
        error: function(xhr, status, error) {
        	console.error(error);
        }
    });
};
function promiseApplySendList(page) {
	let memberIdx = document.getElementById("member_idx").value;
    	$('.thwrapper').empty();
    $.ajax({
        url: 'get_together_send_history.do',
        type: 'post',
        data: {
            member_idx: memberIdx,
            cPage: page
        },
        dataType: 'json',
        success: function(data) {
        	let toSendHistory = data.toSendHistory;
        	if (toSendHistory != null && toSendHistory.length > 0) {
//                 let imgSrc = toHistory.member_img === null || toHistory.member_img === '' || toHistory.member_img === 'user2.png' ? '${path}/resources/images/user2.png' : '${path}/resources/images/' + toHistory.member_img;
                let html = '';
            	html += '<div class="thwrapper1">';
            	html += '<button type="button" class="thwrapper1Button" onclick="promiseApplyList()">동행 신청 받은 내역</button>';
                html += '<button type="button" class="thwrapper1Button thwrapper1Button_active" onclick="promiseApplySendList()">동행 신청 내역</button>';
                html += '</div>';
                html += '<ul class="thul3">';
                html += '<li class="thli th1">주최자</li>';
                html += '<li class="thli th1">캠핑장</li>';
                html += '<li class="thli th1">동행날짜</li>';
                html += '<li class="thli th1">인원</li>';
                html += '<li class="thli th1">신청날짜</li>';
                html += '<li class="thli th1">신청상태</li>';
                html += '</ul>';
                for (let i = 0; i < toSendHistory.length; i++) {
                    let promise = toSendHistory[i];
	                let html2 = '<div class="thul4">';
	                html2 += '<ul><li class="th1 profile_show">' + promise.member_nickname + '</li></ul>';

	                html2 += '<ul><li class="th1"><a href="together_detail.do?t_idx=' + promise.t_idx + '&cPage=1" class="qa11">' + promise.t_campname + '</a></li></ul>';
	                html2 += '<ul><li class="th1"><a href="together_detail.do?t_idx=' + promise.t_idx + '&cPage=1" class="qa11">' + promise.t_startdate + '-' + promise.t_enddate + '</a></li></ul>';
	                html2 += '<ul><li class="th1"><a href="together_detail.do?t_idx=' + promise.t_idx + '&cPage=1" class="qa11">' + promise.promise_count + '/' + promise.t_numpeople + '</a></li></ul>';
	                html2 += '<ul><li class="th1"><a href="together_detail.do?t_idx=' + promise.t_idx + '&cPage=1" class="qa11">' + promise.pm_regdate + '</a></li></ul>';
	                html2 += '<ul><li class="th1"><a href="together_detail.do?t_idx=' + promise.t_idx + '&cPage=1" class="qa11">' + promise.pm_state + '</a></li></ul>';
	                html2 += '</div>';
	                html += html2;
                }
         		$('.thwrapper').append(html);
        	} else {
        		let html = '';
            	html += '<div class="thwrapper1">';
            	html += '<button type="button" class="thwrapper1Button" onclick="promiseApplyList()">동행 신청 받은 내역</button>';
                html += '<button type="button" class="thwrapper1Button thwrapper1Button_active" onclick="promiseApplySendList()">동행 신청 내역</button>';
                html += '</div>';
                html += '<ul class="thul1">';
                html += '<li class="thli th1">주최자</li>';
                html += '<li class="thli th1">캠핑장</li>';
                html += '<li class="thli th1">동행날짜</li>';
                html += '<li class="thli th1">인원</li>';
                html += '<li class="thli th1">신청날짜</li>';
                html += '<li class="thli th1">신청상태</li>';
                html += '</ul>';
                html += '<div class="thul5">';
        		html += '<div class="no-data-message">';
        		html += '<p class="no-data-messageP">보낸 동행신청이 없습니다.</p>';
        		html += '</div>';
        		html += '</div>';
                $('.thwrapper').append(html);

            }

            let paging = data.paging;
            $('.th_paging').empty();
            let pagingHtml = '';
         	// 이전 버튼
            if (paging.beginBlock <= paging.pagePerBlock) {
                pagingHtml += '<li class="th_disable"><i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
                pagingHtml += '<li class="th_disable"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
            } else {
                pagingHtml += '<li><a href="javascript:promiseApplyList(' + 1 + ')" class="th_able"><i class="fa-solid fa-angles-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
                pagingHtml += '<li><a href="javascript:promiseApplyList(' + (paging.beginBlock - paging.pagePerBlock) + ')" class="th_able"><i class="fa-solid fa-chevron-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
            }
            // 페이지번호들
            for (let k = paging.beginBlock; k <= paging.endBlock; k++) {
                if (k === paging.nowPage) {
                	pagingHtml += '<li class="nowpagecolor">' + k + '</li>';
                } else {
                	pagingHtml += '<li><a href="javascript:promiseApplyList(' + k + ')" class="nowpage">' + k + '</a></li>';
                }
            }
            // 이후 버튼
            if (paging.endBlock >= paging.totalPage) {
                pagingHtml += '<li class="th_disable"><i class="fa-solid fa-chevron-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
                pagingHtml += '<li class="th_disable"><i class="fa-solid fa-angles-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
            } else {
                pagingHtml += '<li><a href="javascript:promiseApplyList(' + (paging.beginBlock + paging.pagePerBlock) + ')" class="th_able"><i class="fa-solid fa-chevron-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
                pagingHtml += '<li><a href="javascript:promiseApplyList(' + paging.totalPage + ')" class="th_able"><i class="fa-solid fa-angles-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
            }
            $('.th_paging').append(pagingHtml);
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
<!-- 			<div class="thwrapper1"> -->
<!-- 				<button type="button" name="" class="thwrapper1Button" onclick="">동행 신청 받은 내역</button> -->
<!-- 				<button type="button" name="" class="thwrapper1Button" onclick="">동행 신청 내역</button> -->
<!-- 			</div> -->
<!-- 			<ul class="thul1"> -->
<!-- 				<li class="thli th1">이미지</li> -->
<!-- 				<li class="thli th1">닉네임(나이)(동행경험)</li> -->
<!-- 				<li class="thli th1">캠핑장</li> -->
<!-- 				<li class="thli th1">동행날짜</li> -->
<!-- 				<li class="thli th1">인원</li> -->
<!-- 				<li class="thli th1">신청상태</li> -->
<!-- 			</ul> -->
<!-- 			<div class="thul2"> -->
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
<!--      		</div> -->
		</div>
   		<input type="hidden" id="member_idx" value="${member_idx }">
		<div class="thwrapper2">
			<ul class="th_paging">
<%-- 				<c:choose> --%>
<%-- 					<c:when test="${paging.beginBlock <= paging.pagePerBlock }"> --%>
<!-- 						<li class="th_disable"><i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li> -->
<!-- 						<li class="th_disable"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li> -->
<%-- 					</c:when> --%>
<%-- 					<c:otherwise> --%>
<!-- 						<li> -->
<!-- 							<a href="together_list.do?cPage=1" class="th_able"><i class="fa-solid fa-angles-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a> -->
<!-- 		                </li> -->
<!-- 		                <li> -->
<%--                  				<a href="together_list.do?cPage=${paging.beginBlock - paging.pagePerBlock }" class="th_able"><i class="fa-solid fa-chevron-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a> --%>
<!-- 						</li> -->
<%-- 					</c:otherwise> --%>
<%-- 				</c:choose> --%>
	
<!-- 				페이지번호들 -->
<%-- 				<c:forEach begin="${paging.beginBlock }" end="${paging.endBlock }" step="1" var="k"> --%>
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${k == paging.nowPage }"> --%>
<%-- 							<li class="nowpagecolor">${k }</li> --%>
<%-- 						</c:when> --%>
<%-- 						<c:otherwise> --%>
<%-- 							<li><a href="together_list.do?cPage=${k}" class="nowpage">${k}</a></li> --%>
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
<%-- 				</c:forEach> --%>
				
<!-- 				이후 버튼 -->
<%-- 				<c:choose> --%>
<%-- 					<c:when test="${paging.endBlock >= paging.totalPage }"> --%>
<!-- 						<li class="th_disable"><i class="fa-solid fa-chevron-right" style="color: white; border-radius: 50%; font-size: 1.2rem;"></i></li> -->
<!-- 						<li class="th_disable"><i class="fa-solid fa-angles-right" style="color: white; border-radius: 50%; font-size: 1.2rem;"></i></li> -->
<%-- 					</c:when> --%>
<%-- 					<c:otherwise> --%>
<!-- 						<li> -->
<%-- 							<a href="together_list.do?cPage=${paging.beginBlock + paging.pagePerBlock }" class="th_able"><i class="fa-solid fa-chevron-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a> --%>
<!-- 		                </li> -->
<!-- 		                <li> -->
<%-- 		                    <a href="together_list.do?cPage=${paging.totalPage}" class="th_able"><i class="fa-solid fa-angles-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a> --%>
<!-- 						</li> -->
<%-- 					</c:otherwise> --%>
<%-- 				</c:choose> --%>
			</ul>
		</div>	
	</div>
<%@ include file="../hs/footer.jsp" %>
</body>
</html>