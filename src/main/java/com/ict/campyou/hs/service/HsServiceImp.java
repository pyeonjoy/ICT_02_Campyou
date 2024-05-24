package com.ict.campyou.hs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.hs.dao.HsDAO;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.jun.dao.CampVO;

@Service
public class HsServiceImp implements HsService {
	@Autowired
	private HsDAO hsDAO;
	
	@Override
	public List<CampVO> getLocalKeyword() throws Exception {
		return hsDAO.getLocalKeyword();
	}
	
	@Override
	public MemberVO getMember(String member_idx) throws Exception {
		return hsDAO.getMember(member_idx);
	}
}
