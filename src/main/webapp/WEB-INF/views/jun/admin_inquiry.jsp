<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../hs/admin_menu.jsp" %>
<meta charset="UTF-8">
<style type="text/css">
body {
	background-color: #F6FFF1;
}
.inquiry_wrap {
	padding: 200px 100px 40px 100px;
}
#qna_list {
	display: flex;
	flex-wrap: wrap;
	justify-content: center;
	width: 100%;
	padding: 20px;
}

#qna_list table {
	width: 1500px;
	margin: 20px;
	border-collapse: collapse;
	background-color: #F6FFF1;
	text-align: center;
}

#qna_list table th {
	background-color: #032805;
	padding: .8rem 1rem;
	color: white;
}

#qna_list table td {
	padding: .8rem 1rem;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	load_inquiry();
});

function load_inquiry(page){
	$.ajax({
		url : "load_inquiry.do",
		method : "get",
		dataType : "json",
		data:{cPage: page},
		success: function(data){
			let list = '<div class="table_inquiry"><table>';
			list += "<thead><tr><th>번호</th><th>닉네임</th><th>제목</th><th>내용</th><th>날짜</th><th>상태</th></tr></thead><tbody>";
			$.each(data.res, function(index, item){
				list += '<tr>';
				list += '<td>' + item.qna_idx + '</td>';
				list += '<td>' + item.member_nickname+ '</td>';
				list += '<td>' + item.qna_title + '</td>';
				let onlycontext = item.qna_content.replace(/<img[^>]*>/g, '');
				list += '<td>' + onlycontext + '</td>';
				list += '<td>' + item.qna_date + '</td>';
				if (item.qna_status === 0) {
					list += '<td>처리중</td>';
				} else if (item.qna_status === 1) {
					list += '<td>처리완료</td>';
				} else {
					list += '<td>알 수 없음</td>';
				}
				list += '</tr>';
			});
			list += '</tbody></table></div>';
			$("#qna_list").html(list);
		},
		error: function(){
			alert("불러오는데 오류가 발생하셨습니다.")
		}
	});
}

</script>
<title>관리자 - 1:1 문의</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
</head>
<body>
	<div class="inquiry_wrap">
		<h3 style="text-align: center;">문의 내역</h3>
		<div id="qna_list">
			<!-- 리스트 -->
		</div>
	</div>
</body>
</html>