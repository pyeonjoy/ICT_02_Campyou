<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chatroom</title>
<link rel="stylesheet" href="${path}/resources/public/css/bm/chatroom.css">
</head>
<body>
  <button class="btn-enterChat" onclick="connect(event)">
      chatroom 채팅방 처음입성
    </button>
    <button class="btn-chatList" onclick="handleChatList()">
      기존채팅방리스트보기
    </button>
    <div class="chat-container chatLists hidden">
      <div class="form-header">
        <button class="cancel"></button>
        <span class="chatroom">채팅방</span>
      </div>

      <!-- c:forEach  -->
      <div class="chat_lists">
        <div class="chat_list">
          <div class="chat-imgs">
            <img
              src="http://placehold.it/50x50"
              alt="user_img"
              class="user_img"
            />
            <div class="new hidden">N</div>
          </div>
          <div class="chat_detail">
            <p class="nick_name">member_nickname</p>
            <p class="chat_content">content </p>
          </div>
        </div>
      </div>
    </div>

    <div id="chat-page" class="chatPage hidden">
      <div class="chat-container">
        <div class="form-header">
          <button class="back"><img src="${path}/resources/img/right.png" alt="back-button" class="left-arrow"></button>
      <span class="chatroom">채팅방</span>
        </div>
        <div class="connecting">Connecting...</div>
        <div class="message-container">
          <div class="li-msg li-msg--1">
            <img
              src="http://placehold.it/30x30"
              alt="user_img"
              class="img_for_user1"
            />
            <span class="user-message user--1-message">message1</span>
          </div>

          <div class="li-msg li-msg--2">
            <span class="user-message user--2-message">message12</span>
          </div>
        </div>

        <form id="messageForm" name="messageForm">
          <div class="form-group">
            <div class="input-group clearfix">
              <input
                type="text"
                id="message"
                autocomplete="off"
                class="form-control"
              />
              <button type="submit" class="btn-send">
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

    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <script src="${path}/resources/public/js/bm/chatroom.js"></script>
</body>
</html>