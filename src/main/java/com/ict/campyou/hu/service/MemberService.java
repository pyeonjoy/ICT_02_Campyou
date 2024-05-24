package com.ict.campyou.hu.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.ict.campyou.hu.dao.CommBoardVO;
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
	 
	 //카카오 회원 insert 하기
	 public int getInsertKakaoId(HttpSession session);
		 
	 //카카오 로그인 회원정보 받아오기
	 public MemberVO getKakaoLogInOk(HttpSession session);
	 
	 //네이버 회원 insert 하기
	 public int getInsertNaverId(HttpSession session);
	 
	 //네이버 로그인 회원정보 받아오기
	 public MemberVO getNaverLogInOk(HttpSession session);

	 //맴버 디테일
	 public MemberVO getMemeberDetail(String member_idx);
	 
	 //자유 게시판과 캠핑게시판 글쓸때 마다 member_free 등급 올리기
	 public int getMemberFreeUpdate(String member_idx);
	 
	 public int getUpdateMemberGrade(String member_idx);
	 
	 public int getUpdateMemberGrade2(String member_idx);
	 public int getUpdateMemberGrade3(String member_idx);
	 public int getUpdateMemberGrade4(String member_idx);
	 public int getUpdateMemberGrade5(String member_idx); 
}