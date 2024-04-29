package com.ict.campyou.joy.dao;

public class AdminVO {
	private String report_date, cp_regdate, bf_regdate, t__regdate, member_regdate,  
	member_active, qna_status, totalMembers, todayMembers;
	
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
