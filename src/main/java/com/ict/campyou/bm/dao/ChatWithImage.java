package com.ict.campyou.bm.dao;

public class ChatWithImage {
	 private ChatVO chat;
	 private String img;
	 public ChatWithImage(ChatVO chat, String img) {
	        this.chat = chat;
	        this.img = img;
	    }
	public ChatVO getChat() {
		return chat;
	}
	public void setChat(ChatVO chat) {
		this.chat = chat;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
}
