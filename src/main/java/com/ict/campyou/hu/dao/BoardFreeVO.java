package com.ict.campyou.hu.dao;

public class BoardFreeVO {
	private String bf_no, b_subject, member_nickname, b_content, b_regdate;

	public String getBf_no() {
		return bf_no;
	}

	public void setBf_no(String bf_no) {
		this.bf_no = bf_no;
	}

	public String getB_subject() {
		return b_subject;
	}

	public void setB_subject(String b_subject) {
		this.b_subject = b_subject;
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

	public String getB_regdate() {
		return b_regdate;
	}

	public void setB_regdate(String b_regdate) {
		this.b_regdate = b_regdate;
	}
}