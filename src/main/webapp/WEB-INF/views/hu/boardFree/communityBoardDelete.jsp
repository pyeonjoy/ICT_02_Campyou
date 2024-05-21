<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
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
	function comm_board_list(f) {
		f.action ="community_board.do"
		f.submit();
	}
	function comm_board_delete_ok(f) {
		f.action ="comm_board_delete_ok.do"
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
				<div align="left"><input type="password" name="b_pwd"></div>
			</div>
			<div>
				<input type="hidden" name="b_idx" value="${b_idx}">
				<input type="hidden" name="cPage" value="${cPage}">
				<input id="listId" type="button" value="목록" onclick="comm_board_list(this.form)" /> 
				<input id="inputId" type="button" value="삭제" onclick="comm_board_delete_ok(this.form)" />
				<input id="cancelId" type="reset" value="취소" />
			
			</div>
		
	</form>
	</section>
</body>
</html>