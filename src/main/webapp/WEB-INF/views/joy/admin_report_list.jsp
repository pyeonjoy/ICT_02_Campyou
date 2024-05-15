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
<style type="text/css">
@charset "UTF-8";

:root{
  --primary-color: #032805;
  --primary-color-light: #FFFDDE;
  --text-white: #fff;
  --text-black: #000;
}
.grid_title{
text-align: center;
  margin: 2rem;
  color: var(--primary-color);
}
.grid_container{
  display: grid;
  justify-content: center;
  align-items: center;
  width: 70%;
  margin: 0 auto;
  transform: translateY(10rem);
}
.grid_col{
  display: grid;
  grid-template-columns: 1fr 2fr 2fr 1fr 1fr;
  margin-bottom: .6rem;
  text-align: center;
}

.nolist{
  grid-column: 1 /6;
  width: 60rem;
  padding:3rem;
}
.grid_header{
  padding: .8rem 1rem;
  background-color: var(--primary-color);
  color: var(--text-white);
  width: 100%;
}
.grid_title{
  display: block;
}
.grid_row_content{
padding: .5rem;
width: 100%;
}

.grid_last_row{
  position: relative;
}
.paging{
  margin-top: 3rem;
  list-style-type: none;
  display: flex;
  justify-content: center;
}

.paging-link{
  margin-left: 1rem; 
  background-color: var(--text-white);
  border: 1px solid var(--text-black);
  color: var(--text-black);
  text-decoration: none;
  width: 20px;
  height: 20px;
  font-size: .9rem;
}
.paging_list{
  display: flex;
  align-items: center;
  justify-content: center;
}

.paging_active {
 background-color:var(--primary-color);
 color: var(--text-white);
}
.paging_next{
  margin-left: 1rem;
}
.btn{
  background-color: var(--text-white);
  border: 2px solid var(--primary-color);
  padding: 3px 10px;
  position: absolute;
  right: 0;
  font-weight: 600;
   cursor: pointer;
}
</style>
<title>신고게시</title>
</head>
<body>
	<%@ include file="../hs/mypage_menu.jsp"%>

	<div class="grid_container">
		<h3 class="grid_title">신고게시판</h3>
		<div class="grid_col grid_header">
			<div class="grid_row grid_row1">번호</div>
			<div class="grid_row grid_row2">신고내용</div>
			<div class="grid_row grid_row3">신고자</div>
			<div class="grid_row grid_row4">신고대상자</div>
			<div class="grid_row grid_row5">상태</div>
		</div>
		<div class="grid_col grid_content">
			<c:choose>
				<c:when test="${empty report }">
					<h3 class="nolist">문의 내역이 없습니다.</h3>
				</c:when>
				<c:otherwise>
					<c:forEach var="k" items="${report }" varStatus="vs" begin="1">
						<div class="grid_row grid_row_content">${paging.totalRecord - ((paging.nowPage-1)*paging.numPerPage+ vs.index)}</div>
						<div class="grid_row grid_row_content">
							<a href="my_inquiry.do?qna_idx=${list.qna_idx}">${k.report_content }</a>
						</div>
						<div class="grid_row grid_row_content">${k.reportmember_idx }</div>
						<div class="grid_row grid_row_content">${k.member_idx }</div>
						<c:choose>
							<c:when test="${k.report_status==0}">
								<div class="grid_row grid_row_content">처리중</div>
							</c:when>
							<c:otherwise>
								<div class="grid_row grid_row_content">처리완료</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="grid_last_row">
			<div class="paging">
				<c:choose>
					<c:when test="${paging.beginBlock <= paging.pagePerBlock }">
						<li class="disable"><</li>
					</c:when>
					<c:otherwise>
						<li><a
							href="qna_list.do?cPage=${paging.beginBlock-paging.pagePerBlock}"><</a>
						</li>
					</c:otherwise>
				</c:choose>

				<!-- 페이지번호들 -->
				<c:forEach begin="${paging.beginBlock }" end="${paging.endBlock }"
					step="1" var="k">
					<c:choose>
						<c:when test="${ k== paging.nowPage}">
							<li class="paging_list paging_num">${k }</li>
						</c:when>
						<c:otherwise>
							<li class="paging_list paging_num"><a
								href="qna_list.do?cPage=${k}">${k}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<!-- 이후 버튼 -->
				<c:choose>
					<c:when test="${paging.endBlock >= paging.totalPage }">
						<li class="disable">next</li>
					</c:when>
					<c:otherwise>
						<li><a
							href="qna_list.do?cPage=${paging.beginBlock+paging.pagePerBlock}">next</a>
						</li>
					</c:otherwise>
				</c:choose>
			</div>
				<div>
					<form action="member_search.do" method="post">
					    <div class="search-wrap">
					        <select name="searchType">
					            <option value="content">신고 내용</option>
					            <option value="reportmember">신고대상자</option>
					            <option value="member">신고자</option>
					        </select>
					    	<input type="text" name="keyword">
					        <button type="submit" name="search">검색</button>
					    </div>
					    <input type="hidden" name="offset" value="1">
					    <input type="hidden" name="limit" value="10">
					</form>
				</div>
		</div>
	</div>
</body>
</html>