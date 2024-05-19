package com.ict.campyou.hu.service;

import com.ict.campyou.hu.dao.AdminMembVO;
import com.ict.campyou.hu.dao.MemberVO;

public interface AdminMembService {
	
	//관리자 가입
	public int getAdminSignUp(AdminMembVO admvo);
	
	//관리자 로그인
	public AdminMembVO getAdminLogInOK(AdminMembVO admvo);

}
