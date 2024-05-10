package com.ict.campyou.bm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;
import com.ict.campyou.bm.dao.ChatVO;
import com.ict.campyou.bm.service.MyService;


@Controller
public class StompController {

    @Autowired
    private SimpMessageSendingOperations messagingTemplate;
    @Autowired
    
    private MyService myService;

	@MessageMapping("/chat.sendMessage")
	public ChatVO sendMessage(@Payload ChatVO chvo) {
	    int res = myService.addChatMsg(chvo);
	    String msg_room = chvo.getMsg_room();
	    messagingTemplate.convertAndSend("/user/queue/" + msg_room, chvo);
	    return chvo;
	}

}