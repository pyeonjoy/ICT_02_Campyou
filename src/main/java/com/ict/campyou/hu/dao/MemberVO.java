package com.ict.campyou.hu.dao;

import org.springframework.web.multipart.MultipartFile;

public class MemberVO {
	private String member_idx, member_id, member_name, member_nickname, member_dob, member_email, member_pwd,
			member_phone, member_img, member_active, member_regdate, member_old_img,member_grade, member_login ;
  
	public String getAdmin_idx() {
		return admin_idx;
	}

	public void setAdmin_idx(String admin_idx) {
		this.admin_idx = admin_idx;
	}

	public String getReportmember_idx() {
		return reportmember_idx;
	}

	public void setReportmember_idx(String reportmember_idx) {
		this.reportmember_idx = reportmember_idx;
	}

	public String getMember_login() {
		return member_login;
	}

	public void setMember_login(String member_login) {
		this.member_login = member_login;
	}

	public String getMember_grade() {
		return member_grade;
	}

	public void setMember_grade(String member_grade) {
		this.member_grade = member_grade;
	}

	public String getMember_old_img() {
		return member_old_img;
	}

	public void setMember_old_img(String member_old_img) {
		this.member_old_img = member_old_img;
	}

	private MultipartFile file;

	public String getMember_img() {
		return member_img;
	}

	public void setMember_img(String member_img) {
		this.member_img = member_img;
	}


	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public String getMember_regdate() {
		return member_regdate;
	}

	public void setMember_regdate(String member_regdate) {
		this.member_regdate = member_regdate;
	}

	public String getMember_idx() {
		return member_idx;
	}

	public void setMember_idx(String member_idx) {
		this.member_idx = member_idx;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_nickname() {
		return member_nickname;
	}

	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}

	public String getMember_dob() {
		return member_dob;
	}

	public void setMember_dob(String member_dob) {
		this.member_dob = member_dob;
	}

	public String getMember_email() {
		return member_email;
	}

	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}

	public String getMember_pwd() {
		return member_pwd;
	}

	public void setMember_pwd(String member_pwd) {
		this.member_pwd = member_pwd;
	}

	public String getMember_phone() {
		return member_phone;
	}

	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}

	public String getMember_active() {
		return member_active;
	}

	public void setMember_active(String member_active) {
		this.member_active = member_active;
	}
}