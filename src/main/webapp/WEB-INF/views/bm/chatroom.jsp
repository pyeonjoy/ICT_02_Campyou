<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebSocket Chat</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico"
	type="image/x-icon">
<link rel="icon" href="${path}/resources/images/favicon.ico"
	type="image/x-icon">
<link rel="stylesheet"
	href="${path}/resources/public/css/bm/chatroom.css" />
<script defer src="${path}/resources/public/js/bm/chatroom.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.2/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</head>
<body>
	<input type="hidden" id="joiner_nick" value="${joiner.member_nickname}" />
	<input type="hidden" id="opener_nick" value="${opener.member_nickname}" />
	<input type="hidden" id="joiner_img" value="${joiner.member_img}" />
	<input type="hidden" id="opener_img" value="${opener.member_img}" />
	<input type="hidden" id="msg_room" value="${msg_room}" />
	<input type="hidden" id="room_name" value="${room_name}" />
	<input type="hidden" id="my_idx" value="${my_idx}" />
	<input type="hidden" id="opposite_idx" value="${opener.member_idx}" />
	<div id="chat-page" class="chatPage">
		<div class="chat-container">
			<div class="hide-container">
				<button class="cancel" id="cancelHam" onclick="callHide(event)"></button>
				<a href="chatStatus.do?msg_room=${msg_room}" class="leave">채팅방나가기</a>
				<a href="#" class=leave id="reportLeave">신고하기</a>				
			</div>
			<div class="form-header">
					<img src="${path}/resources/img/right.png" alt="back-button"
						class="left-arrow" onclick="redirectToChatList()">
					<img src="${path}/resources/img/hamburger-menu.png" alt="icon-to-move-to-page-to-delete-chat" class="hamburgerIcon">			
				<c:choose>
					<c:when test="${my_idx eq opener.member_idx}">
						<span class="chatroom profile_show" data-memberidx="${joiner.member_idx}"> ${joiner.member_nickname}</span>
					</c:when>
					<c:otherwise>
						<span class="chatroom profile_show" data-memberidx="${opener.member_idx}"> ${opener.member_nickname}</span>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="message-container"></div>

			<form id="messageForm" name="messageForm">
				<div class="form-group">
					<div class="input-group clearfix">
						<input type="text" id="msg_content" name="msg_content"
							autocomplete="off" class="form-control" />
						<button id="send" class="btn-send">
							<img src="${path}/resources/img/send.png" alt="send-img"
								class="img-send" />
						</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<%@ include file="../hs/profile_small_info.jsp" %>
</body>
</html>