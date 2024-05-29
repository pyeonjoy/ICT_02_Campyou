<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>동행게시판</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://kit.fontawesome.com/80123590ac.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${path}/resources/public/css/bjs/together_list.css">
<%@ include file="../hs/header.jsp" %>
<script type="text/javascript">
	function together_Write() {
		location.href = "together_Write.do";
	}
	
	document.addEventListener("DOMContentLoaded", function() {
	    var toContentOne = document.querySelectorAll('.toContentOne');

	    toContentOne.forEach(function(item) {
	        item.addEventListener('mouseover', function() {
	            item.classList.add('hover-effect');
	        });
	        item.addEventListener('mouseout', function() {
	            item.classList.remove('hover-effect');
	        });
	    });
	});
	
	$(document).ready(function() {
	    $(".res").click(function() {
	        to_search();
	    });
	    // 엔터 키를 눌렀을 때 검색 실행
	    $(".searchbar").keypress(function(e) {
	        // 엔터 키의 keyCode는 13
	        if (e.keyCode === 13) {
	            e.preventDefault();
	            to_search();
	        }
	    });
	});
	
	function to_search() {
		let searchType = document.getElementById("searchType").value;
	    let searchKeyword = document.getElementById("searchbar").value;
	    location.href="together_list.do?searchType=" + searchType + "&searchKeyword=" + searchKeyword
	}

// 	$(document).ready(function() {
// 	    $('#sortSelect').change(function() {
// 	        $('#sortForm').submit();
// 	    });
// 	});
</script>
</head>
<body>
    <div class="toContainer">
        <div class="togetherh2">
            <h3>동 행</h3>
        </div>
<!--         <form action="to_list_sort.do" method="get" class="sortform" id="sortForm"> -->
<!-- 		    <select name="sort" class="sort" id="sortSelect"> -->
<%-- 		        <option value="normal" ${param.sort eq 'normal' ? 'selected' : ''}>기본</option> --%>
<%-- 		        <option value="hit" ${param.sort eq 'hit' ? 'selected' : ''}>조회순</option> --%>
<%-- 		        <option value="comment" ${param.sort eq 'comment' ? 'selected' : ''}>댓글순</option> --%>
<!-- 		    </select> -->
<!-- 		</form>	 -->
        <c:choose>
			<c:when test="${not empty searchKeyword and not empty searchType }">
				<div class="searchRes">${searchType }&nbsp;/&nbsp;${searchKeyword }&nbsp;<a href="together_list.do">X</a></div>
			</c:when>
		</c:choose>
        <c:choose>
        	<c:when test="${empty togetherList }">
        		<div class="emptyToListDiv">
        			<h4 class="emptyToList">게시물이 존재하지 않습니다</h4>
        		</div>
        	</c:when>
        	<c:otherwise>
		        <form class="toContent">
	        		<c:forEach var="k" items="${togetherList }" varStatus="vs">
			            <div class="toContentOne">
			                <div>
			                    <div class="toContentOne1">
			                    	<c:choose>
			                    		<c:when test="${k.member_img == 'user2.png'}">
					                        <img src="${path}/resources/images/${k.member_img }" class="userImage2">
			                    		</c:when>
			                    		<c:otherwise>
											<img src="${path}/resources/uploadUser_img/${k.member_img}" class="userImage2">	                    			
			                    		</c:otherwise>
			                    	</c:choose>
			                        <div>
				                        <div class="toContentOne1span1">
				                            <span class="to_member_nickname profile_show" data-memberidx="${k.member_idx}">${k.member_nickname}</span>
				                            <img src="${path}/resources/images/${k.member_grade}" class="member_gradeImg" >
				                            <span class="to_member_age">(${k.member_dob } ${k.member_gender })</span>
				                        </div>
				                        <div class="toContentOne1span toContentOne1span2">
				                            <span>${k.t_campname }</span>
				                            <span class="to_campdate">${k.t_startdate }-${k.t_enddate }</span>
				                        </div>
			                        </div>
			                    </div>
			                </div>
			                <a href="together_detail.do?t_idx=${k.t_idx}&cPage=${paging.nowPage}" class="toContentOne2">
			                	<c:choose>
			                		<c:when test="${empty k.tf_name }">
			                			<img src="${path}/resources/images/to_camp.jpg" class="toContentOne2img">
			                		</c:when>
			                		<c:otherwise>
					                    <img src="${k.tf_name }" class="toContentOne2img">
			                		</c:otherwise>
			                	</c:choose>
			                    <span class="toContentOne2sub2">${k.t_induty }</span>
			                </a>
			                <a href="together_detail.do?t_idx=${k.t_idx}&cPage=${paging.nowPage}" class="toContentOne3">
			                    <span class="to_list_subject">${k.t_subject }</span>
			                    <span class="contentImageEX">${k.t_content }</span>
			                </a>
			            </div>
				    </c:forEach>
		        </form>
        	</c:otherwise>
        </c:choose>
        <div class="toPagingContainer">
        	<form class="searchForm" onsubmit="return false;">
        		<select name="searchType" class="searchSelect" id="searchType">
        			<option value="제목" ${param.searchType eq '제목' ? 'selected' : ''}>제목</option>
        			<option value="내용" ${param.searchType eq '내용' ? 'selected' : ''}>내용</option>
        			<option value="캠핑지" ${param.searchType eq '캠핑지' ? 'selected' : ''}>캠핑지</option>
        		</select>
        		<input type="search" name="searchKeyword" class="searchbar" id="searchbar">
        		<button type="button" class="res" onclick="to_search()">검색</button>
			</form>
	        <div class="towrapper" id="paginationWrapper">
				<ul class="to_paging">
					<!-- 이전 버튼 -->
					<c:choose>
						<c:when test="${empty searchType && empty searchKeyword}">
							<c:choose>
								<c:when test="${paging.beginBlock <= paging.pagePerBlock }">
									<li class="to_disable"><i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>
									<li class="to_disable"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>
								</c:when>
								<c:otherwise>
									<li>
										<a href="together_list.do?cPage=1" class="to_able"><i class="fa-solid fa-angles-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a>
					                </li>
					                <li>
		                  				<a href="together_list.do?cPage=${paging.beginBlock - paging.pagePerBlock }" class="to_able"><i class="fa-solid fa-chevron-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a>
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
										<li><a href="together_list.do?cPage=${k}" class="nowpage">${k}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<!-- 이후 버튼 -->
							<c:choose>
								<c:when test="${paging.endBlock >= paging.totalPage }">
									<li class="to_disable"><i class="fa-solid fa-chevron-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>
									<li class="to_disable"><i class="fa-solid fa-angles-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>
								</c:when>
								<c:otherwise>
									<li>
										<a href="together_list.do?cPage=${paging.beginBlock + paging.pagePerBlock }" class="to_able"><i class="fa-solid fa-chevron-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a>
					                </li>
					                <li>
					                    <a href="together_list.do?cPage=${paging.totalPage}" class="to_able"><i class="fa-solid fa-angles-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${paging.beginBlock <= paging.pagePerBlock }">
									<li class="to_disable"><i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>
									<li class="to_disable"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>
								</c:when>
								<c:otherwise>
									<li>
										<a href="together_list.do?cPage=1&searchType=${searchType}&searchKeyword=${searchKeyword}" class="to_able"><i class="fa-solid fa-angles-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a>
					                </li>
					                <li>
		                  				<a href="together_list.do?cPage=${paging.beginBlock - paging.pagePerBlock }&searchType=${searchType}&searchKeyword=${searchKeyword}" class="to_able"><i class="fa-solid fa-chevron-right fa-rotate-180" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a>
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
										<li><a href="together_list.do?cPage=${k}&searchType=${searchType}&searchKeyword=${searchKeyword}" class="nowpage">${k}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<!-- 이후 버튼 -->
							<c:choose>
								<c:when test="${paging.endBlock >= paging.totalPage }">
									<li class="to_disable"><i class="fa-solid fa-chevron-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>
									<li class="to_disable"><i class="fa-solid fa-angles-right" style="border-radius: 50%; font-size: 1.2rem;"></i></li>
								</c:when>
								<c:otherwise>
									<li>
										<a href="together_list.do?cPage=${paging.beginBlock + paging.pagePerBlock }&searchType=${searchType}&searchKeyword=${searchKeyword}" class="to_able"><i class="fa-solid fa-chevron-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a>
					                </li>
					                <li>
					                    <a href="together_list.do?cPage=${paging.totalPage}&searchType=${searchType}&searchKeyword=${searchKeyword}" class="to_able"><i class="fa-solid fa-angles-right" style="color: #041601; border-radius: 50%; font-size: 1.2rem;"></i></a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>	
			<div class="togetherWriteButton">
	            <input type="button" value="글쓰기" id="" onclick="together_Write()" class="toDetailContent3Button" style="background-image: url('${path}/resources/images/treepan.jpg');">
	        </div>
        </div>
    </div>
<%@ include file="../hs/footer.jsp" %>
<%@ include file="../hs/profile_small_info.jsp" %>
</body>
</html>