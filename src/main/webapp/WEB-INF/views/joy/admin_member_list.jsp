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
#bbs{
padding-top: 300px;
}
#bbs table {
	width:800px;
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
}

.no { width: 15% }
.subject { 	width: 30% }
.writer {	width: 20% }
.reg {	width: 20% }
.hit {	width: 15% }
.title {	background: lightsteelblue }
.odd {	background: silver }

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
			<caption>게시판 목록</caption>
			<thead>
				<tr class="title">
					<th class="no">선</th>
					<th class="no">idx</th>
					<th class="subject">이미지</th>
					<th class="subject">id</th>
					<th class="writer">이름</th>
					<th class="reg">닉네임</th>
					<th class="reg">생년월일</th>
					<th class="hit">번호</th>
					<th class="hit">이메일</th>
					<th class="hit">가입일</th>
					<th class="subject">관리자</th>
					<th class="hit">등급</th>
					<th class="hit">로그인</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${empty member }">
						<tr><td colspan="5"><h3>게시물이 존재하지 않습니다.</h3></td></tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="k" items="${member}" varStatus="vs">
							<tr>
							  <form action="admin_member_detail.do?member_idx=${k.member_idx }" method="post">
							  <td><input type="submit" value="선택"></td>
							    <td>${k.member_idx }</td>
							    <td>${k.member_img }</td>
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
									<li><a href="admin_member_list.do?cPage=${paging.beginBlock - paging.pagePerBlock }">이전으로</a></li>
								</c:otherwise>
							</c:choose>
							<!-- 페이지번호들 -->
							<c:forEach begin="${paging.beginBlock }" end="${paging.endBlock }" step="1" var="k">
								<c:choose>
									<c:when test="${k == paging.nowPage }">
										<li class="now">${k}</li>
									</c:when>
									<c:otherwise>
										<li><a href="admin_member_list.do?cPage=${k}">${k}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<!-- 이후 버튼 -->
								<c:choose>
								<c:when test="${paging.endBlock >= paging.totalPage }">
									<li class="disable">다음으로</li>
								</c:when>
								<c:otherwise>
									<li><a href="admin_member_list.do?cPage=${paging.beginBlock + paging.pagePerBlock }">다음으로</a></li>
								</c:otherwise>
							</c:choose>
						</ol>	
					</td>
				</tr>
			</tfoot>	
		</table>
	</div>
</body>
</html>