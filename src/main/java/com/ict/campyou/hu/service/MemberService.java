package com.ict.campyou.hu.service;

import com.ict.campyou.hu.dao.MemberVO;

public interface MemberService {
	//ȸ������
	 public int getSignUp(MemberVO vo);
	 
	 // ���̵� �ߺ� Ȯ��
	 public String getIdChk(String member_id);
	 
	 //�α���
	 public MemberVO getLogInOK(MemberVO vo);
	 
	 //��й�ȣ ã��
	 public MemberVO getMyPwd(String member_id);
	 
	 //���� �޴� �ӽ� ��й�ȣ �����ϱ�
	 public int getTempPwdUpdate(MemberVO mvo);
	 
	 //���̵� ã��
	 public MemberVO getMyID(String member_name);

}
