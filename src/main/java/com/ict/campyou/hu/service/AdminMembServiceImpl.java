package com.ict.campyou.hu.service;

import java.util.List;

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
	public int getTotalCount() {
		//관리자 페이지 페이지수 카운트
		return adminMembDAO.getTotalCount();
	}

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

	@Override
	public String getAdminIdChk(String admin_id) {
		// 관리자 아이디 중복 체크
		return adminMembDAO.getAdminIdChk(admin_id);
	}

	@Override
	public List<AdminMembVO> getAdminList(int offset, int limit) {
		// 관리자 리스트
		return adminMembDAO.getAdminList(offset, limit);
	}

	@Override
	public int getGiveAdminPermissionUpdate(AdminMembVO admvo) {
		//관리자 권한주기 업데이트
		return adminMembDAO.getGiveAdminPermissionUpdate(admvo);
	}

	@Override
	public int getRevokeAdminPermissionUpdate(AdminMembVO admvo) {
		//관리자 권한 빼앗기 업데이트
		return adminMembDAO.getRevokeAdminPermissionUpdate(admvo);
	}

	@Override
	public int getAssistantAdminDelete(String admin_idx) {
		//슈퍼관리자가 부하관리자 강제삭제
		return adminMembDAO.getAssistantAdminDelete(admin_idx);
	}

	@Override
	public AdminMembVO getAdminInfoDetail(String admin_idx) {
		//관리자 정보 가지고 오기
		return adminMembDAO.getAdminInfoDetail(admin_idx);
	}

	@Override
	public int getAdminUpdateOk(AdminMembVO admvo) {
		//관리자 정보수정
		return adminMembDAO.getAdminUpdateOk(admvo);
	}
}
