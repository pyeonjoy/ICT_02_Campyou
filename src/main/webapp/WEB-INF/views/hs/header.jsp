<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<link href="resources/css/header.css" rel="stylesheet" />
<link rel="stylesheet" href="${path}/resources/public/css/bm/chatroom.css" />
<script defer src="${path}/resources/public/js/bm/header_chat.js"></script>
</head>
<body>
	<div class="header" id="header">
		<div class="header_wrap">
			<div class="header_left">
				<a href="/"> <img class="logo-03" src="resources/images/campyou.png" alt="CampYou">
				</a>
				<ul>
					<li><a href="camplist.do">캠핑장 검색</a></li>
					<li><a href="camp_map_list.do">지도로 검색</a></li>
					<li><a href="together_list.do">동행 구하기</a></li>
					<li><a href="community_board.do">자유게시판</a></li>
					<li><a href="camping_gear_board.do">캠핑제품추천게시판</a></li>
				</ul>
			</div>
			<div class="header_right">
				<ul>
					<c:choose>
						<c:when test="${empty memberInfo && empty admin && empty kakaoMemberInfo && empty naverMemberInfo}">
							<li><a href="login_form.do">로그인</a></li>
							<li><a href="sign_up_page_go.do">회원가입</a></li>
						</c:when>
						<c:otherwise>
							<li><a href="javascript:void(0)" onclick="openChat()" class="chatlink"><img class="icon chat"
									src="resources/img/icon_chat.png" alt="CampYou"></a></li>
							<li><a href="my_main.do"><img class="icon user"
									src="resources/img/icon_user.png" alt="mypage"></a></li>
							<c:if test="${admin != null}">
								<li><img class="icon admin" src="resources/img/icon_admin.png" alt="management"></li>
							</c:if>
								<c:choose>
									<c:when test="${kakaoMemberInfo != null }">
										<!-- 밑에 주석처리한것 지우지 말아 주세요  -->
										<!-- <a href="https://kauth.kakao.com/oauth/logout?client_id=4a601447a1662d2919cfc432b342bc38&logout_redirect_uri=http://localhost:8090/kakaologout.do">로그아웃</a> -->
										<a href="kakaologout.do">로그아웃</a>
									</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${naverMemberInfo != null }">
											<a href="naverlogout2.do">로그아웃</a>
										</c:when>
										<c:otherwise>
											<li><a href="logout_form.do">로그아웃</a></li>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>