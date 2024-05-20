package com.ict.campyou.hu.service;

import com.ict.campyou.hu.dao.MemberVO;

public interface MemberService {
	 //member Sing-up
	 public int getSignUp(MemberVO vo);
	 
	 //id double check
	 public String getIdChk(String member_id);
	 
	//login id double check
	 public String getLogInIdChk(String member_id);
	 
	 //login 
	 public MemberVO getLogInOK(MemberVO vo);
	 
	 //find my pwd
	 public MemberVO getMyPwd(MemberVO mvo2);
	 
	 //temp pwd update
	 public int getTempPwdUpdate(MemberVO mvo);
	 
	 //find my id
	 public MemberVO getMyID(String member_name);
	 //별명 중복 검사
	 public String getNickNameChk(String member_nickname);
	 
	 //카카오 로그인 access token 받아오기
	 public String getKakaoAccessToken(String code);
	 
	 //카카오 회원 insert 하기
	 public int getInsertKakaoId(String access_token);
		 
	 //카카오 로그인 회원정보 받아오기
	 public MemberVO getKakaoLogInOk(String access_token);
	 
	 //네이버 로그인 access token 받아오기
	 public String getNaverAccessToken(String code);
	 
	 public int getInsertNaverId(String access_token);
	 
	 //네이버 로그인 회원정보 받아오기
	 public MemberVO getNaverLogInOk(String access_token);
	
	 
}