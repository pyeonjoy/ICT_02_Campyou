<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE HTML>
<html>
<head>
<meta charset=UTF-8>
<title>Insert title here</title>
<style type="text/css">
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

.no { width: 10% }
.story{ width: 10%}
.subject { 	width: 35% }
.writer {	width: 15% }
.reg {	width: 20% }
.hit {	width: 10% }
.title {	background: #003300; color:white}
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
<script type="text/javascript">
	function commBoard_write() {
		location.href = "comm_board_write.do";
	}
	function commBoard_write_alert(){
		alert("회원님만 글쓰기 하실수 있습니다.\n회원가입이나 로그인 해주세요");
	}
</script>
</head>
<body>
	<div id="bbs" align="center">
		<table summary="게시판 목록">
			<caption>게시판 목록</caption>
			<a href="/">메인페이지</a>
			<thead>
				<tr class="title">
					<th class="no">번호</th>
					<th class="story">유형</th>
					<th class="subject">제목</th>
					<th class="writer">닉네임</th>
					<th class="reg">날짜</th>
					<th class="hit">조회수</th>
				</tr>
			</thead>
			<tbody> 
				<c:choose>
					<c:when test="${empty commBoard_list}">
						<tr><td colspan="6"><h3>게시물이 존재하지 않습니다.</h3></td></tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="k" items="${commBoard_list}" varStatus="vs">
							<tr>
							    <td>${paging.totalRecord - ((paging.nowPage-1)*paging.numPerPage + vs.index)}</td>
							    <td>${k.b_type}</td>
							    <!-- <td style="text-align: left; " /> -->
							    <c:forEach begin="1" end="${k.step}">&nbsp;[Re]</c:forEach>
							    <c:choose>
							    	<c:when test="${k.active == 1}">
							    		<span style="color:lightgray">삭제된 게시물입니다</span>
							    	</c:when>
							    	<c:otherwise>
							    		<td><a href="commBoard_content.do?b_idx=${k.b_idx}&cPage=${paging.nowPage}">${k.b_title}</a></td>
									</c:otherwise>
							    </c:choose>
							    <c:choose>
									<c:when test="${memberInfo.member_id == 'admin'}">
										<td><a href="commBoard_detail.do?b_idx=${k.b_idx}&cPage=${paging.nowPage}">${k.member_nickname}</a></td>
									</c:when>
									<c:otherwise>
									    <c:choose>
									        <c:when test="${memberInfo.member_nickname == k.member_nickname}">
									            <td><a href="commBoard_detail.do?b_idx=${k.b_idx}&cPage=${paging.nowPage}">${k.member_nickname}</a></td>
									        </c:when>
									        <c:otherwise>
									            <td>${k.member_nickname}</td>
									        </c:otherwise>
									    </c:choose>
									</c:otherwise>
								</c:choose>
							    <td>${k.regdate.substring(0,10)}</td>
							    <td>${k.hit}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4">
						<ol class="paging">
							<!-- 이전 버튼 -->
							<c:choose>
								<c:when test="${paging.beginBlock <= paging.pagePerBlock}">
									<li class="disable">이전으로</li>
								</c:when>
								<c:otherwise>
									<li><a href="community_board.do?cPage=${paging.beginBlock - paging.pagePerBlock}">이전으로</a></li>
								</c:otherwise>
							</c:choose>
							<!-- 페이지번호들 -->
							<c:forEach begin="${paging.beginBlock }" end="${paging.endBlock}" step="1" var="k">
								<c:choose>
									<c:when test="${k == paging.nowPage }">
										<li class="now">${k}</li>
									</c:when>
									<c:otherwise>
										<li><a href="community_board.do?cPage=${k}">${k}</a></li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<!-- 이후 버튼 -->
							<c:choose>
								<c:when test="${paging.endBlock >= paging.totalPage }">
									<li class="disable">다음으로</li>
								</c:when>
								<c:otherwise>
									<li><a href="community_board.do?cPage=${paging.beginBlock + paging.pagePerBlock }">다음으로</a></li>
								</c:otherwise>
							</c:choose>
						</ol>	
					</td>
					<td>
						<c:choose>
							<c:when test="${memberInfo != null}">
								<input type="button" value="글쓰기" onclick="commBoard_write()">
							</c:when>
							<c:otherwise>
								<input type="button" value="글쓰기" onclick="commBoard_write_alert()">
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</tfoot>	
		</table>
	</div>
</body>
</html>
