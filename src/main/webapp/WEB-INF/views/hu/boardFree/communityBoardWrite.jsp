<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<!-- summer note -->
<link rel="stylesheet" href="resources/css/summernote-lite.css">
<link rel="stylesheet" href="${path}/resources/public/css/hu/communityBoardWrite.css">
 <style type="text/css">
	/* summernote toolbar 수정 */
	.note-btn-group{width: auto;}
	.note-toolbar{width: auto;}
</style> 
<script type="text/javascript">
	function board_write_ok(f) {
		for (var i = 0; i < f.elements.length; i++) {
			if (f.elements[i].value == "") {
				if (i == 3) continue;
				if(i == 6) break;
				alert(f.elements[i].name + "를 입력하세요");
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
		<h2>자유게시판 글쓰기</h2>
		<hr>
		<p><a href="community_board.do">자유게시판 돌아가기</a></p>
		<form action="comm_board_write_ok.do" method="post" enctype="multipart/form-data">
			<table>
				<tr align="center">
					<td bgcolor="#003300" style="color: white;">유형</td>
					<c:choose>
						<c:when test="${memberInfo.member_id == 'admin'}">
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
					<td align="left"><input type="text" name="b_subject"></td>
				</tr>
				<tr align="center">
					<td bgcolor="#003300" style="color: white;">별명</td>
					<td align="left">${memberInfo.member_nickname}
					<input type="hidden" name="member_nickname" value="${memberInfo.member_nickname}">
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
						<textarea rows="10" cols="60" id="b_content" name="b_content"></textarea>
					</td>
				</tr>
				<tfoot>
					<tr align="center">
						<td colspan="2">
							<input type="button" id="inputId" value="입력" onclick="board_write_ok(this.form)"/> &nbsp;&nbsp;
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
		$("#b_content").summernote({
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