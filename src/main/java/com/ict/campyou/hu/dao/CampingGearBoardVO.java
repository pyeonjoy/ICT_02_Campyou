package com.ict.campyou.hu.dao;

import org.springframework.web.multipart.MultipartFile;

public class CampingGearBoardVO {
	private String cp_idx, member_idx, admin_idx, cp_subject, member_nickname, admin_nickname, cp_content, cp_pwd, cpf_name, cp_regdate, cp_hit, cp_active, cp_notice, groups, step, lev, old_f_name;
	private MultipartFile file;
	
	public String getAdmin_nickname() {
		return admin_nickname;
	}
	public void setAdmin_nickname(String admin_nickname) {
		this.admin_nickname = admin_nickname;
	}
	public String getCp_idx() {
		return cp_idx;
	}
	public String getAdmin_idx() {
		return admin_idx;
	}
	public void setAdmin_idx(String admin_idx) {
		this.admin_idx = admin_idx;
	}
	public void setCp_idx(String cp_idx) {
		this.cp_idx = cp_idx;
	}
	public String getMember_idx() {
		return member_idx;
	}
	public void setMember_idx(String member_idx) {
		this.member_idx = member_idx;
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
	public String getCp_pwd() {
		return cp_pwd;
	}
	public void setCp_pwd(String cp_pwd) {
		this.cp_pwd = cp_pwd;
	}
	public String getCpf_name() {
		return cpf_name;
	}
	public void setCpf_name(String cpf_name) {
		this.cpf_name = cpf_name;
	}
	public String getCp_regdate() {
		return cp_regdate;
	}
	public void setCp_regdate(String cp_regdate) {
		this.cp_regdate = cp_regdate;
	}
	public String getCp_hit() {
		return cp_hit;
	}
	public void setCp_hit(String cp_hit) {
		this.cp_hit = cp_hit;
	}
	public String getCp_active() {
		return cp_active;
	}
	public void setCp_active(String cp_active) {
		this.cp_active = cp_active;
	}
	public String getCp_notice() {
		return cp_notice;
	}
	public void setCp_notice(String cp_notice) {
		this.cp_notice = cp_notice;
	}
	public String getGroups() {
		return groups;
	}
	public void setGroups(String groups) {
		this.groups = groups;
	}
	public String getStep() {
		return step;
	}
	public void setStep(String step) {
		this.step = step;
	}
	public String getLev() {
		return lev;
	}
	public void setLev(String lev) {
		this.lev = lev;
	}
	public String getOld_f_name() {
		return old_f_name;
	}
	public void setOld_f_name(String old_f_name) {
		this.old_f_name = old_f_name;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
}