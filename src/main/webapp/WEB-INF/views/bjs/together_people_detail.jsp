<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.time.LocalDate" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>동행 현황</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/80123590ac.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${path}/resources/public/css/bjs/together_people_detail.css">
<link rel="stylesheet" href="${path}/resources/css/menu_aside.css" />
<%@ include file="../hs/header.jsp" %>
<%@ include file="../hs/mypage_menu.jsp"%>
<style>
.modal {
	/*팝업 배경*/
	display: none;
            width: 100%;
            height: 100%;
            position: fixed;
            top: 0;
            left: 0;
            background-color: rgba(0,0,0,0.5);
            justify-content: center;
            align-items: center;
}

.modal .modal_popup {
	/*팝업*/
	position: absolute;
	top: 70%;
    left: 42%;
    width: 300px;
	transform: translate(-50%, -50%);
	padding: 20px;
	background: #ffffff;
	border-radius: 20px;
	box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
}
/*모달 팝업 영역 스타일링*/
.modal2 {
	/*팝업 배경*/
	display: none;
    width: 10px;
    height: 0px;
}

.modal2 .modal_popup2 {
	/*팝업*/
	position: absolute;
    top: 71%;
    left: 44%;
	transform: translate(-50%, -50%);
	padding: 20px;
	background: #ffffff;
	border-radius: 20px;
	box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
}
.wrap {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    gap: 32px;
}

h1 {
    font-size: 40px;
    font-weight: 600;
}

.rating {
    float: none;
    width: 240px;
    display: flex;
}

.rating__input {
    display: none;
}

.rating__label {
    width: 20px;
    overflow: hidden;
    cursor: pointer;
}

.rating__label .star-icon {
    width: 20px;
    height: 40px;
    display: block;
    position: relative;
    left: 0;
    background-image: url(${path}/resources/images/ico-star-empty.png);
    background-repeat: no-repeat;
    background-size: 40px;
}

.rating__label .star-icon.filled {
    background-image: url(${path}/resources/images/ico-star.png);
}

.rating__label--full .star-icon {
    background-position: right;
}

.rating__label--half .star-icon {
    background-position: left;
}

.rating.readonly .star-icon {
    opacity: 0.7;
    cursor: default;
}

}

</style>
</head>
<body>
	<form method="post" class="thcontainer">
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
        <input type="hidden" id="promise_status" value="${tvo.promise_status }">
		<div class="thwrapper">
			<c:choose>
				<c:when test="${tvo.promise_status == 'ing' }">
					<h3>${tvo.t_campname } 동행 모집중</h3>
				</c:when>
				<c:when test="${tvo.promise_status == 'ready' }">
					<h3>${tvo.t_campname } 동행 진행중</h3>
				</c:when>
				<c:when test="${tvo.promise_status == 'end' }">
					<h3>${tvo.t_campname } 동행 완료</h3>
				</c:when>
			</c:choose>
			<h4>${tvo.promise_count } / ${tvo.t_numpeople } 명</h4>
			<div class="thDiv">
				<p>${tvo.t_startdate } - ${tvo.t_enddate }</p>
				<p>${tvo.t_induty }</p>
				<c:if test="${tvo.promise_status == 'ready' }">
					<c:set var="currentDate" value="<%= LocalDate.now() %>"/>
					<c:if test="${tvo.t_enddate <= currentDate}">
						<p style="color: red;">** 동행이 완료되셨으면 동행완료 버튼을 클릭해주세요 **</p>
					</c:if>
				</c:if>
<%-- 				<c:if test="${tvo.promise_status == 'ing' }"> --%>
<!-- 					<p style="color: blue;">**  **</p> -->
<%-- 				</c:if> --%>
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
     		<div class="thul3">
     		</div>
		</div>
	</form>
	
	<div class="modal">
		<div class="modal_popup">
			<div class="wrap">
				<h1>Star rating</h1>
				<div>
				<form id="star_form" class="rating">
					<label class="rating__label rating__label--half" for="starhalf">
						<input type="radio" id="starhalf" class="rating__input" name="new_rating" value="1"> <span class="star-icon"></span>
					</label> 
					
					<label class="rating__label rating__label--full" for="star1">
						<input type="radio" id="star1" class="rating__input" name="new_rating" value="2"> <span class="star-icon"></span>
					</label> 
					
					<label class="rating__label rating__label--half" for="star1half">
						<input type="radio" id="star1half" class="rating__input" name="new_rating" value="3"> <span class="star-icon"></span>
					</label> 
					
					<label class="rating__label rating__label--full" for="star2">
						<input type="radio" id="star2" class="rating__input" name="new_rating" value="4"> <span class="star-icon"></span>
					</label> 
					
					<label class="rating__label rating__label--half" for="star2half">
						<input type="radio" id="star2half" class="rating__input" name="new_rating" value="5"> <span class="star-icon"></span>
					</label> 
					
					<label class="rating__label rating__label--full" for="star3">
						<input type="radio" id="star3" class="rating__input" name="new_rating" value="6"> <span class="star-icon"></span>
					</label> 
					
					<label class="rating__label rating__label--half" for="star3half">
						<input type="radio" id="star3half" class="rating__input" name="new_rating" value="7" checked> <span class="star-icon"></span>
					</label> 
					
					<label class="rating__label rating__label--full" for="star4">
						<input type="radio" id="star4" class="rating__input" name="new_rating" value="8"> <span class="star-icon"></span>
					</label> 
					
					<label class="rating__label rating__label--half" for="star4half">
						<input type="radio" id="star4half" class="rating__input" name="new_rating" value="9"> <span class="star-icon"></span>
					</label> 
					
					<label class="rating__label rating__label--full" for="star5">
						<input type="radio" id="star5" class="rating__input" name="new_rating" value="10"> <span class="star-icon"></span>
					</label>
					<input type="submit" value="선택"/>
				</form> 
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
$(document).ready(function() {
	$(document).on('click', '.modal_btn', function() {
		let memberIdx = $(this).siblings('#memberIdx').val();
// 		let giveMemberIdx = $(this).siblings('#give_memberIdx').val();
// 		let tIdx = document.getElementById("t_idx").value;
	    $('#star_form').data('memberIdx', memberIdx);
// 	    $('#star_form').data('giveMemberIdx', giveMemberIdx);
// 	    $('#star_form').data('tIdx', tIdx);
	    $('.modal').css('display', 'block');
	});
	
	$('#star_form').submit(function(e) {
        e.preventDefault();
        let tIdx = document.getElementById("t_idx").value;
        let giveMemberIdx = document.getElementById("member_idx").value;
        let member_idx = $(this).data('memberIdx');
//         let give_member_idx = $(this).data('giveMemberIdx');
        let new_rating = $("input[name='new_rating']:checked").val();
        let requestData = {
            new_rating: new_rating,
            t_idx: tIdx,
            take_member_idx: member_idx,
            give_member_idx: giveMemberIdx
        };

        $.ajax({
            url: 'addstarok.do',
            type: 'post',
            contentType: 'application/json',
            data: JSON.stringify(requestData),
            success: function(data) {
                if (data != "error") {
                    alert("별점이 등록되었습니다.");
                    $("input[name='new_rating']").prop('checked', false);
                    $('.modal').css('display', 'none');
                    location.reload();
                } else {
                    alert("오류가 발생하였습니다.");
                }
            },
            error: function(xhr, status, error) {
//                 console.error(error);
//                 alert("로그인 후 이용 부탁드립니다.");
//                 location.href = 'login_form.do';
            }
        });
    });
	
	$(document).on('click', function(event) {
        if (!$(event.target).closest('.modal_popup').length && !$(event.target).closest('.modal_btn').length) {
            $('.modal').css('display', 'none');
        }
    });
});
</script>
<script>
        const rateWrap = document.querySelectorAll('.rating'), // 모든 rating 요소
        label = document.querySelectorAll('.rating .rating__label'), // 모든 rating__label 요소
        input = document.querySelectorAll('.rating .rating__input'), // 모든 rating__input 요소
        labelLength = label.length, // label 요소의 개수
        opacityHover = '1'; // 호버 시 불투명도

let stars = document.querySelectorAll('.rating .star-icon'); // 모든 star-icon 요소

function checkedRate() {
    let checkedRadio = document.querySelectorAll('.rating input[type="radio"]:checked'); // 체크된 라디오 버튼

    initStars(); // 모든 별 초기화
    checkedRadio.forEach(radio => {
        let previousSiblings = prevAll(radio);

        for (let i = 0; i < previousSiblings.length; i++) {
            previousSiblings[i].querySelector('.star-icon').classList.add('filled'); // 체크된 라디오 버튼 이전 별들 채움
        }

        radio.nextElementSibling.classList.add('filled'); // 체크된 라디오 버튼의 별 채움

        function prevAll() {
            let radioSiblings = [],
                prevSibling = radio.parentElement.previousElementSibling; // 이전 형제 요소

            while (prevSibling) {
                radioSiblings.push(prevSibling); // 이전 형제 요소 추가
                prevSibling = prevSibling.previousElementSibling; // 다음 이전 형제 요소
            }
            return radioSiblings;
        }
    });
}

checkedRate(); // 초기 별점 설정

rateWrap.forEach(wrap => {
    wrap.addEventListener('mouseenter', () => {
        stars = wrap.querySelectorAll('.star-icon'); // 현재 rating의 star-icon 요소들

        stars.forEach((starIcon, idx) => {
            starIcon.addEventListener('mouseenter', () => {
                initStars(); 
                filledRate(idx, labelLength); 

                for (let i = 0; i < stars.length; i++) {
                    if (stars[i].classList.contains('filled')) {
                        stars[i].style.opacity = opacityHover; // 채워진 별의 불투명도 설정
                    }
                }
            });

            starIcon.addEventListener('mouseleave', () => {
                starIcon.style.opacity = '1'; // 별의 불투명도 원래대로 설정
                checkedRate(); 
            });

            wrap.addEventListener('mouseleave', () => {
                starIcon.style.opacity = '1'; // 별의 불투명도 원래대로 설정
            });
        });
    });
});

function filledRate(index, length) {
    if (index <= length) {
        for (let i = 0; i <= index; i++) {
            stars[i].classList.add('filled'); // index까지의 별을 채움
        }
    }
}

function initStars() {
    for (let i = 0; i < stars.length; i++) {
        stars[i].classList.remove('filled'); // 모든 별 초기화
    }
}
</script>
<script type="text/javascript">
	let promiseStatus = document.getElementById("promise_status").value;
$(function() {
	promisePeopleDetail();
});

function promisePeopleDetail() {
	let tIdx = document.getElementById("t_idx").value;
	let memberIdx = document.getElementById("member_idx").value;
	let page = document.getElementById("cPage").value;
	let tStartdate = document.getElementById("t_startdate").value;
	let tEnddate = document.getElementById("t_enddate").value;
   	$('.thul2').empty();
   	$('.thul3').empty();
    $.ajax({
        url: 'promise_people_detail.do',
        type: 'post',
        data: {
            t_idx: tIdx
        },
        dataType: 'json',
        success: function(data) {
			let html = '';
			let memberIdxArray = [];
        	if (data != null && data.length > 0) {
//                 let imgSrc = data.member_img === null || data.member_img === '' || data.member_img === 'user2.png' ? '${path}/resources/images/user2.png' : '${path}/resources/images/' + data.member_img;
                for (let i = 0; i < data.length; i++) {
                    let proPeopleDetail = data[i];
                    console.log(proPeopleDetail.pm_master);
                    memberIdxArray.push(proPeopleDetail.member_idx);
                    if(proPeopleDetail.member_img == 'user2.png'){
                    	html += '<div class="thliImage3"><img src="${path}/resources/images/' + proPeopleDetail.member_img + '" class="thliImage2 profile_show" data-memberidx="'+proPeopleDetail.member_idx+'"></div>';
                    }else{
		                html += '<div class="thliImage3"><img src="${path}/resources/images/' + proPeopleDetail.member_img + '" class="thliImage2 profile_show" data-memberidx="'+proPeopleDetail.member_idx+'"></div>';
                    }
	                html += '<ul><li class="th1 member_gradeLi profile_show" data-memberidx="' + proPeopleDetail.member_idx + '">';
	                html += proPeopleDetail.member_nickname;
	                html += '<img src="${path}/resources/images/' + proPeopleDetail.member_grade + '" class="member_gradeImg">';
	                if(proPeopleDetail.pm_master == 1) {
	                    html += '<i class="fa-solid fa-crown" style="color: #FFD43B;"></i>';
	                }
	                if(proPeopleDetail.member_idx == memberIdx) {
	                    html += '<i class="fa-solid fa-user"></i>';
	                }
	                html += '</li></ul>';
	                html += '<ul><li class="th1">' + proPeopleDetail.member_dob + '</li></ul>';
	                html += '<ul><li class="th1">' + proPeopleDetail.promise_my_count + '</li></ul>';
                    html += '<div class="thul2Div">';
                   	if(promiseStatus == "end"){
                   		if (proPeopleDetail.member_idx != memberIdx) {
	                   		console.log("체크하러?");
	                   		checkRating(proPeopleDetail.member_idx, tIdx, memberIdx, function(result) {
	                   			console.log("체크결과", result);
	                   			let htmlStar = '';
	                            if(result > 0){
	                                console.log("결과도착");
	                                htmlStar += '<ul><li class="th1">별점 완료</li></ul>';
	                            } else {
	                            	htmlStar += '<button type="button" class="thul2DivButton modal_btn" id="modal_btn">별 점</button>';
	                            	htmlStar += '<input type="hidden" id="memberIdx" value="' + proPeopleDetail.member_idx + '">';
// 		                    		html += '<input type="hidden" id="give_memberIdx" value="' + memberIdx + '">';
	                            }
	                            $('.thul2').find('.thul2Div').eq(i).append(htmlStar);
	                   		});
                   		}
                   	}else {
                   		if(proPeopleDetail.pm_master == 0) {
                   			html += '<button type="button" class="thul2DivButton banish_button" onclick="banishMember(' + proPeopleDetail.member_idx + ')" style="display:none;">추방하기</button>';
                   		}
                   	}
                   html += '</div>';
                }
                
         		$('.thul2').append(html);
                for (let j = 0; j < data.length; j++) {
                    if (data[j].pm_master == 1 && data[j].member_idx == memberIdx) {
                        $('.banish_button').css('display', 'block');
                    }
                }
         		let html2 = '';
                html2 += '<div class="partnerListButtonDiv">';
                for (let j = 0; j < data.length; j++) {
                	if (promiseStatus == "ing" && data[j].pm_master == 1 && data[j].member_idx == memberIdx) {
                        html2 += '<button type="button" class="thul2DivButton" onclick="promise_confirm(' + tIdx + ',' + memberIdx + ',\'' + tStartdate + '\', \'' + JSON.stringify(memberIdxArray).replace(/"/g, '&quot;') + '\')" style="margin-right: 3rem;">동행 확정</button>';
                    }
                    if (promiseStatus == "ready" && data[j].pm_master == 1 && data[j].member_idx == memberIdx) {
                        html2 += '<button type="button" class="thul2DivButton" onclick="confirm_partner(' + tIdx + ',' + memberIdx + ',\'' + tEnddate + '\', \'' + JSON.stringify(memberIdxArray).replace(/"/g, '&quot;') + '\')" style="margin-right: 3rem;">동행 완료</button>';
                    }
                }
                html2 += '<button type="button" class="thul2DivButton" onclick="partner_list(' + page + ',' + memberIdx + ',\'' + promiseStatus + '\')">목 록</button>';
                html2 += '</div>';
         		$('.thul3').append(html2);
        	} else {
                html += '<div class="thul5">';
        		html += '<div class="no-data-message">';
        		html += '<p class="no-data-messageP">모집된 동행이 없습니다.</p>';
        		html += '</div>';
        		html += '</div>';
        		html += '<div class="partnerListButtonDiv">';
                html += '<button type="button" class="thul2DivButton" onclick="partner_list(' + page + ',' + memberIdx + ',\'' + promiseStatus + '\')">목 록</button>';
                html += '</div>';
                $('.thul2').replaceWith(html);
            }
        },
        error: function(xhr, status, error) {
        	console.error(error);
        }
    });
};

function checkRating(proPeopleDetailMemberIdx, tIdx, memberIdx, callback) {
	console.log("체크왔다");
    $.ajax({
        url: "star_rating_check.do",
        type: "POST",
        data: { 
        	take_member_idx: proPeopleDetailMemberIdx,
            t_idx: tIdx,
            give_member_idx: memberIdx
        },
        success: function(response) {
        	console.log("체크끝났다");
            callback(response);
        },
        error: function(xhr, status, error) {
            console.error(error);
        }
    });
}

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
function partner_list(page, memberIdx, promiseStatus) {
	location.href = "together_partner.do?cPage=" + page + "&promise_status=" + promiseStatus;
}
function promise_confirm(tIdx, memberIdx, tStartdate, memberIdxArray) {
	let currentDate = new Date();
	let t_startdate = new Date(tStartdate);
	
	let message = '';
	if (currentDate < t_startdate) {
		message = '*주의* 동행 날짜가 맞지 않습니다. 동행 확정하시겠습니까?\n동행의 시작 날짜가 변경됩니다.';
	}
	if(confirm(message)){
		let parseMemberIdxArray = JSON.parse(memberIdxArray);
		$.ajax({
	        url: 'promise_confirm.do',
	        type: 'post',
	        data: {
	            t_idx: tIdx,
	            member_idx: parseMemberIdxArray,
	            t_startdate: t_startdate
	        },
	        traditional: true, // 배열 데이터를 전송할 때 사용
	        success: function(response) {
	        	partner_list(1, memberIdx, 'ready');
	        },
	        error: function(xhr, status, error) {
	            console.error(error);
	        }
	    });
	}else{
		return;
	}
}

function confirm_partner(tIdx, memberIdx, tEnddate, memberIdxArray) {
	let currentDate = new Date();
	let endDate = new Date(tEnddate);
	
	let message = '';
	if (currentDate < endDate) {
		message = '*주의* 동행 날짜가 맞지 않습니다. 동행 완료하시겠습니까?\n동행의 마지막 날짜가 변경됩니다.';
	} else {
		message = '동행 완료하시겠습니까?';
	}
	if(confirm(message)){
		let parseMemberIdxArray = JSON.parse(memberIdxArray);
		$.ajax({
	        url: 'confirm_partner.do',
	        type: 'post',
	        data: {
	            t_idx: tIdx,
	            member_idx: parseMemberIdxArray,
	            t_enddate: tEnddate
	        },
	        traditional: true, // 배열 데이터를 전송할 때 사용
	        success: function(response) {
	        	partner_list(1, memberIdx, 'end');
	        },
	        error: function(xhr, status, error) {
	            console.error(error);
	        }
	    });
	}else{
		return;
	}
}


</script>
<%@ include file="../hs/footer.jsp" %>
<%@ include file="../hs/profile_small_info.jsp" %>
</body>
</html>