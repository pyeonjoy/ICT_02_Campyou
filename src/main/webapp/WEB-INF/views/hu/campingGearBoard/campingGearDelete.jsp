<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/resources/public/css/hu/communityBoardDelete.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		let pwdchk = "${pwdchk}";
		if(pwdchk == 'fail'){
			alert("비밀번호틀림");
			return;
		}
	});
</script>
<script type="text/javascript">
	function camping_gear_list(f) {
		f.action ="camping_gear_board.do"
		f.submit();
	}
	function camping_gear_delete_ok(f) {
		f.action ="camping_gear_delete_ok.do"
		f.submit();
	}
	function comm_board_admin_delete_ok(f){
		f.action ="comm_board_admin_delete_ok.do"
		f.submit();
	}
</script>
</head>
<body>
<section>
	<form method="post" >
		
			<div>
				<div id="pwdDiv" bgcolor="#003300">비밀번호</div>
				<div align="left"><input type="password" name="cp_pwd"></div>
			</div>
			<div>
				<input type="hidden" name="cp_idx" value="${cp_idx}">
				<input type="hidden" name="cPage" value="${cPage}">
				<input id="listId" type="button" value="목록" onclick="camping_gear_list(this.form)" /> 
				<input id="inputId" type="button" value="삭제" onclick="camping_gear_delete_ok(this.form)" />
				<input id="cancelId" type="reset" value="취소" />
			
			</div>
		
	</form>
	</section>
</body>
</html>