<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <title>WebSocket Chat</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</head>
<body>
 <div id="chat"></div>
    <input type="text" id="messageInput" placeholder="Type a message...">
    <button onclick="sendMessage()">Send</button>

    <script>
        var socket = new SockJS('/ws');

        var stompClient = Stomp.over(socket);

        stompClient.connect({}, function (frame) {
            stompClient.subscribe('/topic/public', function (response) {
                showMessage(JSON.parse(response.body).content);
            });
        });

        function sendMessage() {
            var messageInput = document.getElementById("messageInput");
            stompClient.send("/app/chat.sendMessage", {}, JSON.stringify({ 'content': messageInput.value }));
            messageInput.value = '';
        }

        function showMessage(message) {
            var chatDiv = document.getElementById("chat");
            var p = document.createElement("p");
            p.appendChild(document.createTextNode(message));
            chatDiv.appendChild(p);
        }
    </script>
</body>
</html>
