<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/resources/public/css/hu/adminUpdate.css">
<script type="text/javascript">
	function admin_update_ok(f) {
		 f.action="admin_update_ok.do";
		 f.submit();
	}
</script>
</head>
<body>
	<div>
		<h2>관리자정보 수정</h2>
		<a href="admin_page.do">관리자 페이지 돌아가기</a>
		<hr><br><br>
		<form action="camping_gear_update_ok.do" method="post">
			<table>
					<tr align="center">
						<td bgcolor="#003300" style="color: white;">관리자이름</td>
						<td align="left"> <input type="text" name="admin_name" value="${admvo.admin_name}"></td>
					</tr>
					<tr align="center">
						<td bgcolor="#003300" style="color: white;">관리자닉네임</td>
						<td align="left">
						<input type="text" name="admin_nickname" value="${admvo.admin_nickname}">
						</td>
					</tr>
					<tr align="center">
						<td bgcolor="#003300" style="color: white;">관리자전화번호</td>
						<td align="left">
						<input type="text" name="admin_phone" value="${admvo.admin_phone}">
						</td>
					</tr>
					<tr align="center">
						<td bgcolor="#003300" style="color: white;">관리자이메일</td>
						<td align="left">
						<input type="email" name="admin_email" value="${admvo.admin_email}">
						</td>
					</tr>
					<tfoot>
						<tr align="center">
							<td colspan="2">
								<input type="hidden" name="admin_idx" value="${admvo.admin_idx}">
								<input type="hidden" name="cPage" value="${cPage}"> 
								<input id="inputId" type="button" value="수정" onclick="admin_update_ok(this.form)" /> 
								<input id="cancelId" type="reset" value="취소" />
							</td>
						</tr>
					</tfoot>
				</table>
		</form>
	</div>	
</body>
</html>