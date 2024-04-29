package com.ict.campyou.joy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.joy.dao.AdminDAO;
import com.ict.campyou.joy.dao.AdminVO;
import com.ict.campyou.joy.dao.MemberVO;

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
	public List<MemberVO> getboardall() {
		System.out.println(admindao.getboardall());
		return admindao.getboardall();
	}
	
	@Override
	public List<MemberVO> getadminmemberreport() {
		return admindao.getadminmemberreport();
	}

	@Override
	public int getreportall() {
		return admindao.getreportall();
	}


}
