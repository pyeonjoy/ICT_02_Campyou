package com.ict.campyou.joy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.joy.dao.AdminDAO;
import com.ict.campyou.joy.dao.AdminVO;
import com.ict.campyou.joy.dao.AdminMemberVO;

@Service
public class AdminServiceImpl implements AdminService{
	@Autowired
	private AdminDAO admindao;
	
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
	public List<AdminMemberVO> getboardall() {
		System.out.println(admindao.getboardall());
		return admindao.getboardall();
	}
	
	@Override
	public List<AdminMemberVO> getadminmemberreport(String member_idx) {
		return admindao.getadminmemberreport(member_idx);
	}

	@Override
	public int getreportall() {
		return admindao.getreportall();
	}

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


}
