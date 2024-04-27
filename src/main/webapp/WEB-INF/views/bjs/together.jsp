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
<link rel="stylesheet" href="${path}/resources/public/css/bjs/together.css">
<script type="text/javascript">
	function together_Write() {
		location.href = "together_Write.do";
	}
</script>
</head>
<body>
    <div class="toContainer">
        <div class="togetherh2">
            <h2>동 행</h2>
        </div>
        <div class="togetherWriteButton">
            <input type="button" value="작성하기" id="" onclick="together_Write()" class="toDetailContent3Button">
        </div>
        <c:choose>
        	<c:when test="${empty togetherList }">
        		<h2>게시물이 존재하지 않습니다</h2>
        	</c:when>
        	<c:otherwise>
        		<c:forEach var="k" items="${togetherList }" varStatus="vs">
        		<c:forEach var="age" items="${memberAges}">
			        <form class="toContent">
	        			<c:choose>
	        				<c:when test="${k.t_active == 1 }">
	        					<div class="toContentOne" style="background-color: rgba(128, 128, 128, 0.5);">
<!-- 	        						<p style="align-items: center; justify-content: center;">게시 중지된 게시물입니다</p> -->
					                <div>
					                    <div class="toContentOne1">
					                        <div class="userImage"><img src="${path}/resources/images/tree-4.jpg" class="userImage2"></div>
					                        <div>
						                        <div class="toContentOne1span toContentOne1span1">
						                            <strong>${k.member_nickname }(${age })</strong>
						                        </div>
						                        <div class="toContentOne1span toContentOne1span2">
						                            <span>${k.t_campname }</span>
						                            <span>${k.t_startdate }&nbsp;-&nbsp;${k.t_enddate }</span>
						                        </div>
					                        </div>
					                    </div>
					                </div>
					                <a href="together_detail.do" class="toContentOne2">
					                    <img src="${path}/resources/images/tree-4.jpg" class="toContentOne2img">
					                    <span class="toContentOne2sub2">${k.t_camptype }</span>
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
						                        <div class="toContentOne1span toContentOne1span1">
						                            <strong>${k.member_nickname }(${age })</strong>
						                        </div>
						                        <div class="toContentOne1span toContentOne1span2">
						                            <span>${k.t_campname }</span>
						                            <span>${k.t_startdate }&nbsp;-&nbsp;${k.t_enddate }</span>
						                        </div>
					                        </div>
					                    </div>
					                </div>
					                <a href="together_detail.do" class="toContentOne2">
					                    <img src="${path}/resources/images/tree-4.jpg" class="toContentOne2img">
					                    <span class="toContentOne2sub2">${k.t_camptype }</span>
					                </a>
					                <a href="together_detail.do" class="toContentOne3">
					                    <strong>${k.t_subject }</strong>
					                    <span>${k.t_content }</span>
					                </a>
					            </div>
	        				</c:otherwise>
	        			</c:choose>
			        </form>
			    </c:forEach>
        		</c:forEach>
        	</c:otherwise>
        </c:choose>
    </div>
</body>
</html>