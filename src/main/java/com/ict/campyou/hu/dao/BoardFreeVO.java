package com.ict.campyou.hu.dao;

public class BoardFreeVO {
	private String bf_no, b_title, member_nickname, b_content, regdate;

	public String getBf_no() {
		return bf_no;
	}

	public void setBf_no(String bf_no) {
		this.bf_no = bf_no;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getB_title() {
		return b_title;
	}

	public void setB_title(String b_title) {
		this.b_title = b_title;
	}

	public String getMember_nickname() {
		return member_nickname;
	}

	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}

	public String getB_content() {
		return b_content;
	}

	public void setB_content(String b_content) {
		this.b_content = b_content;
	}
}
