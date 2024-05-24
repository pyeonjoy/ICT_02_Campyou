<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- summer note -->
<link rel="stylesheet" href="resources/css/summernote-lite.css">
<link rel="stylesheet" href="${path}/resources/public/css/hu/communityBoardUpdate.css">
<link rel="stylesheet" href="${path}/resources/public/css/hu/summernote.css">
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
		f.action="community_board.do";
		f.submit();
	}

	function comm_board_update_ok(f) {
		for (var i = 0; i < f.elements.length; i++) {
			if (f.elements[i].value == "") {
				if (i == 2 || i == 3) continue;
				if(i == 6) break;
				alert(f.elements[i].name + "를 입력하세요");
				f.elements[i].focus();
				return;//수행 중단
			}
		}
		f.action="comm_board_update_ok.do";
		f.submit();
	}
</script>
<style>
    select {
        float: left;
    }
</style>
</head>
<body>
	<div>
		<h2>게시글 수정</h2>
		<hr><br><br>
		<form action="comm_board_update_ok.do" method="post" enctype="multipart/form-data">
			<table>
					<tr align="center">
						<td bgcolor="#003300" style="color: white;">유형</td>
						<c:choose>
							<c:when test="${cbvo.admin_nickname == '관리자'}">
								<td>
									<select name="b_type">
										<option value="공지사항">공지사항</option>
										<option value="날씨정보">날씨정보</option>
										<option value="주의사항">주의사항</option>
									</select>
								<!-- <td align="left"><input type="hidden" name="b_type"></td>  -->
								</td>
							</c:when>
							<c:otherwise>
								<td>
									<select name="b_type">
										<option value="정보공유">정보공유</option>
										<option value="경험담">경험담</option>
										<option value="썰">썰</option>
										<option value="유머">유머</option>
										<option value="후기">후기</option>
										<option value="불평">불평</option>
									</select>
								<!-- <td align="left"><input type="hidden" name="b_type"></td>  -->
								</td>		
							</c:otherwise>
						</c:choose>
					</tr>
					<tr align="center">
						<td bgcolor="#003300" style="color: white;">제목</td>
						<td align="left"> <input type="text" name="b_subject" value="${cbvo.b_subject}"></td>
					</tr>
					<tr align="center">
						<td bgcolor="#003300" style="color: white;">별명</td>
						<td align="left">${cbvo.member_nickname} ${cbvo.admin_nickname}${cbvo.member_name}
						<input type="hidden" name="member_nickname" value="${cbvo.member_nickname}">
						</td>
					</tr>
					<tr>
						<th bgcolor="#003300" style="color: white;">첨부파일</th>
						<td align="left"><input type="file" name="file"></td>
					</tr>
					<tr>
						<th bgcolor="#003300" style="color: white;">비밀번호</th>
						<td align="left"><input type="password" name="b_pwd"></td>
					</tr>
					<tr align="center">
						<td colspan="2">
							<textarea rows="10" cols="60" id="b_content" name="b_content">${cbvo.b_content}</textarea>
						</td>
					</tr>
					<tfoot>
						<tr align="center">
							<td colspan="2">
								<input type="hidden" name="b_idx" value="${cbvo.b_idx}">
								<input type="hidden" name="cPage" value="${cPage}">
								<input id="listId" type="button" value="목록" onclick="comm_board_list(this.form)" /> 
								<input id="inputId" type="button" value="수정" onclick="comm_board_update_ok(this.form)" /> 
								<input id="cancelId" type="reset" value="취소" />
							</td>
						</tr>
					</tfoot>
				</table>
		</form>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js" crossorigin="anonymous"></script>
<script src="resources/js/summernote-lite.js" ></script>
<script src="resources/js/lang/summernote-ko-KR.js" ></script>
<script type="text/javascript">
$(document).ready(function () {
    $('#b_content').summernote({
        placeholder: '내용을 작성하세요',
        height: 400,
        maxHeight: 400
    });
});
</script>	
</body>
</html>