package com.ict.campyou.joy.dao;

import org.springframework.web.multipart.MultipartFile;

public class AdminVO {
	private String report_date, cp_regdate, bf_regdate, t__regdate, member_regdate,  
	member_active, qna_status, totalMembers, todayMembers, hit, f_name, title, writer,regdate,
	groups, step, lev;
	
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


	public String getF_name() {
		return f_name;
	}


	public void setF_name(String f_name) {
		this.f_name = f_name;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getWriter() {
		return writer;
	}


	public void setWriter(String writer) {
		this.writer = writer;
	}


	public String getRegdate() {
		return regdate;
	}


	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	int popidx;
	private MultipartFile file;
	public MultipartFile getFile() {
		return file;
	}


	public int getPopidx() {
		return popidx;
	}


	public void setPopidx(int popidx) {
		this.popidx = popidx;
	}


	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public String getHit() {
		return hit;
	}

	public void setHit(String hit) {
		this.hit = hit;
	}

	private String t_idx, member_idx, t_subject, t_content, t_campname, t_camptype, t_postcode, t_address, t_address_detail, t_startdate, t_enddate, tf_name, t_regdate, t_hit, t_active, t_notice, member_dob, member_nickname;

	public String getT_idx() {
		return t_idx;
	}

	public void setT_idx(String t_idx) {
		this.t_idx = t_idx;
	}

	public String getMember_idx() {
		return member_idx;
	}

	public void setMember_idx(String member_idx) {
		this.member_idx = member_idx;
	}

	public String getT_subject() {
		return t_subject;
	}

	public void setT_subject(String t_subject) {
		this.t_subject = t_subject;
	}

	public String getT_content() {
		return t_content;
	}

	public void setT_content(String t_content) {
		this.t_content = t_content;
	}

	public String getT_campname() {
		return t_campname;
	}

	public void setT_campname(String t_campname) {
		this.t_campname = t_campname;
	}

	public String getT_camptype() {
		return t_camptype;
	}

	public void setT_camptype(String t_camptype) {
		this.t_camptype = t_camptype;
	}

	public String getT_postcode() {
		return t_postcode;
	}

	public void setT_postcode(String t_postcode) {
		this.t_postcode = t_postcode;
	}

	public String getT_address() {
		return t_address;
	}

	public void setT_address(String t_address) {
		this.t_address = t_address;
	}

	public String getT_address_detail() {
		return t_address_detail;
	}

	public void setT_address_detail(String t_address_detail) {
		this.t_address_detail = t_address_detail;
	}

	public String getT_startdate() {
		return t_startdate;
	}

	public void setT_startdate(String t_startdate) {
		this.t_startdate = t_startdate;
	}

	public String getT_enddate() {
		return t_enddate;
	}

	public void setT_enddate(String t_enddate) {
		this.t_enddate = t_enddate;
	}

	public String getTf_name() {
		return tf_name;
	}

	public void setTf_name(String tf_name) {
		this.tf_name = tf_name;
	}

	public String getT_regdate() {
		return t_regdate;
	}

	public void setT_regdate(String t_regdate) {
		this.t_regdate = t_regdate;
	}

	public String getT_hit() {
		return t_hit;
	}

	public void setT_hit(String t_hit) {
		this.t_hit = t_hit;
	}

	public String getT_active() {
		return t_active;
	}

	public void setT_active(String t_active) {
		this.t_active = t_active;
	}

	public String getT_notice() {
		return t_notice;
	}

	public void setT_notice(String t_notice) {
		this.t_notice = t_notice;
	}

	public String getMember_dob() {
		return member_dob;
	}

	public void setMember_dob(String member_dob) {
		this.member_dob = member_dob;
	}

	public String getMember_nickname() {
		return member_nickname;
	}

	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}

	private int  unactiveMembers, count, totalqnl, totalpm_dix, totalreport,totalb_idx,totalt_idx,totalcp_idx;
	public int getTotalpm_dix() {
		return totalpm_dix;
	}

	public void setTotalpm_dix(int totalpm_dix) {
		this.totalpm_dix = totalpm_dix;
	}

	public int getTotalb_idx() {
		return totalb_idx;
	}

	public void setTotalb_idx(int totalb_idx) {
		this.totalb_idx = totalb_idx;
	}

	public int getTotalt_idx() {
		return totalt_idx;
	}

	public void setTotalt_idx(int totalt_idx) {
		this.totalt_idx = totalt_idx;
	}

	public int getTotalcp_idx() {
		return totalcp_idx;
	}

	public void setTotalcp_idx(int totalcp_idx) {
		this.totalcp_idx = totalcp_idx;
	}

	public int getTotalqnl() {
		return totalqnl;
	}

	public int getCount() {
		return count;
	}

	public void setTotalqnl(int totalqnl) {
		this.totalqnl = totalqnl;
	}

	public int getTotalreport() {
		return totalreport;
	}

	public void setTotalreport(int totalreport) {
		this.totalreport = totalreport;
	}

	public void setUnactiveMembers(int unactiveMembers) {
		this.unactiveMembers = unactiveMembers;
	}

	public void setCount(int count) {
		this.count = count;
	}


	public String getTotalMembers() {
		return totalMembers;
	}

	public void setTotalMembers(String totalMembers) {
		this.totalMembers = totalMembers;
	}

	public String getTodayMembers() {
		return todayMembers;
	}

	public void setTodayMembers(String todayMembers) {
		this.todayMembers = todayMembers;
	}

	public int getUnactiveMembers() {
		return unactiveMembers;
	}

	public String getReport_date() {
		return report_date;
	}

	public void setReport_date(String report_date) {
		this.report_date = report_date;
	}

	public String getCp_regdate() {
		return cp_regdate;
	}

	public void setCp_regdate(String cp_regdate) {
		this.cp_regdate = cp_regdate;
	}

	public String getBf_regdate() {
		return bf_regdate;
	}

	public void setBf_regdate(String bf_regdate) {
		this.bf_regdate = bf_regdate;
	}

	public String getT__regdate() {
		return t__regdate;
	}

	public void setT__regdate(String t__regdate) {
		this.t__regdate = t__regdate;
	}

	public String getMember_regdate() {
		return member_regdate;
	}

	public void setMember_regdate(String member_regdate) {
		this.member_regdate = member_regdate;
	}

	public String getMember_active() {
		return member_active;
	}

	public void setMember_active(String member_active) {
		this.member_active = member_active;
	}

	public String getQna_status() {
		return qna_status;
	}

	public void setQna_status(String qna_status) {
		this.qna_status = qna_status;
	}
}
