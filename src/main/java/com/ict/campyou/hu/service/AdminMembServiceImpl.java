package com.ict.campyou.hu.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.hu.dao.AdminMembDAO;
import com.ict.campyou.hu.dao.AdminMembVO;
import com.ict.campyou.hu.dao.MemberVO;

@Service
public class AdminMembServiceImpl implements AdminMembService{
	@Autowired
	private AdminMembDAO adminMembDAO;

	@Override
	public int getAdminSignUp(AdminMembVO admvo) {
		//관리자 가입
		return adminMembDAO.getAdminSignUp(admvo);
	}

	@Override
	public AdminMembVO getAdminLogInOK(AdminMembVO admvo) {
		//관리자 로그인
		return adminMembDAO.getAdminLogInOK(admvo);
	}
}
