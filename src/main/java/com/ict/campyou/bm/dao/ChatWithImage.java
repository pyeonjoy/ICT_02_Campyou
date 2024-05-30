package com.ict.campyou.bm.dao;

public class ChatWithImage {
	 private ChatVO chat;
	 private String img, opposite_idx;
	 
	 public ChatWithImage(ChatVO chat, String img, String opposite_idx) {
	        this.chat = chat;
	        this.img = img;
	        this.opposite_idx = opposite_idx;
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
	public String getOpposite_idx() {
		return opposite_idx;
	}
	public void setOpposite_idx(String opposite_idx) {
		this.opposite_idx = opposite_idx;
	}
}
