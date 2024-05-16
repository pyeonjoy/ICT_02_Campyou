<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="/resources/css/menu_aside.css" rel="stylesheet" />
</head>
<body>
	<div class="mypage_menu_header">
		<%@include file="header.jsp"%>
	</div>
	<div class="mypage_menu" id="mypage_menu">
		<div class="mypage_menu_wrap">
			<h4>마이페이지</h4>
			<ul>
			 <li><a href="my_info.do">회원 정보</a></li>
    <li><a href="my_fav_list.do">관심 캠핑장</a></li>
    <li><a href="my_inquiry_list.do">1:1 문의하기</a></li>
    <li><a href="#">동행 내역</a></li>
    <li><a href="my_faq.do">FAQ</a></li>
			</ul>
		</div>
	</div>
</body>
</html>