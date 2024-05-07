<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- summer note -->
<link rel="stylesheet" href="resources/css/summernote-lite.css">
<link rel="stylesheet" href="${path}/resources/public/css/hu/communityBoardUpdate.css">
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
		f.action="camping_gear_board.do";
		f.submit();
	}

	function camping_gear_update_ok(f) {
		for (var i = 0; i < f.elements.length; i++) {
			if (f.elements[i].value == "") {
				if (i == 2) continue;
				if(i == 5) break;
				alert(f.elements[i].name + "를 입력하세요");
				f.elements[i].focus();
				return;//수행 중단
			}
		}
		f.action="camping_gear_update_ok.do";
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
		<form action="camping_gear_update_ok.do" method="post" enctype="multipart/form-data">
			<table>
					<tr align="center">
						<td bgcolor="#003300" style="color: white;">제목</td>
						<td align="left"> <input type="text" name="cp_subject" value="${cgbvo.cp_subject}"></td>
					</tr>
					<tr align="center">
						<td bgcolor="#003300" style="color: white;">별명</td>
						<td align="left">${cgbvo.member_nickname}
						<input type="hidden" name="member_nickname" value="${cgbvo.member_nickname}">
						</td>
					</tr>
					<tr>
						<th bgcolor="#003300" style="color: white;">첨부파일</th>
						<td align="left"><input type="file" name="file"></td>
					</tr>
					<tr>
						<th bgcolor="#003300" style="color: white;">비밀번호</th>
						<td align="left"><input type="password" name="cp_pwd"></td>
					</tr>
					<tr align="center">
						<td colspan="2">
							<textarea rows="10" cols="60" id="cp_content" name="cp_content">${cgbvo.cp_content}</textarea>
						</td>
					</tr>
					<tfoot>
						<tr align="center">
							<td colspan="2">
								<input type="hidden" name="cp_idx" value="${cgbvo.cp_idx}">
								<input type="hidden" name="cPage" value="${cPage}">
								<input id="listId" type="button" value="목록" onclick="camping_gear_list(this.form)" /> 
								<input id="inputId" type="button" value="수정" onclick="camping_gear_update_ok(this.form)" /> 
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
	$(function() {
		$("#cp_content").summernote({
			lang : 'ko-KR',
			height : 300,
			focus : true,
			placeholder: '최대3000자까지 쓸 수 있습니다'	, //placeholder 설정
			callbacks : {
				onImageUpload : function(files, editor) {
					for (var i = 0; i < files.length; i++) {
						console.log("i = " , files)
							sendImage(files[i], editor);						
					}
				}
			}
		});
		// $("#content").summernote("lineHeight",.7);
	});
</script>	
</body>
</html>