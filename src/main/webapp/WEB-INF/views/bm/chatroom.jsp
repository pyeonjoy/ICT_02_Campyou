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
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.2/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
    const chatLists = document.querySelector(".chatLists");
    const selectRoomList = document.querySelectorAll(".chat_list");

    // chat-page
    const chatPage = document.querySelector(".chatPage");
    const messageForm = document.querySelector("#messageForm");
    const messageInput = document.querySelector("#message");
    const connectingElement = document.querySelector(".connecting");
    const btnEnter = document.querySelector(".btn-enterChat");

    //btn
    const back = document.querySelector(".back");
    const cancel = document.querySelector(".cancel");

    let stompClient = null;
    let userNick;

    function connect() {
        //chatPage.classList.remove("hidden");
        //chatLists.classList.add("hidden");
         const send_nick = document.getElementById("send_nick").value;
        const socket = new SockJS('chat-ws2.do');
        stompClient = Stomp.over(socket);
        
        const headers = {
        	    'send_nick': send_nick // 사용자의 식별 정보(member_idx)를 설정합니다.
        	};
        
        
        stompClient.connect({}, function(frame) {
            console.log('Connected: ' + frame);
            stompClient.subscribe('/topic/public', function(messageOutput) {
            	 const newRoom = JSON.parse(messageOutput.body);
            	 console.log(newRoom);
                showMessageOutput(newRoom)
            });
        })
    }

    function disconnect() {
        if (stompClient !== null) {
            stompClient.disconnect();
        }
        console.log("Disconnected");
    }

    function sendMessage(form, e) {
    	e.preventDefault();
    	const message = form.elements["msg_content"].value;
        stompClient.send("/app/chat.sendMessage", {}, JSON.stringify({
            'msg_content': message,
            'reci_nick': 'paul'
        }));
        console.log("msg sent")
        form.elements["msg_content"].value = '';
    }

    function showMessageOutput(newRoom) {
    	console.log(newRoom)
    	const msgContainer = document.querySelector(".message-container");

    	  const myMsg = `
    	  <div class="li-msg li-msg--2">
    	  <span class="user-message user--2-message">${newRoom.msg_content}</span>
    	  </div>
    	  `;

    	  msgContainer.insertAdjacentHTML("beforeend", myMsg);
    }
    	  

    document.addEventListener("DOMContentLoaded", function() {
        connect();
        messageForm.addEventListener('submit', function(e) {
            e.preventDefault();
        });
        document.getElementById("disconnect").addEventListener("click", disconnect);
        document.getElementById("send").addEventListener("click", sendMessage);
    });

    </script>
</head>
<body>
 <input
              type="hidden"
              id="send_nick"
              name="send_nick"
              value="${send_nick}"
            />
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

    <div id="chat-page" class="chatPage">
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
                id="msg_content"
                name="msg_content"
                autocomplete="off"
                class="form-control"
              />
              <button id="send" class="btn-send" onclick="sendMessage(this.form,event)">
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