'use strict'

const chatIcon = document.querySelector(".chat");

const openChat = function(){
  const popup = window.open("chat-list.do", "new", 
    "toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=400, height=670, right=0, top=0, location=no, titlebar=no");
};

chatIcon.addEventListener('click', openChat)
