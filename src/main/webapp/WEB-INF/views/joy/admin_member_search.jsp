<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="ko">
<link href="resources/css/reset.css" rel="stylesheet" />
<link href="resources/css/joy/admin_member_detail.css" rel="stylesheet" />
<%@ include file="../hs/admin_menu.jsp" %>
<style type="text/css">
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
#bbs{
padding: 200px 100px 300px 100px;
}
#bbs table {
	width:1200px;
	margin:0 auto;
	margin-top:20px;
	border: 1px solid black;
	border-collapse: collapse;
	font-size: 14px;
}

#bbs table caption {
	font-size: 20px;
	font-weight: bold;
	margin-bottom: 10px;
}

#bbs table th, #bbs table td {
	text-align: center;
	border: 1px solid black;
	padding: 4px 10px;
	width: 9%;
}


/* paging */
table tfoot ol.paging {
	list-style: none;
}

table tfoot ol.paging li {
	float: left;
	margin-right: 8px;
}

table tfoot ol.paging li a {
	display: block;
	padding: 3px 7px;
	border: 1px solid #00B3DC;
	color: #2f313e;
	font-weight: bold;
}

table tfoot ol.paging li a:hover {
	background: #00B3DC;
	color: white;
	font-weight: bold;
}

.disable {
	padding: 3px 7px;
	border: 1px solid silver;
	color: silver;
}

.now {
	padding: 3px 7px;
	border: 1px solid #ff4aa5;
	background: #ff4aa5;
	color: white;
	font-weight: bold;
}
</style>
</head>
<body>
	<div id="bbs" align="center">
		<table summary="게시판 목록">
			<caption  style="margin-bottom:100px;"><h3>게시판 목록</h3></caption>
			<thead>
				<tr class="title">
					<th class="no">선택</th>
					<th class="no">idx</th>
					<th class="subject">id</th>
					<th class="subject">이름</th>
					<th class="subject">닉네임</th>
					<th class="subject">생년월일</th>
					<th class="subject">번호</th>
					<th class="subject">이메일</th>
					<th class="subject">가입일</th>
					<th class="subject">관리자</th>
					<th class="hit">등급</th>
					<th class="hit">로그인</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty searchmember }">
						<tr><td colspan="5"><h3>게시물이 존재하지 않습니다.</h3></td></tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="k" items="${searchmember}" varStatus="vs">
							<tr>
							  <form action="admin_member_detail.do?member_idx=${k.member_idx }" method="post">
							  <td><input type="submit" value="선택"></td>
							    <td>${k.member_idx }</td>
							    <td>${k.member_id }</td>
							    <td>${k.member_name }</td>
							    <td>${k.member_nickname }</td>
							    <td>${k.member_dob }</td>
							    <td>${k.member_phone }</td>
							    <td>${k.member_email }</td>
							    <td>${k.member_regdate }</td>
							    <td>${k.member_grade }</td>
							    <td>${k.member_active }</td>
							    <td>${k.member_login }</td>
							</form>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="13">
						<ol class="paging" style="margin: 0 auto; width: 175px;">
							<!-- 이전 버튼 -->
							<c:choose>
								<c:when test="${paging.beginBlock <= paging.pagePerBlock }">
									<li class="disable">이전으로</li>
								</c:when>
								<c:otherwise>
									<li><a href="admin_member_search.do?cPage=${paging.beginBlock - paging.pagePerBlock }">이전으로</a></li>
								</c:otherwise>
							</c:choose>
							<!-- 페이지번호들 -->
							<c:if test="${not empty cPage}">
							    <c:forEach begin="${paging.beginBlock}" end="${paging.endBlock}" step="1" var="k">
							        <c:choose>
							            <c:when test="${k == paging.nowPage}">
							                <li class="now">${k}</li>
							            </c:when>
							            <c:otherwise>
							                <li><a href="admin_member_search.do?cPage=${k}">${k}</a></li>
							            </c:otherwise>
							        </c:choose>
							    </c:forEach>
							</c:if>
							<!-- 이후 버튼 -->
								<c:choose>
								<c:when test="${paging.endBlock >= paging.totalPage }">
									<li class="disable">다음으로</li>
								</c:when>
								<c:otherwise>
									<li><a href="admin_member_search.do?cPage=${paging.beginBlock + paging.pagePerBlock }">다음으로</a></li>
								</c:otherwise>
							</c:choose>
						</ol>	
					</td>
				</tr>
				<tr>
				<td  colspan="13">
				<form action="member_search.do" method="post">
					    <div class="search-wrap">
					        <select name="searchType">
					            <option value="name">이름</option>
					            <option value="id">ID</option>
					            <option value="nickname">닉네임</option>
					        </select>
					    	<input type="text" name="keyword">
					        <button type="submit" name="search">검색</button>
					    </div>
					    <input type="hidden" name="pageNum" value="1">
					    <input type="hidden" name="amount" value="10">
					</form>
					</td>
				</tr>
			</tfoot>	
		</table>
	</div>
</body>
</html>