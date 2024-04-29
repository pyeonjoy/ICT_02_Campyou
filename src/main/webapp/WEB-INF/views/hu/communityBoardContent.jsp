<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
tr {
		
	    text-align:center;
	    padding:4px 10px;
	    background-color: #F6F6F6;
	}
	
th {
		width:120px;
	    text-align:center;
	    padding:4px 10px;
	    background-color: #B2CCFF;
	}
</style>
<script type="text/javascript">
	function comm_board_list(f) {
		f.action="community_board.do";
		f.submit()
	}	
	function comm_reply_go(f) {
		f.action="comm_reply_go.do";
		f.submit()
	}	
	function comm_board_update(f) {
		f.action="comm_board_update.do";
		f.submit()
	}	
	function comm_board_delete(f) {
		f.action="comm_board_delete.do";
		f.submit()
	}	
</script>
</head>
<body>
	<form method="post">
	<table width="700">
	<tbody>
	<tr>
		<th bgcolor="#B2EBF4">제목</th>
		<td>${cbvo.b_title} </td>
	</tr>
	<tr>
		<th bgcolor="#B2EBF4">닉네임</th>
		<td> ${cbvo.member_nickname}</td>
	</tr>
	<tr>
		<th bgcolor="#B2EBF4">날짜</th>
		<td>${cbvo.regdate.substring(0,10)} </td>
	</tr>
	<tr>
		<th bgcolor="#B2EBF4">내용</th>
		<td><pre>${cbvo.b_content}</pre></td>
	</tr>
	<tr>
		<th bgcolor="#B2EBF4">첨부파일</th>
		<c:choose>
			<c:when test="${empty cbvo.f_name}">
				<td><b>첨부파일없음</b></td>
			</c:when>
			<c:otherwise>
				<td>
					<a href="comm_board_down.do?f_name=${cbvo.f_name}"><img src="resources/upload/${cbvo.f_name}" style="width: 80px"> </a>
				</td>
			</c:otherwise>
		</c:choose>
	</tr>
	</tbody>
	<tfoot>
	<tr>
     <td colspan="2">
     <c:choose>
     		<c:when test="${memberInfo.member_id == 'admin'}">
     			<input type="hidden" value="${cbvo.b_idx}" name="b_idx">
     			<input type="hidden" value="${cPage}" name="cPage">
        		<input type="button" value="목록" onclick="comm_board_list(this.form)" />
        		<input type="button" value="답글" onclick="comm_reply_go(this.form)" />
        		<input type="button" value="수정" onclick="comm_board_update(this.form)" />
        		<input type="button" value="삭제" onclick="comm_board_delete(this.form)" />
     		</c:when>
     		<c:otherwise>
     			<c:choose>			
     				<c:when test="${memberInfo.member_nickname == cbvo.member_nickname}">
     					<input type="hidden" value="${cbvo.b_idx}" name="b_idx">
     					<input type="hidden" value="${cPage}" name="cPage">
        				<input type="button" value="목록" onclick="comm_board_list(this.form)" />
        				<input type="button" value="답글" onclick="comm_reply_go(this.form)" />
        				<input type="button" value="수정" onclick="comm_board_update(this.form)" />
        				<input type="button" value="삭제" onclick="comm_board_delete(this.form)" />
     				</c:when>
     				<c:otherwise>
     					<c:choose>
     						<c:when test="${memberInfo.member_nickname == null}">
     							<input type="button" value="목록" onclick="comm_board_list(this.form)" />
     						</c:when>
     						<c:otherwise>
     							<input type="hidden" value="${cbvo.b_idx}" name="b_idx">
     							<input type="hidden" value="${cPage}" name="cPage">
     							<input type="button" value="목록" onclick="comm_board_list(this.form)" />
        						<input type="button" value="답글" onclick="comm_reply_go(this.form)" />
     						</c:otherwise>
     					</c:choose>
     				</c:otherwise>
     			</c:choose>
     		</c:otherwise>
     	</c:choose>
     </td>
	</tr>
	</tfoot>
	</table>
	</form>
</body>
</html>