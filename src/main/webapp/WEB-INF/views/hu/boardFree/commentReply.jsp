<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
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
<script type="text/javascript">
function comment_insert(f){
	f.action="comment_insert.do";
	f.submit();
}
function comment_delete(f) {
	f.action="comment_delete.do";
	f.submit();
}
function comment_update(f) {
    // 해당 댓글의 내용을 가져옴
    const content = f.querySelector('span:nth-of-type(2)').innerHTML;

    // 내용을 input 요소로 변경
    f.querySelector('span:nth-of-type(2)').innerHTML = '<input type="text" name="content" value="' + content + '">';

    // 수정 완료 버튼 생성
    const updateBtn = document.createElement('input');
    updateBtn.type = 'button';
    updateBtn.value = '수정완료';
    updateBtn.onclick = function() {
        // 수정된 내용을 서버로 전송
        f.action="comment_update.do";
        f.submit();
    };
    f.appendChild(updateBtn);
    
    // 댓글수정 버튼 제거
    const updateGoBtn = f.querySelector('#updateGo');
    updateGoBtn.parentNode.removeChild(updateGoBtn);
}
function comment_reply(f) {
	f.action="comment_reply.do";
	f.submit();
}
</script>
</head>
<body>
	<%-- 댓글 입력 --%>
	<div style="padding: 10px; width: 580px; margin: 0 auto">
		<form method="post">
			<fieldset>
				<p>별명 : <input style="padding: 5px" type="hidden" name="member_nickname" value="${memberInfo.member_nickname}">
						${memberInfo.member_nickname}
				</p>
				<p>내용 : <textarea rows="3" cols="40" name="content"></textarea>
				<input style="margin-left: 50px" type="button" value="댓글저장" onclick="comment_insert(this.form)"></p>
				<!-- 댓글 저장시 어떤 원글의 댓글인지 저장해야 한다. -->
				<input type="hidden" name ="b_idx" value="${cbvo.b_idx}" >
				<%-- <input type="hidden" value="${cPage}" name="cPage"> --%>
			</fieldset>
		</form>
	</div>
	
	<%-- 댓글 출력 --%>
	<div style="display: table; margin: 0 auto;">
		<c:forEach var="k" items="${comm_list}">
			<div style="border: 1px solid #cc00cc; width: 400px; margin: 20px; padding: 20px;" >
				<form method="post">
					<p>별명 : ${k.member_nickname}</p>
					<p>내용 : ${k.content}</p>
					<p>날짜 : ${k.write_date.substring(0,10)}</p>
					<!-- 실제은 로그인 성공 && 글쓴 사람만 삭제할 수 있어야 한다. -->
					<input type="button" value="댓글삭제" onclick="comment_delete(this.form)">
					<input type="button" value="댓글답글" onclick="comment_reply(this.form)">
					<input type="hidden" name = "c_idx" value="${k.c_idx}" >
					<input type="hidden" name = "b_idx" value="${k.b_idx}" >
				</form>
			</div>
		</c:forEach>
	</div>	
</body>
</html>