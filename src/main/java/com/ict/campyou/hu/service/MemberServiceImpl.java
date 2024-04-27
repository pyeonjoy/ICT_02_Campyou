package com.ict.campyou.hu.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.hu.dao.MemberDAO;
import com.ict.campyou.hu.dao.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDAO memberDAO;

	@Override
	public int getSignUp(MemberVO vo) {
		
		return memberDAO.getSignUp(vo);
	}
	
	@Override
	public String getIdChk(String member_id){
		
		return memberDAO.getIdChk(member_id);
	}
	
	@Override
	public String getLogInIdChk(String member_id) {
		return memberDAO.getLogInIdChk(member_id);
	}

	@Override
	public MemberVO getLogInOK(MemberVO vo) {
		
		return memberDAO.getLogInOK(vo);
	}

	@Override
	public MemberVO getMyPwd(MemberVO mvo2) {
		
		return memberDAO.getMyPwd(mvo2);
	}

	@Override
	public int getTempPwdUpdate(MemberVO mvo) {
		
		return memberDAO.getTempPwdUpdate(mvo);
	}

	@Override
	public MemberVO getMyID(String member_name) {

		return memberDAO.getMyID(member_name);
	}

	@Override
	public String getNickNameChk(String member_nickname) {
		
		return memberDAO.getNickNameChk(member_nickname);
	}
}
