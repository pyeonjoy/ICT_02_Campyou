package com.ict.campyou.joy.service;

import java.util.List;

import com.ict.campyou.joy.dao.AdminVO;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.joy.dao.AdminMemberVO;

public interface AdminService {
	public List<AdminVO> getadminmainmember();
	public List<AdminVO> getadminboard();
	public int getadminqna();
	public int getadminreport();
	public int getadminmatch();
	public int getreportall(String member_idx);
	public List<AdminMemberVO> getboardall(String member_idx);
	public List<AdminMemberVO> getadminmemberreport(String member_idx);
	public int getmemberstop(String member_idx);
	public int getmemberstopcancel(String member_idx);
	public int getmemberedit(AdminMemberVO avo);
	public int getmemberdelete(String member_idx);
	public int getmemberupgrade(String member_idx);
	public int getremoveimg(String member_idx);
	public int getPopUPWrite(AdminVO avo);
	public List<AdminVO> getPopList(int offset, int limit);
	public List<MemberVO> allmember(int offset, int limit);
	public int getTotalCount();
	public int getpopupdate(AdminVO avo);
	
}
