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
<%@ include file="../hs/header.jsp" %>
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
	toPromiseing();
});
function toPromiseing(page) {
	let memberIdx = document.getElementById("member_idx").value;
    	$('.toContent').empty();
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
                let html = '';
//             	html += '<div class="thwrapper1">';
//                 html += '<button type="button" class="thwrapper1Button thwrapper1Button_active" onclick="toPromiseing()">모집중인 동행</button>';
//                 html += '<button type="button" class="thwrapper1Button" onclick="toPromiseReady()">진행중인 동행</button>';
//                 html += '<button type="button" class="thwrapper1Button2" onclick="promiseApplySendList()">동행 완료</button>';
//                 html += '</div>';
        	if (toPromiseIng != null && toPromiseIng.length > 0) {
        		for (let i = 0; i < toPromiseIng.length; i++) {
                    let PromiseIng = toPromiseIng[i];
//                     let html2 = '<form class="toContent">';
                    let html2 = '<div class="toContentOne">';
                    html2 += '<div>';
                    html2 += '<div class="toContentOne1">';
                    html2 += '<a href="report_write.do?member_idx=' + PromiseIng.member_idx + '">';
                    html2 += '<div class="userImage"><img src="${path}/resources/images/' + PromiseIng.member_img + '" class="userImage2"></div>';
                    html2 += '</a>';
                    html2 += '<div>';
                    html2 += '<div class="toContentOne1span1">';
                    html2 += '<span class="to_member_nickname">' + PromiseIng.member_nickname + '</span>';
                    html2 += '<span class="to_member_age">(' + PromiseIng.member_dob + ')</span>';
                    html2 += '<div>';
                    html2 += '<div class="toContentOne1span toContentOne1span2">';
                    html2 += '<span>' + PromiseIng.t_campname + '</span>';
                    html2 += '<span class="to_campdate">' + PromiseIng.t_startdate + '-' + PromiseIng.t_enddate + '</span>';
                    html2 += '<div>';
                    html2 += '<div>';
                    html2 += '<div>';
                    html2 += '<div>';
                    html2 += '<a href="together_detail.do?t_idx=' + PromiseIng.t_idx + '&cPage=' + data.paging.nowPage + '" class="toContentOne2">';
                    if (!PromiseIng.tf_name) {
                        html2 += '<img src="${path}/resources/images/to_camp.jpg" class="toContentOne2img">';
                    } else {
                        html2 += '<img src="' + PromiseIng.tf_name + '" class="toContentOne2img">';
                    }
                    html2 += '<span class="toContentOne2sub2">' + PromiseIng.t_induty + '</span>';
                    html2 += '</a>';
                    html2 += '<a href="together_detail.do?t_idx=' + PromiseIng.t_idx + '&cPage=' + data.paging.nowPage + '" class="toContentOne3">';
                    html2 += '<strong class="to_list_subject">' + PromiseIng.t_subject + '</strong>';
                    html2 += '<span>' + PromiseIng.t_content + '</span>';
                    html2 += '</a>';
                    html2 += '</div>';
                    html2 += '</div>';
                    html2 += '</div>';
                    html2 += '</div>';
                    html2 += '</div>';
                    html2 += '</div>';
//                     html2 += '</form>';
                    html += html2;
                }
                $('.toContent').append(html);
            } else {
                html += '<div class="thul5">';
                html += '<div class="no-data-message">';
                html += '<p class="no-data-messageP">모집중인 동행이 없습니다</p>';
                html += '</div>';
                html += '</div>';
                $('.toContent').append(html);
            }
            let paging = data.paging;
            $('.to_paging').empty();
            let pagingHtml = '';
            // 이전 버튼
            if (paging.beginBlock <= paging.pagePerBlock) {
                pagingHtml += '<li class="th_disable"><i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
                pagingHtml += '<li class="th_disable"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>';
            } else {
                pagingHtml += '<li><a href="javascript:promiseApplyList(1)" class="th_able"><i class="fa-solid fa-angles-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a></li>';
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
        <div class="thwrapper1">
            <button type="button" class="thwrapper1Button thwrapper1Button_active" onclick="toPromiseing()">모집중인 동행</button>
            <button type="button" class="thwrapper1Button" onclick="toPromiseReady()">진행중인 동행</button>
            <button type="button" class="thwrapper1Button" onclick="promiseApplySendList()">동행 완료</button>
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