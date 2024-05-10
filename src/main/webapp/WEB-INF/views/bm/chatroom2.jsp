<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebSocket Chat</title>
<link rel="stylesheet" href="${path}/resources/public/css/bm/chatroom.css" />
<script defer src="${path}/resources/public/js/bm/chatroom.js"></script>
<script defer src="${path}/resources/public/js/bm/header_chat.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.2/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</head>
<body>
 <input type="hidden" id="send_nick" name="send_nick" value="${sender.member_nickname}" />
 <input type="hidden" id="reci_nick" name="reci_nick" value="${receiver.member_nickname}" />
 <input type="hidden" id="send_img" value="${sender.member_img}" />
 <input type="hidden" id="reci_img" value="${receiver.member_img}"/>
 <input  type="hidden" id="msg_room" value="${msg_room}" />
	
	<div id="chat-page" class="chatPage">
      <div class="chat-container">
        <div class="form-header">
          <button class="back" onclick="openChat()"><img src="${path}/resources/img/right.png" alt="back-button" class="left-arrow"></button>
     		 <span class="chatroom">채팅방</span>
        </div>
        <div class="message-container"> 
        <c:forEach var="chat" items="${chatList}">
        <c:if test="${sender.member_idx != member_idx }">
			<div class="li-msg li-msg--1">
            <img
              src="${path}/resources/img/cat.png"
              alt="user_img"
              class="img_for_user1"
            />
            <%--src="${path}/resources/uploadUser_img/${sender.member_img}" --%>
            <span class="user-message user--1-message">${chat.msg_content}</span>
          </div>
          </c:if> 
 		<c:if test="${sender.member_idx == member_idx}"> 
          <div class="li-msg li-msg--2">
            <span class="user-message user--2-message">${chat.msg_content}</span>
          </div>
		</c:if>  
        </c:forEach>             
        </div>

        <form id="messageForm" name="messageForm">
          <div class="form-group">
            <div class="input-group clearfix">
              <input
                type="text"
                id="msg_content"
                name="msg_content"
                autocomplete="off"
                class="form-control"
              />
              <button id="send" class="btn-send" onclick="showMessage(this.form)">
                <img
                  src="${path}/resources/img/send.png"
                  alt="send-img"
                  class="img-send"
                />
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
</body>
</html>