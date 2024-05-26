<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<link href="/resources/css/menu_aside.css" rel="stylesheet" />
</head>
<body>
	<div class="mypage_menu_header">
		<%@include file="admin_header.jsp"%>
	</div>
	<div class="admin_menu" id="admin_menu">
		<div class="mypage_menu_wrap">
			<div class="side site_menu">
				<h4>사이트 관리</h4>
				<ul>
					<li><a href="popup.do">팝업창</a></li>
					<li><a href="admin_page.do">관리자</a></li>
				</ul>
			</div>
			<div class="side board_menu">
			<h4>커뮤니티 관리</h4>
			<ul>
				<li><a href="admin_community_board.do">자유게시판</a></li>
				<li><a href="admin_camping_gear_board.do">추천게시판</a></li>
				<li><a href="admin_board_w.do">동행게시판</a></li>
			</ul>
			</div>
			<div class="side user_menu">
				<h4>유저 관리</h4>
				<ul>
					<li><a href="admin_member_list.do">회원 관리</a></li>
					<li><a href="admin_inquiry.do">문의 내역</a></li>
					<li><a href="report_list.do">신고 내역</a></li>
					<li><a href="admin_faq.do">FAQ 관리</a></li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>