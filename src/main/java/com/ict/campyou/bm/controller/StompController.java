package com.ict.campyou.bm.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.HtmlUtils;

import com.ict.campyou.bm.dao.ChatVO;
import com.ict.campyou.bm.dao.ChatMessage;
import com.ict.campyou.bm.dao.ChatRoom;
import com.ict.campyou.bm.service.MyService;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.hu.service.MemberService;


@Controller
public class StompController {

    @Autowired
    private SimpMessageSendingOperations messagingTemplate;
    @Autowired
    
    private MyService myService;
	private Map<String, ChatRoom> chatRooms = new HashMap<>();


	@MessageMapping("/chat.sendMessage")
	@SendTo("/topic/public")
	public ChatVO sendMessage(@Payload ChatVO chvo) {
		System.out.println(chvo);
	     Date day = new Date();
	      SimpleDateFormat sDate2 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
	      String now = sDate2.format(day);
	      UUID roomId = UUID.randomUUID();
	      System.out.println(now);
	      System.out.println(roomId);
	     
	      ChatVO newRoom = new ChatVO();
	      newRoom.setMsg_content(chvo.getMsg_content());
	      newRoom.setMsg_room(roomId.toString());
	      newRoom.setSend_nick(chvo.getSend_nick());
	      newRoom.setSend_date(now);
	      newRoom.setReci_nick(chvo.getReci_nick());
	      int res = myService.addChatMsg(newRoom);
	      if (res == 1) {
	          System.out.println("채팅 메시지가 데이터베이스에 성공적으로 저장되었습니다.");
	      } else {
	          System.out.println("채팅 메시지를 데이터베이스에 저장하는 중 오류가 발생했습니다.");
	      }

	      messagingTemplate.convertAndSend("/topic/public", newRoom);
	      return newRoom;
	}

	@MessageMapping("/chat.addUser")
	@SendTo("/topic/public")
	public ChatMessage addUser(@Payload ChatMessage chatMessage) {
		return chatMessage;
	}

	@MessageMapping("/chatroom.create")
	@SendToUser("/queue/chatroom/create")
	public ChatRoom createChatRoom(@Payload ChatRoom chatRoom, SimpMessageHeaderAccessor headerAccessor) {
		String roomId = headerAccessor.getSessionId();
        chatRoom.setId(roomId);
        chatRooms.put(roomId, chatRoom);
        return chatRoom;
    }

    @MessageMapping("/chatroom.join")
    public void joinChatRoom(@Payload ChatRoom chatRoom, SimpMessageHeaderAccessor headerAccessor) {
    	String roomId = chatRoom.getId();
        headerAccessor.getSessionAttributes().put("room_id", roomId);
    }

    @MessageMapping("/chatroom.sendMessage")
    public void sendMessage(@Payload String message, SimpMessageHeaderAccessor headerAccessor) {
    	System.out.println("sendMessage");    	
        String roomId = (String) headerAccessor.getSessionAttributes().get("room_id");
        System.out.println("roomId : "+ roomId);
        System.out.println("message : "+ message);
        // 방 ID를 이용하여 해당 방으로 메시지 브로드캐스트
        messagingTemplate.convertAndSend("/topic/room/" + roomId, message);
        
    }

//채팅방입장
//	 @MessageMapping("/chat.sendMessage")
//	    @SendTo("/topic/public")
//	    public ChatVO sendMessage(ChatVO chatMessage) {
//	        return chatMessage;
//	    }
//
//	    @MessageMapping("/chat.addUser")
//	    @SendTo("/topic/public")
//	    public ChatVO addUser(ChatVO chatMessage) {
//	        return chatMessage;
//	    }
//	@MessageMapping("/chat/join")
//  public ChatVO createChatRoom(@Payload ChatVO chvo, HttpSession session) throws Exception {

//  }


    
//    @MessageMapping("/TTT")
//    @SendTo("/topic/message")
//    public String ttt(String message) throws Exception {
//    	System.out.println(message);
//    	return message;
//    }

}
