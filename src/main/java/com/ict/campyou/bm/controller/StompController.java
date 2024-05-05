package com.ict.campyou.bm.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;

import com.ict.campyou.bm.dao.ChatVO;
import com.ict.campyou.bm.service.MyService;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.hu.service.MemberService;


@Controller
public class StompController {

    @Autowired
    private SimpMessageSendingOperations messagingTemplate;


	@Autowired
	
	private MemberService memberService;
//채팅방입장
//	@MessageMapping("/chat/join")
//	public ChatMessage sendMsg(String sessionUrl, ChatMessage message) throws Exception {
//		Date day = new Date();
//	    SimpleDateFormat sDate2 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
//	    String now = sDate2.format(day);
//	    System.out.println(message.getRoom_no()+" 번방 열음");
//	   
//	    UserVO uvo = memberService.getMember(message.getDw_member_no());
//	    if(uvo != null) {
//	    	String member_nickname = uvo.getMember_nickname();
//	    	message.setDate(now);
//		    message.setType("user_JOIN");
//		    message.setDw_member_nick(member_nickname);
//		    message.setMessage("님이 입장하셨습니다.");
//		    //해당 룸에 맞게 데이터를 뿌려줌
//		    messageTemple.convertAndSend("/topic/room/"+message.getRoom_no(),message);
//	  
//	    return message;
//	}


    @Autowired
    private MyService myService;

    
    @MessageMapping("/TTT")
    @SendTo("/topic/message")
    public String ttt(String message) throws Exception {
    	System.out.println(message);
    	return message;
    }
//    @MessageMapping("/chat")
//    public ChatVO createChatRoom(@Payload ChatVO chvo, HttpSession session) throws Exception {
//        Date day = new Date();
//        SimpleDateFormat sDate2 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
//        String now = sDate2.format(day);
//        UUID roomId = UUID.randomUUID();
//        MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
//        System.out.println(now);
//        System.out.println(roomId);
//        System.out.println(mvo.getMember_nickname());
//        ChatVO newRoom = new ChatVO();
//        newRoom.setMsg_room(roomId.toString());
//        newRoom.setSend_nick(mvo.getMember_nickname());
//        newRoom.setSend_date(now);
//
//        System.out.println(newRoom.getMsg_room() + " 번방 열음");
//
//        messagingTemplate.convertAndSendToUser(
//                mvo.getMember_nickname(), 
//                "/queue/roomId",  
//                roomId.toString()
//        );
//        return newRoom;
//    }

}
