<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>켐핑게시판</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<!-- summer note -->
<link rel="stylesheet" href="resources/css/summernote-lite.css">
<link rel="stylesheet" href="${path}/resources/public/css/hu/communityBoardWrite.css">
 <style type="text/css">
	/* summernote toolbar 수정 */
	.note-btn-group{width: auto;}
	.note-toolbar{width: auto;}
</style> 
<script type="text/javascript">
	function camping_gear_board(f) {
		for (var i = 0; i < f.elements.length; i++) {
			if (f.elements[i].value == "") {
				if (i == 1 || i == 2 || i == 3 || i == 4) continue;
				if(i == 7) break;
				
				var customMessages = {
						"cp_subject": "제목",
						"cp_pwd": "비밀번호",
						"cp_content": "내용"
					};
				var message = customMessages[f.elements[i].name] || f.elements[i].name;
				
				alert(message + " 을(를) 입력하세요");
				f.elements[i].focus();
				return; //수행 중단
			}
		}
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
		<h2>캠핑게시판 글쓰기</h2>
		<hr>
		<p><a href="camping_gear_board.do">캠핑게시판 돌아가기</a></p>
		<form action="camping_gear_write_ok.do" method="post" enctype="multipart/form-data">
			<table>
				<tr align="center">
					<td bgcolor="#003300" style="color: white;">제목</td>
					<td align="left"><input type="text" name="cp_subject"></td>
				</tr>
				<tr align="center">
					<td bgcolor="#003300" style="color: white;">별명</td>
					<c:choose>
						<c:when test="${adminInfo != null}">
							<td align="left">
							<select name="admin_nickname">
									<option value="${adminInfo.admin_nickname}">${adminInfo.admin_nickname}</option>
									<option value="관리자">관리자</option>
							</select>
							
							<%-- <input type="hidden" name="admin_nickname" value="${adminInfo.admin_nickname}"> --%>
							<input type="hidden" name="member_nickname" value="${memberInfo.member_nickname}"></td>
						</c:when>
						<c:otherwise>
							<td align="left">${memberInfo.member_nickname} ${naverMemberInfo.member_name}
							<c:choose>
								<c:when test="${memberInfo != null}">
									<input type="hidden" name="member_nickname" value="${memberInfo.member_nickname}">
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
							<input type="hidden" name="admin_nickname" value="${adminInfo.admin_nickname}">
							<input type="hidden" name="member_grade" value="${memberInfo.member_grade}"></td>
							<c:choose>
								<c:when test="${naverMemberInfo != null}">
									<input type="hidden" name="member_name" value="${naverMemberInfo.member_name}">
								</c:when>
								<c:otherwise>
								</c:otherwise>
							</c:choose>
							
						</c:otherwise>
						<%-- <c:otherwise>
							<td align="left">${memberInfo.member_nickname}
							<input type="hidden" name="member_nickname" value="${memberInfo.member_nickname}">
							<input type="hidden" name="admin_nickname" value="${adminInfo.admin_nickname}">
							<input type="hidden" name="member_grade" value="${memberInfo.member_grade}"></td>
						</c:otherwise> --%>
					</c:choose>
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
						<textarea rows="10" cols="60" id="cp_content" name="cp_content"></textarea>
					</td>
				</tr>
				<tfoot>
					<tr align="center">
						<td colspan="2">
							<input type="button" id="inputId" value="입력" onclick="camping_gear_board(this.form)"/> &nbsp;&nbsp;
							<input type="reset" id="cancelId" value="취소"/>
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
	
	/* function sendImage(file, editor) {
		let frm = new FormData();
		frm.append("s_file", file);
		$.ajax({
			url : "saveImg.do",
			data : frm,
			type : "post",
			contentType : false,
			processData : false,
			cache: false,
			dataType : "json"
		}).done(function(data) {
			const path = data.path;
			const fname = data.fname;
			$("#b_content").summernote("editor.insertImage", path+"/"+fname);
		});
	} */
</script>	
</body>
</html>