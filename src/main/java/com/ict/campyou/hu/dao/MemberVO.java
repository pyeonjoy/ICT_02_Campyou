package com.ict.campyou.hu.dao;

import org.springframework.web.multipart.MultipartFile;

public class MemberVO {
	private String member_idx, member_id, admin_idx, member_name, member_nickname, member_dob, member_email, member_gender, member_pwd,
			member_phone, member_img, member_active, member_regdate, member_old_img,member_grade, member_login, member_free, member_with, member_camp, member_rating, rating_count, member_rating_all ;
  
	
	public String getMember_free() {
		return member_free;
	}

	public void setMember_free(String member_free) {
		this.member_free = member_free;
	}

	public String getMember_with() {
		return member_with;
	}

	public void setMember_with(String member_with) {
		this.member_with = member_with;
	}

	public String getMember_camp() {
		return member_camp;
	}

	public void setMember_camp(String member_camp) {
		this.member_camp = member_camp;
	}

	public String getMember_rating() {
		return member_rating;
	}

	public void setMember_rating(String member_rating) {
		this.member_rating = member_rating;
	}

	public String getRating_count() {
		return rating_count;
	}

	public void setRating_count(String rating_count) {
		this.rating_count = rating_count;
	}

	public String getMember_rating_all() {
		return member_rating_all;
	}

	public void setMember_rating_all(String member_rating_all) {
		this.member_rating_all = member_rating_all;
	}

	public String getAdmin_idx() {
		return admin_idx;
	}

	public String getMember_gender() {
		return member_gender;
	}

	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}

	public void setAdmin_idx(String admin_idx) {
		this.admin_idx = admin_idx;
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