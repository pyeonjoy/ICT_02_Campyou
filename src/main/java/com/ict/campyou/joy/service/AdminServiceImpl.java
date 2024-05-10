package com.ict.campyou.joy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.joy.dao.AdminDAO;
import com.ict.campyou.joy.dao.AdminVO;
import com.ict.campyou.joy.dao.AdminMemberVO;

@Service
public class AdminServiceImpl implements AdminService{
	@Autowired
	private AdminDAO admindao;
//관리자페이지메인 =================================================================
	@Override
	public List<AdminVO> getadminmainmember() {
		return admindao.getadminmainmember();
	}

	@Override
	public List<AdminVO> getadminboard() {
		return admindao.getadminboard();
	}

	@Override
	public int getadminqna() {
		return admindao.getadminqna();
	}

	@Override
	public int getadminreport() {
		return admindao.getadminreport();
	}

	@Override
	public int getadminmatch() {
		return admindao.getadminmatch();
	}
	
	@Override
	public List<AdminMemberVO> getboardall(String member_idx) {
		return admindao.getboardall(member_idx);
	}
	
	@Override
	public List<AdminMemberVO> getadminmemberreport(String member_idx) {
		return admindao.getadminmemberreport(member_idx);
	}

	@Override
	public int getreportall(String member_idx) {
		return admindao.getreportall(member_idx);
	}

	//회원관리 ========================================================================
	@Override
	public int getmemberstop(String member_idx) {
		return admindao.getmemberstop(member_idx);
	}
	@Override
	public int getmemberstopcancel(String member_idx) {
		return admindao.getmemberstopcancel(member_idx);
	}

	@Override
	public int getmemberedit(AdminMemberVO avo) {
		return admindao.getmemberedit(avo);
	}

	@Override
	public int getmemberdelete(String member_idx) {
		return admindao.getmemberdelete(member_idx);
	}

	@Override
	public int getmemberupgrade(String member_idx) {
		return admindao.getmemberupgrade(member_idx);
	}
	@Override
	public int getremoveimg(String member_idx) {
		return admindao.getremoveimg(member_idx);
	}

	@Override
	public List<MemberVO> allmember(int offset, int limit) {
		return admindao.allmember(offset, limit);
	}

//팝업===================================================================================		
	@Override
	public int getPopUPWrite(AdminVO avo) {
		return admindao.getPopUPWrite(avo);
	}

	@Override
	public List<AdminVO> getPopList(int offset, int limit) {
		return admindao.getPopList(offset, limit);
	}

	@Override
	public int getTotalCount() {
		return admindao.getTotalCount();
	}
	@Override
	public int getTotalCount2() {
		return admindao.getTotalCount2();
	}

	
	@Transactional
	@Override
	public int getpopupdate(AdminVO avo) {
		int result1 = admindao.getpopupdate2(avo); 
		int result2 = admindao.getpopupdate(avo); 
		System.out.println("1:"+ result1);
		System.out.println("2:"+ result2);
		if (result1 > 0 && result2 > 0) {
		System.out.println("오나?");
			return 1; // 성공
		} else {
			return -1; // 실패
		}
	}
	@Override
	public int getPopDelete(String popidx) {
		return admindao.getpopdelete(popidx);
	}

	@Override
	public String getPopmain() {
		return admindao.getPopmain();
	}

	@Override
	public List<AdminMemberVO> getradmineporteach(String member_idx) {
		return admindao.getradmineporteach(member_idx);
	}

	@Transactional
	@Override
	public int getadminreport(String report_day,String report_idx,String adminmember_idx) {
		int result1 = admindao.getadminreport(report_day,report_idx); 
		int result2 = admindao.getadminreportadd(report_day,report_idx,adminmember_idx); 
		System.out.println("1:"+ result1);
		System.out.println("2:"+ result2);
		if (result1 > 0 && result2 > 0) {
		System.out.println("오나?");
			return 1; // 성공
		} else {
			return -1; // 실패
		}
	}
	
	
	
	
	
	@Override
	public int getstatusupdate() {
		return admindao.getstatusupdate();
	}
	
	

}
