<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../hs/admin_header.jsp"%>
<%@ include file="../hs/admin_menu.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>팝업</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<style>
@font-face {
    font-family: 'JalnanGothic';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_231029@1.1/JalnanGothic.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
h2{
     font-family: 'JalnanGothic';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_231029@1.1/JalnanGothic.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
h3{
    font-family: 'JalnanGothic';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_231029@1.1/JalnanGothic.woff') format('woff');
    font-weight: normal;
    font-style: normal;
    line-height: 30px;

}
h4{
    font-family: 'JalnanGothic';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_231029@1.1/JalnanGothic.woff') format('woff');
    font-weight: normal;
    font-style: normal;
    line-height: 30px;
}
body {
	background-color: #F6FFF1;
}

.head {
	text-align: center;
	padding: 200px 50px 30px 50px;
}

.wrap {
	display: grid;
	grid-template-columns: 1fr 1fr;
	grid-gap: 10px;
	margin: 0 auto;
	height: 800px;
	width: 1230px;
}

.hr {
	width: 500px;
}

.mainimg {
	width: 500px;
	height: 500px;
	margin: 30px auto;
	object-fit: cover;
}

.left {
	width: 500px;
	height: 500px;
}

.right {
	width: 1000px;
	height: 800px;
}

.subimg {
	width: 150px;
	height: 150px;
	background-color: gainsboro;
}

button {
	margin-top: 20px;
	width: 100px;
	height: 30px;
	background-color: #032805;
	color: white;
	border: 0px;
	border-radius: 3px;
	margin: 0 auto;
}

.b1 {
	float: right;
}

li {
	list-style: none;
}

table {
	width: 800px;
	margin: 0 auto;
	margin-top: 20px;
	font-size: 14px;
	border-collapse: collapse;
}

table caption {
	font-size: 20px;
	font-weight: bold;
	margin-bottom: 10px;
}

table th, #bbs table td {
	text-align: center;
	padding: 4px 10px;
	border-collapse: collapse;
	padding: 10px;
}


.no {
	width: 15%
}

.subject {
	width: 30%
}

.writer {
	width: 20%
}

.reg {
	width: 20%
}

.hit {
	width: 15%
}

.title {
	background: #041601;
	color: white
}

.odd {
	background: silver
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
.disable{
	color: silver;
	margin: 0 1rem;
	text-decoration: none;
	border-radius: 50%; font-size: 2rem;
}
.to_able{
	color: black;
	margin: 0 1rem;
	text-decoration: none;
}
.nowpage:hover{
	color: #FFBA34;
}
</style>
</head>
<body>
	<h3 class="head">팝업 관리</h3>
	<div class="wrap">
		<div class="left">
					<img class="mainimg" src="resources/popup/${f_name}">
		</div>
		<div class="right">
			<div id="bbs" align="center">
				<table summary="팝업 목록">
					<caption>팝업 목록</caption>
					<thead>
						<tr class="title">
							<th class="child">선택</th>
							<th class="child">번호</th>
							<th class="child">미리보기</th>
							<th class="child">제목</th>
							<th class="child">작성자</th>
							<th class="child">작성 날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty pop }">
								<tr>
									<td colspan="5"><h3>게시물이 존재하지 않습니다.</h3></td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="k" items="${pop}" varStatus="vs">
										
									<tr>
										<form action="popup_update.do" method="post">
											<input type="hidden" name="popidx" value="${k.popidx}">
											<input type="hidden" name="active" value="${k.active}">
											<td><input type="submit" value="선택"> <input
												type="button" value="삭제"
												onclick="location.href='popup_delete.do?popidx=${k.popidx}'">
											</td>
											<td>${paging.totalRecord - ((paging.nowPage-1)*paging.numPerPage + vs.index )}</td>
											<td><img style="object-fit: cover;" class="subimg"
												src="resources/popup/${k.f_name}"></td>
											<td>${k.title }</a>
											</td>
											<td class="child">${k.writer }</td>
											<td>${k.regdate.substring(0,10)}</td>
										</form>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="6">
								<ol class="paging">
									<!-- 이전 버튼 -->
									<c:choose>
										<c:when test="${paging.beginBlock <= paging.pagePerBlock }">
											<li class="disable"><</li>
										</c:when>
										<c:otherwise>
											<li><a
												href="board_list.do?cPage=${paging.beginBlock - paging.pagePerBlock }">이전으로</a></li>
										</c:otherwise>
									</c:choose>
									<!-- 페이지번호들 -->
									<c:forEach begin="${paging.beginBlock }"
										end="${paging.endBlock }" step="1" var="k">
										<c:choose>
											<c:when test="${k == paging.nowPage }">
												<li class="nowpagecolor">${k}</li>
											</c:when>
											<c:otherwise>
												<li><a href="popup.do?cPage=${k}" class="nowpage">${k }</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>

									<!-- 이후 버튼 -->
									<c:choose>
										<c:when test="${paging.endBlock >= paging.totalPage }">
											<li class="disable">></li>
										</c:when>
										<c:otherwise>
											<li><a
												href="popup.do?cPage=${paging.beginBlock + paging.pagePerBlock }">다음으로</a></li>
										</c:otherwise>
									</c:choose>
								</ol>
								<p>
									<input type="button" value="글쓰기"
										onclick="location.href='popup_write.do'">
								</p>
							</td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
<%-- 		<jsp:include page="../hs/footer.jsp" /> --%>
</body>
</html>