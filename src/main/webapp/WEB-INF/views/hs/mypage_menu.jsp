<!-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="../../../resources/css/reset.css" rel="stylesheet" />
<style type="text/css">
.mypage_menu_wrap {
	top: 180px;
	position: absolute;
	margin: 0 20px;
}

.mypage_menu_wrap h4 {
	padding: 10px;
}

.mypage_menu_wrap li {
	padding: 10px;
	font-weight: 600;
}
</style>
</head>
<body>
	<div class="mypage_menu_header">
		<%@include file="header.jsp"%>
	</div>
	<div class="mypage_menu" id="mypage_menu">
		<div class="mypage_menu_wrap">
			<h4>마이페이지</h4>
			<ul>
				<li><a href="#">회원 정보</a></li>
				<li><a href="#">관심 캠핑장</a></li>
				<li><a href="#">1:1 문의하기</a></li>
				<li><a href="#">동행 내역</a></li>
				<li><a href="#">FAQ</a></li>
			</ul>
		</div>
	</div>
</body>
</html>