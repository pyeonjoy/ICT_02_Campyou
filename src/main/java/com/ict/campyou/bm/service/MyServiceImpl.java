package com.ict.campyou.bm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.bm.dao.FaqVO;
import com.ict.campyou.bm.dao.MyDAO;
import com.ict.campyou.hu.dao.MemberVO;

@Service
public class MyServiceImpl implements MyService{

	@Autowired
	private MyDAO myDao; 
	@Override
	public List<FaqVO> getFaqs() {
		return myDao.getFaqs();
	}
	@Override
	public List<FaqVO> getFaqs2() {
		return myDao.getFaqs2();
	}
	@Override
	public MemberVO getMemberPwd(String memberId) {		
		return myDao.getMemberPwd(memberId);
	}

}
