<!-- index.html -->
<!DOCTYPE html>
<html>
<head>
    <title>WebSocket Chat</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.2/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        var stompClient = null;

        function connect() {
            var socket = new SockJS('chat-ws2.do');
            stompClient = Stomp.over(socket);
            stompClient.connect({}, function(frame) {
                console.log('Connected: ' + frame);
                stompClient.subscribe('/topic/public', function(messageOutput) {
                    showMessageOutput(JSON.parse(messageOutput.body));
                });
            });
        }

        function disconnect() {
            if (stompClient !== null) {
                stompClient.disconnect();
            }
            console.log("Disconnected");
        }

        function sendMessage() {
        	
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
        	
        	
     //       var message = $('#message').val();
       //     var sender = $('#sender').val();
         //   stompClient.send("/app/chat.sendMessage", {}, JSON.stringify({
           //     'content': message,
             //   'sender': sender
            //}));
            //$('#message').val('');
        }

        function showMessageOutput(messageOutput) {
        	const msgContainer = document.querySelector(".message-container");

        	  const myMsg = `
        	  <div class="li-msg li-msg--2">
        	  <span class="user-message user--2-message">${content}</span>
        	  </div>
        	  `;

        	  msgContainer.insertAdjacentHTML("beforeend", myMsg);
   //         var message = messageOutput.content;
    //        var sender = messageOutput.sender;
    //        $('#chat').append('<div><strong>' + sender + '</strong>: ' + message + '</div>');
        }

        $(function () {
            connect();
            $('form').on('submit', function(e) {
                e.preventDefault();
            });
            $( "#disconnect" ).click(function() { disconnect(); });
            $( "#send" ).click(function() { sendMessage(); });
        });
    </script>
</head>
<body>
<div id="chat"></div>
<form>
    <input type="text" id="sender" placeholder="Enter your name" />
    <input type="text" id="message" placeholder="Type a message..." />
    <button id="send">Send</button>
    <button id="disconnect">Disconnect</button>
</form>
</body>
</html>
