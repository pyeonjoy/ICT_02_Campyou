package com.ict.campyou.bm.controller;

import java.sql.Date;

import java.text.SimpleDateFormat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageSendingOperations;

import com.ict.campyou.bm.dao.UserVO;
import com.ict.campyou.hu.service.MemberService;


public class StompController {

	@Autowired
	private SimpMessageSendingOperations messagingTemplate;

	@Autowired
	
	private MemberService memberService;
//梨꾪똿諛⑹엯�옣
	@MessageMapping("/chat/join")
	public ChatMessage sendMsg(String sessionUrl, ChatMessage message) throws Exception {
		Date day = new Date();
	    SimpleDateFormat sDate2 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss.SSS");
	    String now = sDate2.format(day);
	    System.out.println(message.getRoom_no()+" 踰덈갑 �뿴�쓬");
	   
	    UserVO uvo = memberService.getMember(message.getDw_member_no());
	    if(uvo != null) {
	    	String member_nickname = uvo.getMember_nickname();
	    	message.setDate(now);
		    message.setType("user_JOIN");
		    message.setDw_member_nick(member_nickname);
		    message.setMessage("�떂�씠 �엯�옣�븯�뀲�뒿�땲�떎.");
		    //�빐�떦 猷몄뿉 留욊쾶 �뜲�씠�꽣瑜� 肉뚮젮以�
		    messageTemple.convertAndSend("/topic/room/"+message.getRoom_no(),message);
	  
	    return message;
	}
��
}
