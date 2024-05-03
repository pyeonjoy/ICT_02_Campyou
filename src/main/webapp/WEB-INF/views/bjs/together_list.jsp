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
</script>
</head>
<body>
    <div class="toContainer">
        <div class="togetherh2">
            <h3>동 행</h3>
        </div>
        <c:choose>
        	<c:when test="${empty togetherList }">
        		<h2>게시물이 존재하지 않습니다</h2>
        	</c:when>
        	<c:otherwise>
		        <form class="toContent">
	        		<c:forEach var="k" items="${togetherList }" varStatus="vs">
		        			<c:choose>
		        				<c:when test="${k.t_active == 1 }">
		        					<div class="toContentOne" style="background-color: rgba(128, 128, 128, 0.1);">
						                <div>
						                    <div class="toContentOne1">
						                        <div class="userImage"><img src="${path}/resources/images/tree-4.jpg" class="userImage2"></div>
						                        <div>
							                        <div class="toContentOne1span1">
							                            <span class="to_member_nickname">${k.member_nickname }</span>
							                            <span class="to_member_age">(${k.member_dob })</span>
							                        </div>
							                        <div class="toContentOne1span toContentOne1span2">
							                            <span>${k.t_campname }</span>
							                            <span class="to_campdate">${k.t_startdate }-${k.t_enddate }</span>
							                        </div>
						                        </div>
						                    </div>
						                </div>
						                <a href="together_detail.do" class="toContentOne2">
						                	<img src="${k.tf_name }" class="toContentOne2img" style="opacity: 0.5;">
						                    <span class="toContentOne2sub2">${k.t_camptype }</span>
						                    <span class="toContentOne2sub2" style="align-items: center; justify-content: center;">게시 중지된 게시물입니다.</span>
						                </a>
						                <a href="together_detail.do" class="toContentOne3">
						                    <strong>${k.t_subject }</strong>
						                    <span>${k.t_content }</span>
						                </a>
						            </div>
		        				</c:when>
		        				<c:otherwise>
						            <div class="toContentOne">
						                <div>
						                    <div class="toContentOne1">
						                        <div class="userImage"><img src="${path}/resources/images/tree-4.jpg" class="userImage2"></div>
						                        <div>
							                        <div class="toContentOne1span1">
							                            <span class="to_member_nickname">${k.member_nickname }</span>
							                            <span class="to_member_age">(${k.member_dob })</span>
							                        </div>
							                        <div class="toContentOne1span toContentOne1span2">
							                            <span>${k.t_campname }</span>
							                            <span class="to_campdate">${k.t_startdate }-${k.t_enddate }</span>
							                        </div>
						                        </div>
						                    </div>
						                </div>
						                <a href="together_detail.do?t_idx=${k.t_idx}&cPage=${paging.nowPage}" class="toContentOne2">
						                    <img src="${k.tf_name }" class="toContentOne2img">
						                    <span class="toContentOne2sub2">${k.t_camptype }</span>
						                </a>
						                <a href="together_detail.do?t_idx=${k.t_idx}&cPage=${paging.nowPage}" class="toContentOne3">
						                    <strong class="to_list_subject">${k.t_subject }</strong>
						                    <span>${k.t_content }</span>
						                </a>
						            </div>
		        				</c:otherwise>
		        			</c:choose>
				    </c:forEach>
		        </form>
        	</c:otherwise>
        </c:choose>
        <div class="toPagingContainer">
        	<form class="searchForm" onsubmit="">
        		<select name="searchType" class="searchSelect" id="">
        			<option value="제목" ${param.searchType eq 'latest' ? 'selected' : ''}>제목</option>
        			<option value="내용" ${param.searchType eq 'latest' ? 'selected' : ''}>내용</option>
        			<option value="캠핑지" ${param.searchType eq 'latest' ? 'selected' : ''}>캠핑지</option>
        		</select>
        		<input type="search" class="searchbar">
        		<input type="submit" class="res" value="검색">
<!-- 				<button class="res">검색</button> -->
			</form>
	        <div class="towrapper">
				<ul class="to_paging">
					<!-- 이전 버튼 -->
					<c:choose>
						<c:when test="${paging.beginBlock <= paging.pagePerBlock }">
							<li class="to_disable"><i class="fa-solid fa-angles-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>
							<li class="to_disable"><i class="fa-solid fa-chevron-right fa-rotate-180" style="border-radius: 50%; font-size: 1.2rem;"></i></li>
						</c:when>
						<c:otherwise>
							<li>
								<a href="together_list.do?cPage=1" class="to_able"><i class="fa-solid fa-angles-right fa-rotate-180" style="color: 041601; border-radius: 50%; font-size: 1.2rem;"></i></a>
							</li>
							<li>
								<a href="together_list.do?cPage=${paging.beginBlock - paging.pagePerBlock }" class="to_able"><i class="fa-solid fa-chevron-right fa-rotate-180" style="color: 041601; border-radius: 50%; font-size: 1.2rem;"></i></a>
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
								<li><a href="together_list.do?cPage=${k }" class="nowpage">${k }</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<!-- 이후 버튼 -->
					<c:choose>
						<c:when test="${paging.endBlock >= paging.totalPage }">
							<li class="to_disable"><i class="fa-solid fa-chevron-right" style="color: white; border-radius: 50%; font-size: 1.2rem;"></i></li>
							<li class="to_disable"><i class="fa-solid fa-angles-right" style="color: white; border-radius: 50%; font-size: 1.2rem;"></i></li>
						</c:when>
						<c:otherwise>
							<li>
								<a href="together_list.do?cPage=${paging.beginBlock + paging.pagePerBlock }" class="to_able"><i class="fa-solid fa-chevron-right" style="color: 041601; border-radius: 50%; font-size: 1.2rem;"></i></a>
							</li>
							<li>
								<a href="together_list.do?cPage=${paging.totalPage}" class="to_able"><i class="fa-solid fa-angles-right" style="color: 041601; border-radius: 50%; font-size: 1.2rem;"></i></a>
							</li>
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
</body>
</html>