<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<link href="/resources/css/menu_aside.css" rel="stylesheet" />
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<div class="mypage_menu_header">
		<%@include file="header.jsp"%>
	</div>
	<div class="mypage_menu" id="mypage_menu">
		<div class="mypage_menu_wrap">
			<h4><a href="my_main.do">마이페이지</a></h4>
			<ul>

			 <li><a id="myInfoLink" href="my_info.do">회원 정보</a></li>
    <li><a href="my_fav_list.do">관심 캠핑장</a></li>
    <li><a id="inquiryLink" href="my_inquiry_list.do">1:1 문의하기</a></li>
    <li><a href="together_history.do">동행 내역</a></li>
    <li><a href="together_partner.do">동행 파트너</a></li>

    <li><a href="my_faq.do">FAQ</a></li>
			</ul>
		</div>
	</div>
</body>
</html>