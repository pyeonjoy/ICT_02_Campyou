'use strict'

const cancel = document.querySelector(".cancel");
const lists = document.querySelectorAll(".chat_list");

lists.forEach(list => {
    const msgRoom = list.dataset.msgRoom;
    if (localStorage.getItem(msgRoom) === 'read') {
      const newElement = list.querySelector('.new');
      if (newElement) {
        newElement.remove();
      }
    }
  });

lists.forEach(list => list.addEventListener('click', function() {
  const newElement = list.querySelector('.new');
  const msgRoom = list.dataset.msgRoom;

  if (newElement) {
    newElement.remove();
    localStorage.setItem(msgRoom, 'read');
  }
}));
cancel.addEventListener("click", function() {
  window.close();
});