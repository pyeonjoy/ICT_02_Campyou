const cancel = document.querySelector(".cancel");
const lists = document.querySelectorAll(".chat_list");
const icons = document.querySelectorAll(".hamburgerIcon");

let stompClient, activeHideContainer;

function goToRoom(room, event) {
	if (event.target.closest('.hamburgerIcon')) return;
    window.location.href = `selectOneRoom.do?msg_room=${room}`;
}
function splitContent() {
    const elements = document.querySelectorAll('.room_name');
    elements.forEach(element => {
        const originalString = element.textContent;
        const index = originalString.indexOf('2');
        if (index !== -1) {
            const part1 = '⛺'+originalString.substring(0, index);
            const part2 = originalString.substring(index);

            element.textContent = '';
          
            const p1 = document.createElement('p');
            p1.textContent = part1;
            p1.className = 'part1';
            element.appendChild(p1);

            const p2 = document.createElement('p');
            p2.textContent = part2;
            p2.className = 'part2';
            element.appendChild(p2);
        } 
    });
}

function showDelete(event) {
    event.preventDefault(); 
    const clicked = event.target.closest(".chat_list");
    const hideContainer = clicked.querySelector('.hide-container');

    if (activeHideContainer) {
        activeHideContainer.classList.remove('active');
    }

    hideContainer.classList.add('active');
    activeHideContainer = hideContainer;
}

function callHide(event) {
	event.preventDefault(); 
	event.stopPropagation();
	const clicked = event.target.closest(".chat_list");
    const hideContainer = clicked.querySelector('.hide-container');

    hideContainer.classList.remove('active');
    }

function handleReport(event, msgRoom, oppositeIdx) {
	    event.preventDefault();
	    event.stopPropagation();
	    const reportUrl =`report_write.do?member_idx=${oppositeIdx}`;
	    window.open(reportUrl, '_blank', 'width=' + window.innerWidth + ', height=' + window.innerHeight);
	    window.addEventListener('beforeunload', reportAndLeave);
}

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



splitContent();
connect();


lists.forEach(list => list.addEventListener("click", function() {
	const msgIdx = this.dataset.msgIdx; 
	const newIndicator = this.querySelector('.new');
	if (newIndicator) {
		newIndicator.remove(); 
		updateMessageReadStatus(msgIdx); 
	}
}));

icons.forEach(icon => icon.addEventListener("click", showDelete));

cancel.addEventListener("click", function() {
  window.close();
});
