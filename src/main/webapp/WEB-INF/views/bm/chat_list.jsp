<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chat List</title>
<link rel="shortcut icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
    <link rel="icon" href="${path}/resources/images/favicon.ico" type="image/x-icon">
<link rel="stylesheet" href="${path}/resources/public/css/bm/chatroom.css" />
<script defer src="${path}/resources/public/js/bm/chat-list.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.2/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 
</head>
<body>
   <div class="chat-container chatLists">
		<div class="form-header">
			<button class="cancel"></button>
			<span class="chatroom">채팅방</span>
		</div>
		<div class="chat_lists">
			<c:choose>
				<c:when test="${empty list}">
					<div class="chat_list">
						<p class="nolist">채팅 목록이 없습니다.</p>
					</div>
				</c:when>
				<c:otherwise>
					<c:forEach var="chat" items="${list}">
					<a href="selectOneRoom.do?msg_room=${chat.msg_room}">
						<div class="chat_list" >
							<div class="chat-imgs">
								<img src="${path}/resources/img/cat.png" alt="user_img"
									class="user_img" />
										<c:if test="${chat.send_idx != member_idx && chat.msg_read == 0}">
										    <div class="new">N</div>
										</c:if>
							</div>
							<div class="chat_detail">
								<p class="nick_name">${chat.room_name}</p>
								<p class="chat_content">${chat.msg_content}</p>
							</div>
						</div>
						</a>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
   
</body>
</html>