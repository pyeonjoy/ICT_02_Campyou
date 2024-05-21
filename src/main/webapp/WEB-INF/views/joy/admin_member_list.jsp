<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!doctype html>
<html lang="ko">
<link href="resources/css/reset.css" rel="stylesheet" />
<link rel="shortcut icon" href="${path}/resources/favicon.ico" type="image/x-icon">
<link rel="icon" href="${path}/resources/favicon.ico" type="image/x-icon">
<link href="resources/css/joy/admin_member_detail.css" rel="stylesheet" />
<%@ include file="../hs/admin_menu.jsp" %>
<head>
<title>회원 리스트</title>
<style type="text/css">
body {
	background-color: #F6FFF1;
}
#bbs{
padding: 200px 100px 300px 100px;
}
#bbs table {
	width:1500px;
	margin:0 auto;
	margin-top:20px;
	border-collapse: collapse;
	font-size: 14px;
	background-color: #F6FFF1;
}

#bbs table caption {
	font-size: 20px;
	font-weight: bold;
	margin-bottom: 10px;
}

#bbs table th, #bbs table td {
	text-align: center;
	padding: 14px 10px;
	
}
#bbs table th{
  background-color: #032805;
  color: white;
   width: 1500px;
}
#bbs table td{
	border-bottom: 1px solid black;
  background-color: white;
  color: #032805;
  background-color: #F6FFF1;
}


tfoot tr {
    text-align: center;
    padding: 10px; /* 중복된 padding 속성을 하나로 통합 */
    border: 5px solid #F6FFF1;
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
</head>
<body>
	<div id="bbs" align="center">
		<table summary="게시판 목록">
			<caption style="margin-bottom:100px;"><h3>유저 목록</h3></caption>
			<thead>
				<tr class="title">
					<th >선택</th>
					<th class="no">idx</th>
					<th class="subject">id</th>
					<th class="writer">이름</th>
					<th class="subject">닉네임</th>
					<th class="subject">생년월일</th>
					<th class="subject" style="width:500px;">번호</th>
					<th class="subject">이메일</th>
					<th class="subject">가입일</th>
					<th class="subject">등급</th>
					<th class="subject">상태</th>
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
							  <td><input type="submit" value="선택" style="background-color:#FFBA34"></td>
							    <td>${k.member_idx }</td>
							    <td>${k.member_id }</td>
							    <td>${k.member_name }</td>
							    <td>${k.member_nickname }</td>
							    <td>${k.member_dob }</td>
							    <td>${k.member_phone }</td>
							    <td>${k.member_email }</td>
							    <td class="subject">${k.member_regdate }</td>
							    <c:if test="${k.member_grade== 0}">
							    <td class="subject">일반회원</td>
							    </c:if>
							    <c:if test="${k.member_grade== 1}">
							    <td class="subject">열심회원</td>
							    </c:if>
							    <c:if test="${k.member_grade== 2}">
							    <td class="subject">우수회원</td>
							    </c:if>
							    <c:if test="${k.member_active== 0}">
							    <td class="subject">일반회원</td>
							    </c:if>
							    <c:if test="${k.member_active== -1}">
							    <td class="subject">정지회원</td>
							    </c:if>
							    <c:if test="${k.member_active== -2}">
							    <td class="subject">탈퇴회원</td>
							    </c:if>
							</form>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
			<tfoot>
				<tr >
					<td colspan="13" class="prapper">
						<ol class="paging" style="margin: 0 auto; width: 275px;">
							<!-- 이전 버튼 -->
							<c:choose>
								<c:when test="${paging.beginBlock <= paging.pagePerBlock }">
									<li class="disable"><</li>
								</c:when>
								<c:otherwise>
									<li><a href="admin_member_list.do?cPage=${paging.beginBlock - paging.pagePerBlock }">이전으로</a></li>
								</c:otherwise>
							</c:choose>
							<!-- 페이지번호들 -->
							<c:forEach begin="${paging.beginBlock }" end="${paging.endBlock }" step="1" var="k">
								<c:choose>
									<c:when test="${k == paging.nowPage }">
										<li class="nowpagecolor">${k}</li>
									</c:when>
									<c:otherwise>
										<li><a href="admin_member_list.do?cPage=${k}" class="nowpage">${k}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<!-- 이후 버튼 -->
								<c:choose>
								<c:when test="${paging.endBlock >= paging.totalPage }">
									<li class="disable">></li>
								</c:when>
								<c:otherwise>
									<li><a href="admin_member_list.do?cPage=${paging.beginBlock + paging.pagePerBlock }">다음으로</a></li>
								</c:otherwise>
							</c:choose>
						</ol>	
					</td>
				</tr>
				<tr>
				<td colspan="13">
					<form action="member_search.do" method="post">
					    <div class="search-wrap">
					        <select name="searchType">
					            <option value="name">이름</option>
					            <option value="id">ID</option>
					            <option value="nickname">닉네임</option>
					        </select>
					    	<input type="text" name="keyword">
					        <button type="submit" name="search"  class="searchbtn">검색</button>
					    </div>
					    <input type="hidden" name="offset" value="1">
					    <input type="hidden" name="limit" value="10">
					</form>
				</td>
				</tr>
			</tfoot>	
		</table>
	</div>
	<jsp:include page="../hs/footer.jsp" />
</body>
</html>