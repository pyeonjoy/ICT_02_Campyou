"use strict";

// chat-rooms
const chatLists = document.querySelector(".chat_lists");
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
back.addEventListener("click", function () {
  chatPage.classList.add("hidden");
  chatLists.classList.remove("hidden");
});

cancel.addEventListener("click", function () {
  chatLists.classList.add("hidden");
});

// connecting to chat server
let stompClient = null;
let userNick;

function onMessageRead() {
  const newBadge = document.querySelector(".new");
  newBadge.classList.add("hidden");
}

function connect(e) {
  e.preventDefault();
  chatPage.classList.remove("hidden");
  chatLists.classList.add("hidden");

  const socket = new SockJS("/chat-ws2.do");
  stompClient = Stomp.over(socket);

  stompClient.connect({}, onConnected, onError);
}

function onConnected() {
  stompClient.subscribe("/topic/public", onMessageReceived);

  connectingElement.classList.add("hidden");
  onMessageRead();
}

function onError(error) {
  connectingElement.textContent = "⛔️ 현재 서버 접속이 원활하지 않습니다.";
  connectingElement.style.color = "red";
  connectingElement.style.fontSize = "0.9rem";
}

selectRoomList.forEach((room) => room.addEventListener("click", connect));

function sendMessage(e) {
  // sender nickname  에따라 구분하기
  e.preventDefault();
    const messageContent = messageInput.value.trim();
    let chatMessage;
  if (messageContent && stompClient) {
    chatMessage = {
      sender: member_nickname,
      content: messageInput.value,
    };
    stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(chatMessage));
    messageInput.value = "";
  }
  displayMessage(chatMessage.content);
}

function displayMessage(content) {
  const msgContainer = document.querySelector(".message-container");

  const myMsg = `
  <div class="li-msg li-msg--2">
  <span class="user-message user--2-message">${content}</span>
  </div>
  `;

  msgContainer.insertAdjacentHTML("beforeend", myMsg);
}

function onMessageReceived(payload) {
  const newBadge = document.querySelector(".new");
  newBadge.classList.remove("hidden");

  const msgContainer = document.querySelector(".message-container");
  const message = JSON.parse(payload.body);
  const urMsg = ` <div class="li-msg li-msg--1">
  <img
    src="http://placehold.it/30x30"
    alt="user_img"
    class="img_for_user1"
  />
  <span class="user-message user--1-message">${message.content}</span>
</div>`;

  msgContainer.insertAdjacentHTML("beforeend", urMsg);

  const chatList = document.querySelector(
    `.chat_list[data-sender="${message.sender}"]`
  );
  if (chatList) {
    // 기존 채팅방이 있으면 새로운 메시지만 업데이트
    const chatContent = chatList.querySelector(".chat_content");
    chatContent.textContent = message.content;
  } else {
    // 기존 채팅방이 없으면 새로운 채팅방 리스트 추가
    const chatLists = document.querySelector(".chat_lists");
    const newChatList = `
      <div class="chat_list" data-list="${message.room_no}">
        <div class="chat-imgs">
          <img src="http://placehold.it/50x50" alt="user_img" class="user_img" />
          <div class="new hidden">N</div>
        </div>
        <div class="chat_detail">
          <p class="nick_name">${message.sender}</p>
          <p class="chat_content">${message.content}</p>
        </div>
      </div>`;
    chatLists.insertAdjacentHTML("afterbegin", newChatList);
  }
  //   const chatLists = document.querySelector(".chat_lists");
  //   const chatList = ` <div class="chat_list">
  //   <div class="chat-imgs">
  //     <img
  //       src="http://placehold.it/50x50"
  //       alt="user_img"
  //       class="user_img"
  //     />
  //     <div class="new hidden">N</div>
  //   </div>
  //   <div class="chat_detail">
  //     <p class="nick_name">${message.sender}</p>
  //     <p class="chat_content">${message.content}</p>
  //   </div>
  // </div>
  // </div>`;

  //   chatLists.insertAdjacentHTML("afterbegin", chatList);
}

messageForm.addEventListener("submit", sendMessage);



function getUserInfo() {
    const xhr = new XMLHttpRequest();
    xhr.open('GET', 'profile.do', true); 
    
    xhr.onload = function () {
        if (xhr.status >= 200 && xhr.status < 300) {

            const user = JSON.parse(xhr.responseText);

        } else {
            console.error('Request failed with status', xhr.status);
        }
    };   
    // 요청 전송
    xhr.send();
}
window.addEventListener('load', getUserInfo)
btnEnter.addEventListener("click", connect)