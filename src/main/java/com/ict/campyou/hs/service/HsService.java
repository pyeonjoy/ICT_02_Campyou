package com.ict.campyou.hs.service;

import java.util.List;

import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.jun.dao.CampVO;

public interface HsService {

	public List<CampVO> getLocalKeyword() throws Exception;

	public MemberVO getMember(String member_idx) throws Exception;

}
