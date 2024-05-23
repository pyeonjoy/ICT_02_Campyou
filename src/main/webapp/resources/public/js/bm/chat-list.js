const cancel = document.querySelector(".cancel");
const lists = document.querySelectorAll(".chat_list");

let stompClient = null;

function connect() {
  const socket = new SockJS('chat-ws2.do');
  stompClient = Stomp.over(socket);

  stompClient.connect({}, function () {
    stompClient.subscribe('/user/queue/new-message', function (messageOutput) {
      const chvo = JSON.parse(messageOutput.body);
      onMessageReceived(chvo.msg_room);
    });
  });
}

function showNewMessageIndicator(msgRoom) {
  const listElement = document.querySelector(`.chat_list[data-msg-room="${msgRoom}"]`);
  if (listElement) {
    let newIndicator = listElement.querySelector('.new');
    if (!newIndicator) {
      newIndicator = document.createElement('div');
      newIndicator.classList.add('new');
      newIndicator.textContent = 'N';
      listElement.querySelector('.chat-imgs').appendChild(newIndicator);
    }
  }
}

function onMessageReceived(msgRoom) {
  showNewMessageIndicator(msgRoom);
}

connect();

cancel.addEventListener("click", function() {
  window.close();
});

function updateMessageReadStatus(msgIdx) {
	  fetch(`updateReadStatus.do?msg_idx=${msgIdx}`, {
	    method: 'POST',
	    headers: {
	      'Content-Type': 'application/json'
	    }
	  }).then(response => {
	    if (!response.ok) {
	      throw new Error('Network response was not ok');
	    }
	    return response.json();
	  }).then(data => {
	    console.log('Message read status updated:', data);
	  }).catch(error => {
	    console.error('Error updating message read status:', error);
	  });
	}

lists.forEach(list => list.addEventListener("click", function() {
	  const msgIdx = this.dataset.msgIdx; 
	  const newIndicator = this.querySelector('.new');
	  if (newIndicator) {
	    newIndicator.remove(); 
	    updateMessageReadStatus(msgIdx); 
	  }
	}));