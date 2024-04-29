package com.ict.campyou.hu.service;

import com.ict.campyou.hu.dao.MemberVO;

public interface MemberService {
	 //member Sing-up
	 public int getSignUp(MemberVO vo);
	 
	 // id double check
	 public String getIdChk(String member_id);
	 
	// login id double check
	 public String getLogInIdChk(String member_id);
	 
	 // login 
	 public MemberVO getLogInOK(MemberVO vo);
	 
	 // find my pwd
	 public MemberVO getMyPwd(MemberVO mvo2);
	 
	 // temp pwd update
	 public int getTempPwdUpdate(MemberVO mvo);
	 
	 // find my id
	 public MemberVO getMyID(String member_name);
	 
	 public String getNickNameChk(String member_nickname);
}
