<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 회원 상세정보</title>
<link rel="stylesheet" href="${path}/resources/public/css/hu/communityBoardDetail.css">
<script type="text/javascript">
	function camping_gear_board_list(f) {
		f.action="camping_gear_board.do";
		f.submit()
	}	
	function camping_gear_update(f) {
		f.action="camping_gear_update.do";
		f.submit()
	}	
	function camping_gear_delete(f) {
		f.action="camping_gear_delete.do";
		f.submit()
	}	
</script>
</head>
<body>
	<div>
		<h2>게시글 회원정보</h2>
		<hr>
		<form method="post">
			<table>
				<tbody>
					<tr>
						<th bgcolor="#003300" style="color: white;">제목</th>
						<td>${cgbvo.cp_subject} </td>
					</tr>
					<tr>
						<th bgcolor="#003300" style="color: white;">닉네임</th>
						<td> ${cgbvo.member_nickname}</td>
					</tr>
					<tr>
						<th bgcolor="#003300" style="color: white;">날짜</th>
						<td>${cgbvo.cp_regdate.substring(0,10)} </td>
					</tr>
					<tr>
						<th bgcolor="#003300" style="color: white;">첨부파일</th>
						<c:choose>
							<c:when test="${empty cgbvo.cpf_name}">
								<td><b>첨부파일없음</b></td>
							</c:when>
							<c:otherwise>
								<td>
									<a href="camping_gear_pics_down.do?f_name=${cgbvo.cpf_name}"><img src="resources/upload/${cgbvo.cpf_name}" style="width: 80px"> </a>
								</td>
							</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<th bgcolor="#003300" style="color: white;">내용</th>
						<td><pre>${cgbvo.cp_content}</pre></td>
					</tr>
				</tbody>
				<tfoot>
					<tr id="foot-tr">
					     <td colspan="2">
					     	<input type="hidden" value="${cgbvo.cp_idx}" name="cp_idx">
					     	<input type="hidden" value="${cPage}" name="cPage">
					        <input type="button" class="board-member-info" value="목록" onclick="camping_gear_board_list(this.form)" />
					        <input type="button" class="board-member-info" value="수정" onclick="camping_gear_update(this.form)" />
					        <input type="button" class="board-member-info" value="삭제" onclick="camping_gear_delete(this.form)" />
					     </td>
					</tr>
				</tfoot>
			</table>
		</form>
	</div>
</body>
</html>