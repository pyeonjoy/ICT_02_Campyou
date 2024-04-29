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
	
	.no {width:15%}
	.subject {width:30%}
	.writer {width:20%}
	.reg {width:20%}
	.hit {width:15%}
	.title{background:lightsteelblue}
	.odd {background:silver}
</style>
<script type="text/javascript">
	function comm_board_reply_ok(f) {
		for (var i = 0; i < f.elements.length; i++) {
			if (f.elements[i].value == "") {
				if (i == 3) continue;
				alert(f.elements[i].name + "를 입력하세요");
				f.elements[i].focus();
				return;//수행 중단
			}
		}
		f.submit();
	}
	function comm_board_list(f) {
		f.action="community_board.do";
		f.submit();
	}
</script>
</head>
<body>
	<form action="comm_board_reply_ok.do" method="post" enctype="multipart/form-data">
		<table width="700">
		<tbody>
			<tr>
				<th>별명</th>
				<td align="left"><input type="text" name="member_nickname" value="${memberInfo.member_nickname}"></td>
			</tr>
			<tr>
				<th>제목</th>
				<td align="left"> <input type="text" name="b_title"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td align="left"><textarea rows="10" cols="60" name="b_content"></textarea>
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td align="left"><input type="file" name="file"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td align="left"><input type="password" name="b_pwd"></td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="hidden" name="cPage" value="${cPage}">
				<input type="hidden" name="b_idx" value="${b_idx}">
				<input type="button" value="답글입력" onclick="comm_board_reply_ok(this.form)" /> 
				<input type="button" value="목록" onclick="comm_board_list(this.form)" /> 
				<input type="reset" value="취소" />
				</td>
			</tr>
            </tbody>
		</table>
	</form>
</body>
</html>