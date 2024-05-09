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

</script>
</head>
<body>
	<div class="qcontainer">
		<div class="qwrapper">
			<div class="">
				<button type="button" name="" onclick="">동행 신청 받은 내역</button>
				<button type="button" name="" onclick="">동행 신청 내역</button>
			</div>
			<ul class="qau">
				<li class="qal q1">이미지</li>
				<li class="qal q1">닉네임</li>
				<li class="qal q2">캠핑장</li>
				<li class="qal q1">동행날짜</li>
				<li class="qal q1">인원</li>
				<li class="qal q1">신청상태</li>
			</ul>
			<c:choose>
				<c:when test="${empty qa_list }">
					<ul class="empty_qa_ul"><li>동행 신청 받은 내역이 없습니다.</li></ul>
				</c:when>
				<c:otherwise>
					<c:forEach var="k" items="${qa_list }" varStatus="vs">
						<ul class="qau">
							<li class="q1"><a href="qa_detail.do?qa_idx=${k.qa_idx}&cPage=${paging.nowPage}" class="qa11">${k.qa_type }</a></li>
							<li class="q2"><a href="qa_detail.do?qa_idx=${k.qa_idx}&cPage=${paging.nowPage}" class="qa11">${k.qa_subject }</a></li>
							<li class="q1"><a href="qa_detail.do?qa_idx=${k.qa_idx}&cPage=${paging.nowPage}" class="qa11">${k.member_name }</a></li>
			                <li class="q1"><a href="qa_detail.do?qa_idx=${k.qa_idx}&cPage=${paging.nowPage}" class="qa11">${k.qa_regdate.substring(0, 16) }</a></li>
			                <li class="q1"><a href="qa_detail.do?qa_idx=${k.qa_idx}&cPage=${paging.nowPage}" class="qa11">${k.qa_regdate.substring(0, 16) }</a></li>
			                <c:choose>
			                	<c:when test="">
			                		<input type="submit" name="" value="수락" onclick="">
			                		<input type="submit" name="" value="거절" onclick="">
			                	</c:when>
			                	<c:otherwise>
					                <li class="q1"><a href="qa_detail.do?qa_idx=${k.qa_idx}&cPage=${paging.nowPage}" class="qa11">${k.qa_regdate.substring(0, 16) }</a></li>
			                	</c:otherwise>
			                </c:choose>
						</ul>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="qwrapper">
			<ul class="qa_paging">
				<!-- 이전 버튼 -->
				<c:choose>
					<c:when test="${paging.beginBlock <= paging.pagePerBlock }">
						<li class="qa_disable">이전으로</li>
					</c:when>
					<c:otherwise>
						<li>
							<a href="qa_list.do?cPage=${paging.beginBlock - paging.pagePerBlock }" class="qa_able">이전으로</a>
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
						<li class="qa_disable">다음으로</li>
					</c:when>
					<c:otherwise>
						<li>
							<a href="qa_list.do?cPage=${paging.beginBlock + paging.pagePerBlock }" class="qa_able">다음으로</a>
						</li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>	
	</div>
<%@ include file="../hs/footer.jsp" %>
</body>
</html>