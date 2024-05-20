package com.ict.campyou.hu.service;

import java.util.List;

import com.ict.campyou.hu.dao.AdminMembVO;
import com.ict.campyou.hu.dao.MemberVO;

public interface AdminMembService {
	
	//관리자 페이지 페이지수 카운트
	public int getTotalCount();
	
	//관리자 가입
	public int getAdminSignUp(AdminMembVO admvo);
	
	//대장 관리자 로그인
	public AdminMembVO getAdminLogInOK(AdminMembVO admvo);
	
	// 관리자 아이디 중복 체크
	public String getAdminIdChk(String admin_id);
	
	// 관리자 리스트
	public List<AdminMembVO> getAdminList(int offset, int limit);
	 
	//관리자 권한주기 업데이트
	public int getGiveAdminPermissionUpdate(AdminMembVO admvo);
	
	//관리자 권한 빼앗기 업데이트
	public int getRevokeAdminPermissionUpdate(AdminMembVO admvo);
	
	//슈퍼관리자가 부하관리자 강제삭제
	public int getAssistantAdminDelete(String admin_idx);
	 
	//관리자 정보 가지고 오기
	public AdminMembVO getAdminInfoDetail(String admin_idx);
	
	//관리자 정보수정
	public int getAdminUpdateOk(AdminMembVO admvo);
}
   