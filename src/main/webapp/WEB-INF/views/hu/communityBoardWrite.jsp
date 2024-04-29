<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 방 명 록 </title>
<!-- summer note -->
<link rel="stylesheet" href="resources/css/summernote-lite.css">
<style type="text/css">
	a { text-decoration: none;}
	table{width: 800px; border-collapse:collapse; text-align: center;}
	table,th,td{border: 1px solid black; padding: 3px}
	div{width: 800px; margin:auto; text-align: center;}
	
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
		<h2>방명록 : 작성화면</h2>
		<hr>
		<p>[<a href="community_board.do">목록으로 이동</a>]</p>
		<form action="comm_board_write_ok.do" method="post" enctype="multipart/form-data">
			<table>
				<tr align="center">
					<td bgcolor="#99ccff">유형</td>
					<td>
						<select name="b_type">
							<option value="유머">유머</option>
							<option value="썰">썰</option>
							<option value="불평">불평</option>
							<option value="경험담">정보</option>
							<option value="경험담">후기</option>
							<option value="경험담">경험담</option>
						</select>
						<!-- <td align="left"><input type="hidden" name="b_type"></td>  -->
					</td>
				</tr>
				<tr align="center">
					<td bgcolor="#99ccff">제목</td>
					<td align="left"><input type="text" name="b_title"></td>
				</tr>
				<tr align="center">
					<td bgcolor="#99ccff">별명</td>
					<td align="left">${memberInfo.member_nickname}
					<input type="hidden" name="member_nickname" value="${memberInfo.member_nickname}">
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
				<tr align="center">
					<td colspan="2">
						<textarea rows="10" cols="60" id="b_content" name="b_content"></textarea>
					</td>
				</tr>
				<tfoot>
					<tr align="center">
						<td colspan="2">
							<input type="button" value="입력" onclick="board_write_ok(this.form)"/> &nbsp;&nbsp;
							<input type="reset" value="취소"/>
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