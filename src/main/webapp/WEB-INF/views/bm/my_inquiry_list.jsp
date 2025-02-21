<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/public/css/bm/grid.css">
<link rel="stylesheet" href="${path}/resources/css/menu_aside.css" />
<script defer src="${path}/resources/public/js/bm/my_menu.js"></script>
<script>
  function handleWrite(member_idx){
	  location.href="inquiry_form.do?member_idx="+member_idx;
  }
  </script>
<title>1:1문의내역</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico"
	type="image/x-icon">
<link rel="icon" href="${path}/resources/images/favicon.ico"
	type="image/x-icon">
</head>
<body>
	<%@ include file="../hs/mypage_menu.jsp"%>
	<div class="inquiry">
		<h3 class="grid_title">1:1문의 내역</h3>
		<div class="grid_container">
			<div class="grid_table">
				<div class="grid_col grid_header">
					<div class="grid_row grid_row1">번호</div>
					<div class="grid_row grid_row2">제목</div>
					<div class="grid_row grid_row3">닉네임</div>
					<div class="grid_row grid_row4">날짜</div>
					<div class="grid_row grid_row5">상태</div>
				</div>
				<div class="grid_col grid_content">
					<c:choose>
						<c:when test="${empty list }">
							<h3 class="nolist">문의 내역이 없습니다.</h3>
						</c:when>
						<c:otherwise>
							<c:forEach var="list" items="${list}" varStatus="vs">
								<div class="grid_row grid_row_content">${paging.totalRecord - ((paging.nowPage-1)* paging.numPerPage + vs.index)}</div>
								<div class="grid_row grid_row_content">
									<a href="my_inquiry.do?qna_idx=${list.qna_idx}">${list.qna_title }</a>
								</div>
								<div class="grid_row grid_row_content">${nickname }</div>
								<div class="grid_row grid_row_content">${list.qna_date.substring(0,10)}</div>
								<c:choose>
									<c:when test="${list.qna_status==0}">
										<div class="grid_row grid_row_content">대기중</div>
									</c:when>
									<c:otherwise>
										<div class="grid_row grid_row_content">답변완료</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
			<div class="grid_last_row">
				<div class="paging">
					<c:choose>
						<c:when test="${paging.beginBlock <= paging.pagePerBlock }">
							<li class="disable paging_list paging_prev">&#8249;</li>
						</c:when>
						<c:otherwise>
							<li><a
								href="my_inquiry_list.do?cPage=${paging.beginBlock-paging.pagePerBlock}"
								class="paging_list paging_prev">&#8249;</a></li>
						</c:otherwise>
					</c:choose>

					<!-- 페이지번호들 -->
					<c:forEach begin="${paging.beginBlock }" end="${paging.endBlock }"
						step="1" var="k">
						<c:choose>
							<c:when test="${ k== paging.nowPage}">
								<li class="paging_list paging_active">${k}</li>
							</c:when>
							<c:otherwise>
								<li class="paging_list paging_num"><a
									href="my_inquiry_list.do?cPage=${k}">${k}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<!-- 이후 버튼 -->
					<c:choose>
						<c:when test="${paging.endBlock >= paging.totalPage }">
							<li class="disable paging_list paging_next">&#8250;</li>
						</c:when>
						<c:otherwise>
							<li><a
								href="my_inquiry_list.do?cPage=${paging.beginBlock+paging.pagePerBlock}"
								class="paging_list paging_next">&#8250;</a></li>
						</c:otherwise>
					</c:choose>

				</div>
				<button class="btn btn-inquiry" onclick="handleWrite(${member_idx})">문의글
					작성하기</button>
				<input type="hidden" id="memberIdx" name="member_idx"
					value="${qvo.member_idx}" />

			</div>
		</div>
	</div>
	<%@ include file="../hs/footer.jsp"%>
</body>
</html>