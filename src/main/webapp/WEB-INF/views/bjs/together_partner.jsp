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
<script src="https://kit.fontawesome.com/80123590ac.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${path}/resources/public/css/bjs/together_partner.css">
<link rel="stylesheet" href="${path}/resources/css/menu_aside.css" />
<%@ include file="../hs/header.jsp" %>
<%@ include file="../hs/mypage_menu.jsp"%>
<script type="text/javascript">
// $(document).on("click", ".thwrapper1Button", function() {
// 	let toPromiseing = document.querySelector(".toContent");
// 	let toPromiseEnd = document.querySelector(".toContent2");
//     let parentDiv = $(this).closest(".toDetailContent4Sub3, .toDetailContent4Sub6");
//     let commentForm = parentDiv.find(".toDetailInputForm");
//     if (commentForm.css("display") === "none") {
//         commentForm.css("display", "flex");
//     } else {
//         commentForm.css("display", "none");
//     }
// });
$(function() {
	let cpage = document.getElementById("cPage").value;
	if(cpage != null){
		toPromiseIng(cpage);
	}else{
		toPromiseIng();
	}
});
function toPromiseIng(page) {
	let memberIdx = document.getElementById("member_idx").value;
   	$('.toContent, .thwrapper1').empty();
    $.ajax({
        url: 'get_promise_ing.do',
        type: 'post',
        data: {
            member_idx: memberIdx,
            cPage: page
        },
        dataType: 'json',
        success: function(data) {
        	let toPromiseIng = data.toPromiseIng;
        	let html2 = '';
        		html2 += '<button type="button" class="thwrapper1Button thwrapper1Button_active" onclick="toPromiseIng()">모집중인 동행</button>'
        		html2 += '<button type="button" class="thwrapper1Button" onclick="toPromiseReady()">진행중인 동행</button>'
        		html2 += '<button type="button" class="thwrapper1Button2" onclick="toPromiseEnd()">동행 완료</button>'
       			$('.thwrapper1').append(html2);
                let html = '';
        	if (toPromiseIng != null && toPromiseIng.length > 0) {
        		for (let i = 0; i < toPromiseIng.length; i++) {
                    let PromiseIng = toPromiseIng[i];
                    html += '<div class="toContentOne">';
                    html += '<div>';
                    html += '<div class="toContentOne1">';
                    html += '<div class="to_list_subject">' + PromiseIng.t_subject + '</div>';
                    html += '<div>';
                    html += '<div class="toContentOne1span toContentOne1span2">';
                    html += '<span>' + PromiseIng.t_campname + '</span>';
                    html += '<span class="to_campdate">' + PromiseIng.t_startdate + '-' + PromiseIng.t_enddate + '</span>';
                    html += '</div>';
                    html += '</div>';
                    html += '</div>';
                    html += '</div>';
                    html += '<div class="toContentOne2">';
                    if (!PromiseIng.tf_name) {
                        html += '<img src="${path}/resources/images/to_camp.jpg" class="toContentOne2img">';
                    } else {
                        html += '<img src="' + PromiseIng.tf_name + '" class="toContentOne2img">';
                    }
                    html += '<span class="toContentOne2sub2">' + PromiseIng.t_induty + '</span>';
                    html += '</div>';
                    html += '<div>';
                    html += '<div class="toContentOne3">';
                    html += '<p>조회수 : ' + PromiseIng.t_hit + '</p>';
                    html += '<p>모집 : ' + PromiseIng.promise_count + ' / ' + PromiseIng.t_numpeople + '명' + '</p>';
                    html += '</div>';
                    html += '<form method="post" class="toContentOne4">';
                    html += '<button type="button" class="toContentOne2" onclick="to_detail(' + PromiseIng.t_idx + ',' + data.paging.nowPage + ')">상세 보기<button>';
                    html += '<button type="button" class="toContentOne2" onclick="to_people_detail(this.form)">인원 보기<button>';
                    html += '<input type="hidden" name="t_idx" value="' + PromiseIng.t_idx + '">';
                    html += '<input type="hidden" name="cPage" value="' + data.paging.nowPage + '">';
                    html += '<input type="hidden" name="t_campname" value="' + PromiseIng.t_campname + '">';
                    html += '<input type="hidden" name="t_subject" value="' + PromiseIng.t_subject + '">';
                    html += '<input type="hidden" name="t_startdate" value="' + PromiseIng.t_startdate + '">';
                    html += '<input type="hidden" name="t_enddate" value="' + PromiseIng.t_enddate + '">';
                    html += '<input type="hidden" name="t_induty" value="' + PromiseIng.t_induty + '">';
                    html += '<input type="hidden" name="promise_count" value="' + PromiseIng.promise_count + '">';
                    html += '<input type="hidden" name="t_numpeople" value="' + PromiseIng.t_numpeople + '">';
                    html += '<input type="hidden" name="member_idx" value="' + memberIdx + '">';
                    html += '</form>';
                    html += '</div>';
                    html += '</div>';
                }
                $('.toContent').append(html);
            } else {
                html += '<div class="thul5">';
                html += '<div class="no-data-message">';
                html += '<p class="no-data-messageP">모집중인 동행이 없습니다</p>';
                html += '</div>';
                html += '</div>';
                $('.toContent').replaceWith(html);
            }
            let paging = data.paging;
            $('.to_paging').empty();
            let pagingHtml = '';
            // 이전 버튼
            if (paging.beginBlock <= paging.pagePerBlock) {
                pagingHtml += '<li class="to_disable"><i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
                pagingHtml += '<li class="to_disable"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
            } else {
                pagingHtml += '<li><a href="javascript:toPromiseIng(1)" class="to_able"><i class="fa-solid fa-angles-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
                pagingHtml += '<li><a href="javascript:toPromiseIng(' + (paging.beginBlock - paging.pagePerBlock) + ')" class="to_able"><i class="fa-solid fa-chevron-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
            }
            // 페이지번호들
            for (let k = paging.beginBlock; k <= paging.endBlock; k++) {
                if (k === paging.nowPage) {
                    pagingHtml += '<li class="nowpagecolor">' + k + '</li>';
                } else {
                    pagingHtml += '<li><a href="javascript:toPromiseIng(' + k + ')" class="nowpage">' + k + '</a></li>';
                }
            }
            // 이후 버튼
            if (paging.endBlock >= paging.totalPage) {
                pagingHtml += '<li class="to_disable"><i class="fa-solid fa-chevron-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
                pagingHtml += '<li class="to_disable"><i class="fa-solid fa-angles-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
            } else {
                pagingHtml += '<li><a href="javascript:toPromiseIng(' + (paging.beginBlock + paging.pagePerBlock) + ')" class="to_able"><i class="fa-solid fa-chevron-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
                pagingHtml += '<li><a href="javascript:toPromiseIng(' + paging.totalPage + ')" class="to_able"><i class="fa-solid fa-angles-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
            }
            $('.to_paging').append(pagingHtml);
        },
        error: function(xhr, status, error) {
            console.error(error);
        }
    });
}
function to_detail(t_idx, nowPage) {
    location.href = 'together_detail.do?t_idx=' + t_idx + '&cPage=' + nowPage;
}
function to_people_detail(f) {
	f.action="together_people_detail.do";
	f.submit();
}
function toPromiseReady(page) {
	let memberIdx = document.getElementById("member_idx").value;
   	$('.toContent, .thwrapper1').empty();
    $.ajax({
        url: 'get_promise_ready.do',
        type: 'post',
        data: {
            member_idx: memberIdx,
            cPage: page
        },
        dataType: 'json',
        success: function(data) {
        	let toPromiseReady = data.toPromiseReady;
        	let html2 = '';
        		html2 += '<button type="button" class="thwrapper1Button" onclick="toPromiseIng()">모집중인 동행</button>'
        		html2 += '<button type="button" class="thwrapper1Button thwrapper1Button_active" onclick="toPromiseReady()">진행중인 동행</button>'
        		html2 += '<button type="button" class="thwrapper1Button2" onclick="toPromiseEnd()">동행 완료</button>'
       			$('.thwrapper1').append(html2);
                let html = '';
        	if (toPromiseReady != null && toPromiseReady.length > 0) {
        		for (let i = 0; i < toPromiseReady.length; i++) {
                    let promiseReady = toPromiseReady[i];
                    html += '<div class="toContentOne">';
                    html += '<div>';
                    html += '<div class="toContentOne1">';
                    html += '<div class="to_list_subject">' + promiseReady.t_subject + '</div>';
                    html += '<div>';
                    html += '<div class="toContentOne1span toContentOne1span2">';
                    html += '<span>' + promiseReady.t_campname + '</span>';
                    html += '<span class="to_campdate">' + promiseReady.t_startdate + '-' + promiseReady.t_enddate + '</span>';
                    html += '</div>';
                    html += '</div>';
                    html += '</div>';
                    html += '</div>';
                    html += '<div class="toContentOne2">';
                    if (!promiseReady.tf_name) {
                        html += '<img src="${path}/resources/images/to_camp.jpg" class="toContentOne2img">';
                    } else {
                        html += '<img src="' + promiseReady.tf_name + '" class="toContentOne2img">';
                    }
                    html += '<span class="toContentOne2sub2">' + promiseReady.t_induty + '</span>';
                    html += '</div>';
                    html += '<div>';
                    html += '<div class="toContentOne3">';
                    html += '<p>조회수 : ' + promiseReady.t_hit + '</p>';
                    html += '<p>모집 : ' + promiseReady.promise_count + ' / ' + promiseReady.t_numpeople + '명' + '</p>';
                    html += '</div>';
                    html += '<form method="post" class="toContentOne4">';
                    html += '<button type="button" class="toContentOne2" onclick="to_detail(' + promiseReady.t_idx + ',' + data.paging.nowPage + ')">상세 보기<button>';
                    html += '<button type="button" class="toContentOne2" onclick="to_people_detail(this.form)">인원 보기<button>';
                    html += '<input type="hidden" name="t_idx" value="' + promiseReady.t_idx + '">';
                    html += '<input type="hidden" name="cPage" value="' + data.paging.nowPage + '">';
                    html += '<input type="hidden" name="t_campname" value="' + promiseReady.t_campname + '">';
                    html += '<input type="hidden" name="t_subject" value="' + promiseReady.t_subject + '">';
                    html += '<input type="hidden" name="t_startdate" value="' + promiseReady.t_startdate + '">';
                    html += '<input type="hidden" name="t_enddate" value="' + promiseReady.t_enddate + '">';
                    html += '<input type="hidden" name="t_induty" value="' + promiseReady.t_induty + '">';
                    html += '<input type="hidden" name="promise_count" value="' + promiseReady.promise_count + '">';
                    html += '<input type="hidden" name="t_numpeople" value="' + promiseReady.t_numpeople + '">';
                    html += '<input type="hidden" name="member_idx" value="' + memberIdx + '">';
                    html += '</form>';
                    html += '</div>';
                    html += '</div>';
                }
                $('.toContent').append(html);
            } else {
                html += '<div class="thul5">';
                html += '<div class="no-data-message">';
                html += '<p class="no-data-messageP">모집중인 동행이 없습니다</p>';
                html += '</div>';
                html += '</div>';
                $('.toContent').replaceWith(html);
            }
            let paging = data.paging;
            $('.to_paging').empty();
            let pagingHtml = '';
            // 이전 버튼
            if (paging.beginBlock <= paging.pagePerBlock) {
                pagingHtml += '<li class="to_disable"><i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
                pagingHtml += '<li class="to_disable"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
            } else {
                pagingHtml += '<li><a href="javascript:toPromiseIng(1)" class="to_able"><i class="fa-solid fa-angles-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
                pagingHtml += '<li><a href="javascript:toPromiseIng(' + (paging.beginBlock - paging.pagePerBlock) + ')" class="to_able"><i class="fa-solid fa-chevron-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
            }
            // 페이지번호들
            for (let k = paging.beginBlock; k <= paging.endBlock; k++) {
                if (k === paging.nowPage) {
                    pagingHtml += '<li class="nowpagecolor">' + k + '</li>';
                } else {
                    pagingHtml += '<li><a href="javascript:toPromiseIng(' + k + ')" class="nowpage">' + k + '</a></li>';
                }
            }
            // 이후 버튼
            if (paging.endBlock >= paging.totalPage) {
                pagingHtml += '<li class="to_disable"><i class="fa-solid fa-chevron-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
                pagingHtml += '<li class="to_disable"><i class="fa-solid fa-angles-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
            } else {
                pagingHtml += '<li><a href="javascript:toPromiseIng(' + (paging.beginBlock + paging.pagePerBlock) + ')" class="to_able"><i class="fa-solid fa-chevron-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
                pagingHtml += '<li><a href="javascript:toPromiseIng(' + paging.totalPage + ')" class="to_able"><i class="fa-solid fa-angles-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
            }
            $('.to_paging').append(pagingHtml);
        },
        error: function(xhr, status, error) {
            console.error(error);
        }
    });
}
function toPromiseEnd(page) {
	let memberIdx = document.getElementById("member_idx").value;
   	$('.toContent, .thwrapper1').empty();
    $.ajax({
        url: 'get_promise_end.do',
        type: 'post',
        data: {
            member_idx: memberIdx,
            cPage: page
        },
        dataType: 'json',
        success: function(data) {
        	let toPromiseEnd = data.toPromiseEnd;
        	let html2 = '';
        		html2 += '<button type="button" class="thwrapper1Button" onclick="toPromiseIng()">모집중인 동행</button>'
        		html2 += '<button type="button" class="thwrapper1Button" onclick="toPromiseReady()">진행중인 동행</button>'
        		html2 += '<button type="button" class="thwrapper1Button2 thwrapper1Button_active" onclick="toPromiseEnd()">동행 완료</button>'
       			$('.thwrapper1').append(html2);
                let html = '';
        	if (toPromiseEnd != null && toPromiseEnd.length > 0) {
        		for (let i = 0; i < toPromiseEnd.length; i++) {
                    let PromiseEnd = toPromiseEnd[i];
                    html += '<div class="toContentOne">';
                    html += '<div>';
                    html += '<div class="toContentOne1">';
                    html += '<div class="to_list_subject">' + PromiseEnd.t_subject + '</div>';
                    html += '<div>';
                    html += '<div class="toContentOne1span toContentOne1span2">';
                    html += '<span>' + PromiseEnd.t_campname + '</span>';
                    html += '<span class="to_campdate">' + PromiseEnd.t_startdate + '-' + PromiseEnd.t_enddate + '</span>';
                    html += '</div>';
                    html += '</div>';
                    html += '</div>';
                    html += '</div>';
                    html += '<div class="toContentOne2">';
                    if (!PromiseEnd.tf_name) {
                        html += '<img src="${path}/resources/images/to_camp.jpg" class="toContentOne2img">';
                    } else {
                        html += '<img src="' + PromiseEnd.tf_name + '" class="toContentOne2img">';
                    }
                    html += '<span class="toContentOne2sub2">' + PromiseEnd.t_induty + '</span>';
                    html += '</div>';
                    html += '<div>';
                    html += '<div class="toContentOne3">';
                    html += '<p>조회수 : ' + PromiseEnd.t_hit + '</p>';
                    html += '<p>모집 : ' + PromiseEnd.promise_count + ' / ' + PromiseEnd.t_numpeople + '명' + '</p>';
                    html += '</div>';
                    html += '<form method="post" class="toContentOne4">';
                    html += '<button type="button" class="toContentOne2" onclick="to_detail(' + PromiseEnd.t_idx + ',' + data.paging.nowPage + ')">상세 보기<button>';
                    html += '<button type="button" class="toContentOne2" onclick="to_people_detail(this.form)">인원 보기<button>';
                    html += '<input type="hidden" name="t_idx" value="' + PromiseEnd.t_idx + '">';
                    html += '<input type="hidden" name="cPage" value="' + data.paging.nowPage + '">';
                    html += '<input type="hidden" name="t_campname" value="' + PromiseEnd.t_campname + '">';
                    html += '<input type="hidden" name="t_subject" value="' + PromiseEnd.t_subject + '">';
                    html += '<input type="hidden" name="t_startdate" value="' + PromiseEnd.t_startdate + '">';
                    html += '<input type="hidden" name="t_enddate" value="' + PromiseEnd.t_enddate + '">';
                    html += '<input type="hidden" name="t_induty" value="' + PromiseEnd.t_induty + '">';
                    html += '<input type="hidden" name="promise_count" value="' + PromiseEnd.promise_count + '">';
                    html += '<input type="hidden" name="t_numpeople" value="' + PromiseEnd.t_numpeople + '">';
                    html += '<input type="hidden" name="member_idx" value="' + memberIdx + '">';
                    html += '</form>';
                    html += '</div>';
                    html += '</div>';
                }
                $('.toContent').append(html);
            } else {
                html += '<div class="thul5">';
                html += '<div class="no-data-message">';
                html += '<p class="no-data-messageP">모집중인 동행이 없습니다</p>';
                html += '</div>';
                html += '</div>';
                $('.toContent').replaceWith(html);
            }
            let paging = data.paging;
            $('.to_paging').empty();
            let pagingHtml = '';
            // 이전 버튼
            if (paging.beginBlock <= paging.pagePerBlock) {
                pagingHtml += '<li class="to_disable"><i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
                pagingHtml += '<li class="to_disable"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
            } else {
                pagingHtml += '<li><a href="javascript:toPromiseIng(1)" class="to_able"><i class="fa-solid fa-angles-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
                pagingHtml += '<li><a href="javascript:toPromiseIng(' + (paging.beginBlock - paging.pagePerBlock) + ')" class="to_able"><i class="fa-solid fa-chevron-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
            }
            // 페이지번호들
            for (let k = paging.beginBlock; k <= paging.endBlock; k++) {
                if (k === paging.nowPage) {
                    pagingHtml += '<li class="nowpagecolor">' + k + '</li>';
                } else {
                    pagingHtml += '<li><a href="javascript:toPromiseIng(' + k + ')" class="nowpage">' + k + '</a></li>';
                }
            }
            // 이후 버튼
            if (paging.endBlock >= paging.totalPage) {
                pagingHtml += '<li class="to_disable"><i class="fa-solid fa-chevron-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
                pagingHtml += '<li class="to_disable"><i class="fa-solid fa-angles-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
            } else {
                pagingHtml += '<li><a href="javascript:toPromiseIng(' + (paging.beginBlock + paging.pagePerBlock) + ')" class="to_able"><i class="fa-solid fa-chevron-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
                pagingHtml += '<li><a href="javascript:toPromiseIng(' + paging.totalPage + ')" class="to_able"><i class="fa-solid fa-angles-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
            }
            $('.to_paging').append(pagingHtml);
        },
        error: function(xhr, status, error) {
            console.error(error);
        }
    });
}
</script>
</head>
<body>
    <div class="toContainer">
        <input type="hidden" id="member_idx" value="${member_idx }">
        <input type="hidden" id="cPage" value="${cPage }">
        <div class="thwrapper1">
<!--             <button type="button" class="thwrapper1Button thwrapper1Button_active" onclick="toPromiseing()">모집중인 동행</button> -->
<!--             <button type="button" class="thwrapper1Button" onclick="toPromiseReady()">진행중인 동행</button> -->
<!--             <button type="button" class="thwrapper1Button2" onclick="promiseApplySendList()">동행 완료</button> -->
        </div>
        <form class="toContent">
<%--        		<c:forEach var="k" items="${togetherList }"> --%>
<!-- 	            <div class="toContentOne"> -->
<!-- 	                <div> -->
<!-- 	                    <div class="toContentOne1"> -->
<%-- 	                    	<a href="report_write.do?member_idx=${k.member_idx}"> --%>
<%-- 	                        <div class="userImage"><img src="${path}/resources/images/${k.member_img }" class="userImage2"></div> --%>
<!-- 	                        </a> -->
<!-- 	                        <div> -->
<!-- 		                        <div class="toContentOne1span1"> -->
<%-- 		                            <span class="to_member_nickname">${k.member_nickname }</span> --%>
<%-- 		                            <span class="to_member_age">(${k.member_dob })</span> --%>
<!-- 		                        </div> -->
<!-- 		                        <div class="toContentOne1span toContentOne1span2"> -->
<%-- 		                            <span>${k.t_campname }</span> --%>
<%-- 		                            <span class="to_campdate">${k.t_startdate }-${k.t_enddate }</span> --%>
<!-- 		                        </div> -->
<!-- 	                        </div> -->
<!-- 	                    </div> -->
<!-- 	                </div> -->
<%-- 	                <a href="together_detail.do?t_idx=${k.t_idx}&cPage=${paging.nowPage}" class="toContentOne2"> --%>
<%-- 	                	<c:choose> --%>
<%-- 	                		<c:when test="${empty k.tf_name }"> --%>
<%-- 	                			<img src="${path}/resources/images/to_camp.jpg" class="toContentOne2img"> --%>
<%-- 	                		</c:when> --%>
<%-- 	                		<c:otherwise> --%>
<%-- 			                    <img src="${k.tf_name }" class="toContentOne2img"> --%>
<%-- 	                		</c:otherwise> --%>
<%-- 	                	</c:choose> --%>
<%-- 	                    <span class="toContentOne2sub2">${k.t_induty }</span> --%>
<!-- 	                </a> -->
<%-- 	                <a href="together_detail.do?t_idx=${k.t_idx}&cPage=${paging.nowPage}" class="toContentOne3"> --%>
<%-- 	                    <strong class="to_list_subject">${k.t_subject }</strong> --%>
<%-- 	                    <span>${k.t_content }</span> --%>
<!-- 	                </a> -->
<!-- 	            </div> -->
<%-- 		    </c:forEach> --%>
        </form>
        <div class="toPagingContainer">
	        <div class="towrapper" id="paginationWrapper">
				<ul class="to_paging">
					<!-- 이전 버튼 -->
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${paging.beginBlock <= paging.pagePerBlock }"> --%>
<!-- 							<li class="to_disable"><i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li> -->
<!-- 							<li class="to_disable"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li> -->
<%-- 						</c:when> --%>
<%-- 						<c:otherwise> --%>
<!-- 							<li> -->
<%-- 								<a href="together_list.do?cPage=1&searchType=${searchType}&searchKeyword=${searchKeyword}" class="to_able"><i class="fa-solid fa-angles-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a> --%>
<!-- 			                </li> -->
<!-- 			                <li> -->
<%-- 	                 				<a href="together_list.do?cPage=${paging.beginBlock - paging.pagePerBlock }&searchType=${searchType}&searchKeyword=${searchKeyword}" class="to_able"><i class="fa-solid fa-chevron-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a> --%>
<!-- 							</li> -->
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
		
<!-- 					페이지번호들 -->
<%-- 					<c:forEach begin="${paging.beginBlock }" end="${paging.endBlock }" step="1" var="k"> --%>
<%-- 						<c:choose> --%>
<%-- 							<c:when test="${k == paging.nowPage }"> --%>
<%-- 								<li class="nowpagecolor">${k }</li> --%>
<%-- 							</c:when> --%>
<%-- 							<c:otherwise> --%>
<%-- 								<li><a href="together_list.do?cPage=${k}&searchType=${searchType}&searchKeyword=${searchKeyword}" class="nowpage">${k}</a></li> --%>
<%-- 							</c:otherwise> --%>
<%-- 						</c:choose> --%>
<%-- 					</c:forEach> --%>
					
<!-- 					이후 버튼 -->
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${paging.endBlock >= paging.totalPage }"> --%>
<!-- 							<li class="to_disable"><i class="fa-solid fa-chevron-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li> -->
<!-- 							<li class="to_disable"><i class="fa-solid fa-angles-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li> -->
<%-- 						</c:when> --%>
<%-- 						<c:otherwise> --%>
<!-- 							<li> -->
<%-- 								<a href="together_list.do?cPage=${paging.beginBlock + paging.pagePerBlock }&searchType=${searchType}&searchKeyword=${searchKeyword}" class="to_able"><i class="fa-solid fa-chevron-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a> --%>
<!-- 			                </li> -->
<!-- 			                <li> -->
<%-- 			                    <a href="together_list.do?cPage=${paging.totalPage}&searchType=${searchType}&searchKeyword=${searchKeyword}" class="to_able"><i class="fa-solid fa-angles-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a> --%>
<!-- 							</li> -->
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
				</ul>
			</div>	
        </div>
    </div>
<%@ include file="../hs/footer.jsp" %>
</body>
</html>