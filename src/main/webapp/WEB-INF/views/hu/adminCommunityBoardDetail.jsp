<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="path" value="${pageContext.request.contextPath}" />  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 회원 상세정보</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="${path}/resources/public/css/hu/communityBoardDetail.css">
<script type="text/javascript">
	function comm_board_list(f) {
		f.action="admin_community_board.do";
		f.submit()
	}	
	function comm_board_update(f) {
		f.action="admin_comm_board_update.do";
		f.submit()
	}	
	/* function comm_board_delete(f) {
		f.action="comm_board_delete.do";
		f.submit()
	}	 */
</script>
<style type="text/css">
body{
  background-color: #F6FFF1;
}
</style>
</head>
<body>
	<div>
		<h2>관리자: 게시글 회원정보</h2>
		<hr>
		<form method="post">
			<table>
				<tbody>
					<tr>
						<th bgcolor="#003300" style="color: white;">제목</th>
						<td>${cbvo.b_subject} </td>
					</tr>
					<tr>
						<th bgcolor="#003300" style="color: white;">닉네임</th>
						<td> ${cbvo.member_nickname} ${cbvo.admin_nickname} ${cbvo.member_name} ${cbvo.kakao_nickname}</td>
					</tr>
					<tr>
						<th bgcolor="#003300" style="color: white;">날짜</th>
						<td>${cbvo.b_regdate.substring(0,10)} </td>
					</tr>
					<tr>
						<th bgcolor="#003300" style="color: white;">첨부파일</th>
						<c:choose>
							<c:when test="${empty cbvo.bf_name}">
								<td><b>첨부파일없음</b></td>
							</c:when>
							<c:otherwise>
								<td>
									<a href="comm_board_down.do?f_name=${cbvo.bf_name}"><img src="resources/upload/${cbvo.bf_name}" style="width: 80px"> </a>
								</td>
							</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<th bgcolor="#003300" style="color: white;">내용</th>
						<td><pre>${cbvo.b_content}</pre></td>
					</tr>
				</tbody>
				<tfoot>
					<tr id="foot-tr">
					     <td colspan="2">
					     	<input type="hidden" value="${cbvo.b_idx}" name="b_idx">
					     	<input type="hidden" value="${cPage}" name="cPage">
					        <input type="button" class="board-member-info" value="목록" onclick="comm_board_list(this.form)" />
					        <input type="button" class="board-member-info" value="수정" onclick="comm_board_update(this.form)" />
					        <!-- <input type="button" class="board-member-info" value="삭제" onclick="comm_board_delete(this.form)" /> -->
					     </td>
					</tr>
				</tfoot>
			</table>
		</form>
	</div>
</body>
</html>