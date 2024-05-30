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
					<img src="${path}/resources/images/left.png" alt="back-button"
						class="left-arrow" onclick="redirectToChatList()">				
				<c:choose>
					<c:when test="${my_idx eq opener.member_idx}">
						<span class="chatroom profile_show" data-memberidx="${my_idx}"> ${joiner.member_nickname}</span>
					</c:when>
					<c:otherwise>
						<span class="chatroom profile_show" data-memberidx="${opener.member_idx}"> ${opener.member_nickname}</span>
					</c:otherwise>
				</c:choose>
					<img src="${path}/resources/img/hamburger-menu.png" alt="icon-to-move-to-page-to-delete-chat" class="hamburgerIcon" id="ham">			
			</div>
			<div class="message-container">
				<c:forEach var="chat" items="${chatList}">
					<c:if test="${chat.send_idx != my_idx }">
						<div class="li-msg li-msg--1">
							<c:choose>
								<c:when test="${my_idx eq opener.member_idx}">
									<img src="${path}/resources/images/${joiner.member_img}"
										alt="user_img" class="img_for_user1" />
									<span class="user-message user--1-message">${chat.msg_content}</span>
								</c:when>
								<c:otherwise>
									<img src="${path}/resources/images/${opener.member_img}"
										alt="user_img" class="img_for_user1" />
									<span class="user-message user--1-message">${chat.msg_content}</span>
								</c:otherwise>
							</c:choose>
						</div>
					</c:if>					
					<c:if test="${chat.send_idx == my_idx}">
						<div class="li-msg li-msg--2">
							<span class="user-message user--2-message">${chat.msg_content}</span>
						</div>
					</c:if>
					<input type="hidden" id="room_name" value="${chat.room_name}" />
				</c:forEach>
			</div>

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