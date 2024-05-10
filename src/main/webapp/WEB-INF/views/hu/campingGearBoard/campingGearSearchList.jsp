<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/resources/public/css/hu/boardFreeSearchlist.css">
<script type="text/javascript">
	function camping_gear_board(f) {
		f.action="camping_gear_board.do";
		f.submit()
	}
</script>
</head>
<body>
	<h2>게시판 검색</h2>
	<form action="post">
		<article>
			<table>
				<thead>
					<tr><td>닉네임</td><td>제목</td><td>내용</td><td>날짜</td></tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty searchlist}">
							<tr><td colspan="5"><h3>원하시는 자료는 존재하지 않습니다</h3></td></tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${searchlist}" var="k">
								<tr>
									<td>${k.member_nickname}</td>
									<td>${k.cp_subject}</td>
									<td>${k.cp_content}</td>
									<td>${k.cp_regdate.substring(0,10)}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</article>
		<section id="btn-position">
			<input id="btn" type="button" value="목록" onclick="camping_gear_board(this.form)" />
		</section>
	</form>
</body>
</html>









