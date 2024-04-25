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
		//ȸ������
		return memberDAO.getSignUp(vo);
	}
	
	@Override
	public String getIdChk(String member_id){
		//���̵� �ߺ� Ȯ��
		return memberDAO.getIdChk(member_id);
	}

	@Override
	public MemberVO getLogInOK(MemberVO vo) {
		//�α���
		return memberDAO.getLogInOK(vo);
	}

	@Override
	public MemberVO getMyPwd(String member_id) {
		// ��й�ȣ ã��
		return memberDAO.getMyPwd(member_id);
	}

	@Override
	public int getTempPwdUpdate(MemberVO mvo) {
		//���� �޴� �ӽ� ��й�ȣ �����ϱ�
		return memberDAO.getTempPwdUpdate(mvo);
	}

	@Override
	public MemberVO getMyID(String member_name) {
		//���̵� ã��
		return memberDAO.getMyID(member_name);
	}
}
