<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link href="/resources/css/header.css" rel="stylesheet" />
</head>
<body>
	<div class="header" id="header">
		<div class="header_wrap">
			<div class="header_left">
				<a href="/"> <img class="logo-03" src="/resources/img/logo-03.png" alt="CampYou">
				</a>
				<ul>
					<li><a href="#">캠핑장 검색</a></li>
					<li><a href="#">지도로 검색</a></li>
					<li><a href="#">커뮤니티</a></li>
					<li><a href="#">동행 구하기</a></li>
				</ul>
			</div>
			<div class="header_right">
				<ul>
					<c:choose>
						<c:when test="${empty memberInfo}">
							<li><a href="login_form.do">로그인</a></li>
							<li><a href="sign_up_page_go.do">회원가입</a></li>

						</c:when>
						<c:otherwise>
							<li><a href="#"><img class="icon chat"
									src="/resources/img/icon_chat.png" alt="CampYou"></a></li>
							<li><a href="#"><img class="icon user"
									src="/resources/img/icon_user.png" alt="mypage"></a></li>
							<c:if test="${admin == 'ok'}">
								<li><a href="#"><img class="icon admin" src="/resources/img/icon_admin.png" alt="management"></a></li>
							</c:if>
							<li><a href="logout_form.do">로그아웃</a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>