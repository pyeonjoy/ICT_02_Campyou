'use strict';

const path = "${path}";
const chatLists = document.querySelector(".chatLists");
const selectRoomList = document.querySelectorAll(".chat_list");

// chat-page
const chatPage = document.querySelector(".chatPage");
const messageForm = document.querySelector("#messageForm");
const messageInput = document.querySelector("#message");
const connectingElement = document.querySelector(".connecting");
const btnEnter = document.querySelector(".btn-enterChat");
const msgContainer = document.querySelector(".message-container");
//btn
const back = document.querySelector(".back");

let stompClient = null;

//Receiver info
const reci_nick = document.getElementById("reci_nick").value;
const send_nick = document.getElementById("send_nick").value;
const reci_img = document.getElementById("reci_img").value;
//Room info
const msg_room = document.getElementById("msg_room").value;
const queueName = '/queue/' + msg_room;

connect();
messageForm.addEventListener('submit', function (e) {
  e.preventDefault();
  sendMessage(this, e);
});

function connect() {
  const socket = new SockJS('chat-ws2.do');
  stompClient = Stomp.over(socket);

  stompClient.connect({}, function () {
    stompClient.subscribe(queueName, function (messageOutput) {
      const chvo = JSON.parse(messageOutput.body);
      showMessageOutput(chvo);
    });
  });
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
  const currentDate = new Date();
  const formattedDate = currentDate.toISOString();
  const chatMessage = {
    'msg_content': message,
    'send_nick': send_nick,
    'send_date': formattedDate,
    'reci_nick': reci_nick,
    'msg_room': msg_room,
  };
  stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(chatMessage));

  form.elements["msg_content"].value = '';
  return false;
}

function showMessageOutput(chvo) {
  const isOwnMessage = chvo.send_nick === send_nick; 
  const messageClass = isOwnMessage ? "user--2-message" : "user--1-message";
  const messageHTML = `
    <div class="li-msg ${isOwnMessage ? 'li-msg--2' : 'li-msg--1'}">
      <span class="user-message ${messageClass}">${chvo.msg_content}</span>
    </div>
  `;
  msgContainer.insertAdjacentHTML("beforeend", messageHTML);
}

function showMessage(form){
  const message = form.elements["msg_content"].value;
  console.log(message);
  const html = `<div class="li-msg li-msg--2">
    <span class="user-message user--2-message">${message}</span>
  </div>`;
  msgContainer.insertAdjacentHTML("beforeend", html);
}
