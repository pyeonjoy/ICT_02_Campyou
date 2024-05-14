package com.ict.campyou.joy.service;

import java.util.List;

import com.ict.campyou.joy.dao.AdminVO;
import com.ict.campyou.hu.dao.CampingGearSearchVO;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.joy.dao.AdminMemberVO;

public interface AdminService {
//관리자페이지 메인 
	public List<AdminVO> getadminmainmember();
	public List<AdminVO> getadminboard();
	public int getmainadminreport();
	public int getadminqna();
	public int getadminreport();
	public int getadminmatch();
	public int getreportall(String member_idx);
//회원관리페이지
	public List<AdminMemberVO> getboardall(String member_idx);
	public List<AdminMemberVO> getadminmemberreport(String member_idx);
	public List<AdminMemberVO> getradminstop(String member_idx);
	public List<AdminMemberVO> getradmineporteach(String member_idx);
	public int getmemberstop(String member_idx);
	public int getmemberstopcancel(String member_idx);
	public int getmemberedit(AdminMemberVO avo);
	public int getmemberdelete(String member_idx);
	public int getmemberupgrade(String member_idx);
	public int getremoveimg(String member_idx);
	public List<MemberVO> allmember(int offset, int limit);
	public int getTotalCount2();
	List<AdminMemberVO> getmemberSearch(String searchType, String keyword, int offset, int limit);
	public int getadminreport(String report_day, String report_idx, String admin_idx, String reportmember_idx);
	public int getadminreportall(AdminMemberVO amvo);
	
//팝업
	public int getPopUPWrite(AdminVO avo);
	public List<AdminVO> getPopList(int offset, int limit);
	public int getTotalCount();
	public int getpopupdate(AdminVO avo);
	public int getPopDelete(String popidx);
	public String getPopmain();
	public int getstatusupdate();
	
}
