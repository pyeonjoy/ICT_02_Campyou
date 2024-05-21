<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../hs/admin_menu.jsp" %>
<link href="resources/css/reset.css" rel="stylesheet" />
	<meta charset="UTF-8">
<style type="text/css">
body {
	background-color: #F6FFF1;
}
.faq_wrapper{
	padding: 200px 100px 300px 100px;
	margin-bottom: 1000px;
}
#faq_list {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    width: 100%;
}
#faq_list table{
	width:1500px;
	margin:0 auto;
	margin-top:20px;
	border-collapse: collapse;
	background-color: #F6FFF1;
	text-align: center;
}
.button_container{
	display: flex;
	justify-content: space-evenly;
}
.write_button {
    text-align: right;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	user_go();
});

function promise_go(){
	console.log("눌림?동행");
	 $.ajax({
	        url: "promise_faqload.do",
	        method: "get",
	        dataType: "json",
	        success: function(data) {
	            let list = '<div class="table-container"><table>';
	            list += "<thead><tr><th>번호</th><th>제목</th><th>내용</th><th>상태</th></tr></thead><tbody>";
	            $.each(data, function(index, item) {
	                list += '<tr>';
	                list += '<td>'+item.faq_idx+'</td>';
	                list += '<td>'+item.faq_title+'</td>';
	                list += '<td>'+item.faq_content+'</td>';
	                list += '<td>'+item.faq_status+'</td>';
	                list += '</tr>';
	                list += '<tr>';
		            list += '<tr><td colspan=4 class="write_button"><button onclick="promise_faq_write()">동행FAQ작성</button></td></tr>'
	                list += '</tr>';
	            });
	            list += '</tbody></table></div>';
	            $("#faq_list").html(list);
	        },
	        error: function() {
	            alert("오류가 발생했습니다.");
	        }
	    });
}

function user_go(){
	console.log("유저사용 눌림?");
	 $.ajax({
	        url: "use_faqload.do",
	        method: "get",
	        dataType: "json",
	        success: function(data) {
	            let list = '<div class="table-container"><table>';
	            list += "<thead><tr><th>번호</th><th>제목</th><th>내용</th><th>상태</th></tr></thead><tbody>";
	            $.each(data, function(index, item) {
	                list += '<tr>';
	                list += '<td>'+item.faq_idx+'</td>';
	                list += '<td>'+item.faq_title+'</td>';
	                list += '<td>'+item.faq_content+'</td>';
	                list += '<td>'+item.faq_status+'</td>';
	                list += '</tr>';
	            });
	            list += '<tr><td colspan=4 class="write_button"><button onclick="user_faq_write()">유저FAQ작성</button></td></tr>'
	            list += '</tbody></table></div>';
	            $("#faq_list").html(list);
	        },
	        error: function() {
	            alert("오류가 발생했습니다.");
	        }
	    });
}
function user_faq_write(){
	console.log("버튼정상작동?");
}
function promise_faq_write(){
	console.log("동행정상작동?");	
}
</script>
<title>관리자 - FAQ 관리</title>
</head>
<body>
<div class ="faq_wrapper">
<h3 style="text-align: center;">FAQ</h3>
<div class="button_container">
	<button onclick='user_go()'>사용자 이용 문의</button>
	<button onclick='promise_go()'>동행</button>
</div>
<div id="faq_list">
<!-- 리스트 -->
</div>
</div>
</body>
<jsp:include page="../hs/footer.jsp" />
</html>
