package com.ict.campyou.bm.service;

import java.util.List;

import com.ict.campyou.bm.dao.FaqVO;
import com.ict.campyou.bm.dao.UserVO;
import com.ict.campyou.hu.dao.MemberVO;

public interface MyService {

	// get faq questions
	public List<FaqVO> getFaqs();
	public List<FaqVO> getFaqs2();
	
	public MemberVO getMemberPwd(String memberId);
	public int changeUserInfo(UserVO uvo);
	public int changeUserPW(UserVO uvo);
}
