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
  // msgRoom을 기반으로 특정 리스트 항목을 선택
  const listElement = document.querySelector(`.chat_list[data-msg-room="${msgRoom}"]`);
  if (listElement) {
    // 기존의 new 요소가 있는지 확인
    let newIndicator = listElement.querySelector('.new');
    if (!newIndicator) {
      // new 요소가 없으면 새로 생성하여 추가
      newIndicator = document.createElement('div');
      newIndicator.classList.add('new');
      newIndicator.textContent = 'N';
      listElement.querySelector('.chat-imgs').appendChild(newIndicator);
    }
  }
}

// 예제 메시지 수신 처리
function onMessageReceived(msgRoom) {
  showNewMessageIndicator(msgRoom);
}

// 소켓 연결
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