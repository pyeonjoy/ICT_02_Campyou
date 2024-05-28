<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${path}/resources/public/js/hs/profile_small_info.js"></script>
<link rel="stylesheet" href="${path}/resources/public/css/hs/profile_small_info.css">
</head>
<body>
	<div class="profile_small_info_container">
		<div class="profile_small_info_wrap">
			<div class="profile_img">
				<img id="member_img" class="member_img" alt="프로필" src="/resources/images/user2.png">
			</div>
			<div class="top_info">
				<div>
					<strong id="member_nickname"></strong> <span><img id="member_grade" alt="" src=""> </span>
				</div>
				<div class="gray_font"><span id="member_age"></span> / <span id="member_gender"></span></div>
				<div>
<!-- 					<input id="chat_go" class="chat" onclick="openChat()" type="button" value="채팅">  -->
					<input id="report_go" type="button" value="신고">
				</div>
			</div>
			<hr>
			<div class="bottom_info">
				<div class="rating_wrap" >
					<div class="stars_wrap">
						<div class="stars">
							<div class="rating_empty">
								<c:forEach var="i" begin="1" end="5">
								    <div class="rating__label rating__label--full">
								        <span class="star-icon empty" id="star${i}" ></span>
								    </div>
								</c:forEach>
							</div>
						</div>
						<div class="stars">
							<div class="rating">
								<div class="rating_stars">
									<c:forEach var="i" begin="1" end="5">
									    <div class="rating__label rating__label--full">
									        <span class="star-icon filled" id="star${i}" ></span>
									    </div>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				<span id="member_rating"></span>
				</div>
			</div>
		</div>
	</div>
</body>
</html>