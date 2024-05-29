'use strict';

const path = "${path}";

const chatPage = document.querySelector(".chatPage");
const messageForm = document.querySelector("#messageForm");
const msgContainer = document.querySelector(".message-container");
//btn
const back = document.querySelector(".back");

let stompClient = null;

//members info
const joiner_nick = document.getElementById("joiner_nick").value;
const opener_nick = document.getElementById("opener_nick").value;
const opposite_idx = document.getElementById("opposite_idx").value;

const msg_room = document.getElementById("msg_room").value;
const room_name = document.getElementById("room_name").value;
const my_idx = document.getElementById("my_idx").value;
const joiner_img = document.getElementById("joiner_img").value;
const opener_img = document.getElementById("opener_img").value;
const queueName = '/user/queue/' + msg_room;

const send_nick = my_idx === opposite_idx ? opener_nick : joiner_nick;
const reci_nick = my_idx === opposite_idx ? joiner_nick : opener_nick;
const reci_img = my_idx === opposite_idx ? joiner_img : opener_img;
//Room info


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
    'send_idx': my_idx,
    'send_nick': send_nick,
    'send_date': formattedDate,
    'reci_nick': reci_nick,
    'msg_room': msg_room,
    'room_name': room_name
  };

  stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(chatMessage));

  form.elements["msg_content"].value = '';
  return false;
}

function showMessageOutput(chvo) {
  const isOwnMessage = chvo.send_idx === my_idx;
  const messageClass = isOwnMessage ? "user--2-message" : "user--1-message";
const imageHTML = !isOwnMessage ? `<img src="resources/images/${reci_img}" alt="user_img" class="img_for_user1" />` : "";
  
  const messageHTML = `
    <div class="li-msg ${isOwnMessage ? 'li-msg--2' : 'li-msg--1'}">
      ${imageHTML}
      <span class="user-message ${messageClass}">${chvo.msg_content}</span>
    </div>
  `;
  msgContainer.insertAdjacentHTML("afterbegin", messageHTML);
  msgContainer.scrollTop = msgContainer.scrollHeight;
}

function redirectToChatList(){
 window.location.href = "chat-list.do";
}

back.addEventListener("click", function() {
	  window.location.href = "chat-list.do";
	});