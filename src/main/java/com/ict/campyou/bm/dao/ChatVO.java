package com.ict.campyou.bm.dao;

public class ChatVO {

 private String msg_idx, msg_room, room_name, send_idx, 
 send_nick, reci_nick, send_date, msg_content, msg_read,room_status;

public String getMsg_idx() {
	return msg_idx;
}

public void setMsg_idx(String msg_idx) {
	this.msg_idx = msg_idx;
}

public String getMsg_room() {
	return msg_room;
}

public String getRoom_name() {
	return room_name;
}

public void setRoom_name(String room_name) {
	this.room_name = room_name;
}

public void setMsg_room(String msg_room) {
	this.msg_room = msg_room;
}

public String getSend_nick() {
	return send_nick;
}

public void setSend_nick(String send_nick) {
	this.send_nick = send_nick;
}

public String getReci_nick() {
	return reci_nick;
}

public void setReci_nick(String reci_nick) {
	this.reci_nick = reci_nick;
}

public String getSend_date() {
	return send_date;
}

public void setSend_date(String send_date) {
	this.send_date = send_date;
}



public String getMsg_content() {
	return msg_content;
}

public void setMsg_content(String msg_content) {
	this.msg_content = msg_content;
}

public String getMsg_read() {
	return msg_read;
}

public void setMsg_read(String msg_read) {
	this.msg_read = msg_read;
}

public String getSend_idx() {
	return send_idx;
}

public void setSend_idx(String send_idx) {
	this.send_idx = send_idx;
}

public String getRoom_status() {
	return room_status;
}

public void setRoom_status(String room_status) {
	this.room_status = room_status;
}


 
}
