<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
</script>
</head>
<body>
	<form method="post" >
		<table width="700">
		<tbody>
			<tr>
				<th>비밀번호</th>
				<td align="left"><input type="password" name="b_pwd"></td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="hidden" name="b_idx" value="${b_idx}">
				<input type="hidden" name="cPage" value="${cPage}">
				<input type="button" value="목록" onclick="comm_board_list(this.form)" /> 
				<input type="button" value="삭제" onclick="comm_board_delete_ok(this.form)" /> 
				<input type="reset" value="취소" />
				</td>
			</tr>
            </tbody>
		</table>
	</form>
</body>
</html>