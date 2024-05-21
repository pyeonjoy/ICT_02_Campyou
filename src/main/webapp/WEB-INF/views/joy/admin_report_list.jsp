<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고 리스트</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<style type="text/css">
body {
	background-color: #F6FFF1;
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
  background-color: #032805;
  color: white;
  width: 1200px;
}
.grid_title{
  display: block;
}
.grid_row_content{
padding: .5rem;
width: 100%;
}

.btn{
  background-color: white;
  border: #032805;
  padding: 3px 10px;
  position: absolute;
  right: 0;
  font-weight: 600;
   cursor: pointer;
}
.pwrapper{
	grid-column: 3;
	display: flex;
	justify-content: center;
	flex-direction: column;
	align-items: center;
/* 	width: 100%; */
}  
.paging{
	display: flex;
	width: 100%;
	justify-content: center;
	list-style: none;
	margin: 1rem 0;
	align-items: center;
}

.nowpagecolor{
	padding: 0 0.5rem;
	margin: 0 0.5rem;
	text-decoration: none;
	background-color: #F6FFF1;
	color: #FFBA34;
	font-size: 1.4rem;
}
.nowpage{
	padding: 0 0.5rem;
	margin: 0 0.5rem;
	background-color: #F6FFF1;
	color: black;
	text-decoration: none;
	font-size: 1.4rem;
}
.to_disable{
	color: silver;
	margin: 0 1rem;
	text-decoration: none;
	border-radius: 50%; font-size: 2rem;
}
.nowpage:hover{
	color: #FFBA34;
}
.toPagingContainer{
	display: grid;
	grid-template-columns: repeat(5, 1fr);
    align-items: center;
}
.togetherWriteButton{
	grid-column: 4;
    display: flex;
    justify-content: flex-end;
}
.searchbtn{
width: 2.7rem;
    height: 25px;
    border: none;
    margin-right: 1rem;
    background-color: #041601;
    color: white;
    text-align: center;
}
</style>
<title>신고게시</title>
</head>
<body>
	<%@ include file="../hs/admin_menu.jsp"%>

	<div class="grid_container">
		<h3 class="grid_title" style="margin-bottom:100px;">신고게시판</h3>
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
							<a href="admin_member_detail.do?member_idx=${k.reportmember_idx}">${k.report_content }</a>
						</div>
						<div class="grid_row grid_row_content">${k.nickname1 }</div>
						<div class="grid_row grid_row_content">${k.nickname2 }</div>
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
		<div class="prapper">
			<div class="paging">
				<c:choose>
					<c:when test="${paging.beginBlock <= paging.pagePerBlock }">
						<li class="to_disable"><</li>
					</c:when>
					<c:otherwise>
						<li><a
							href="report_list.do?cPage=${paging.beginBlock-paging.pagePerBlock}"><</a>
						</li>
					</c:otherwise>
				</c:choose>

				<!-- 페이지번호들 -->
				<c:forEach begin="${paging.beginBlock }" end="${paging.endBlock }"
					step="1" var="k">
					<c:choose>
						<c:when test="${ k== paging.nowPage}">
							<li class="nowpagecolor">${k }</li>
						</c:when>
						<c:otherwise>
							<li ><a
								href="report_list.do?cPage=${k}" class="nowpage">${k}</a></li>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<!-- 이후 버튼 -->
				<c:choose>
					<c:when test="${paging.endBlock >= paging.totalPage }">
						<li class="to_disable">></li>
					</c:when>
					<c:otherwise>
						<li><a
							href="report_list.do?cPage=${paging.beginBlock+paging.pagePerBlock}">></a>
						</li>
					</c:otherwise>
				</c:choose>
			</div>
				<div>
					<form action="report_search.do" method="post">
					    <div class="search-wrap">
					        <select name="searchType">
					            <option value="content">신고 내용</option>
					            <option value="reportmember">신고대상자</option>
					            <option value="member">신고자</option>
					        </select>
					    	<input type="text" name="keyword">
					        <button type="submit" name="search" class="searchbtn">검색</button>
					    </div>
					    <input type="hidden" name="offset" value="1">
					    <input type="hidden" name="limit" value="10">
					</form>
				</div>
		</div>
	</div>
</body>
</html>