package com.ict.campyou.hu.dao;

public class CampingGearSearchVO {
	private String bf_no, cp_idx, cp_subject, member_nickname, cp_content, cp_regdate;

	public String getBf_no() {
		return bf_no;
	}

	public String getCp_idx() {
		return cp_idx;
	}

	public void setCp_idx(String cp_idx) {
		this.cp_idx = cp_idx;
	}

	public void setBf_no(String bf_no) {
		this.bf_no = bf_no;
	}

	public String getCp_subject() {
		return cp_subject;
	}

	public void setCp_subject(String cp_subject) {
		this.cp_subject = cp_subject;
	}

	public String getMember_nickname() {
		return member_nickname;
	}

	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}

	public String getCp_content() {
		return cp_content;
	}

	public void setCp_content(String cp_content) {
		this.cp_content = cp_content;
	}

	public String getCp_regdate() {
		return cp_regdate;
	}

	public void setCp_regdate(String cp_regdate) {
		this.cp_regdate = cp_regdate;
	}
}