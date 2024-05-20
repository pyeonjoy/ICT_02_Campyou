package com.ict.campyou.joy.service;

import java.util.List;

import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.joy.dao.AdminVO;
import com.ict.campyou.jun.dao.CampVO;
import com.ict.campyou.jun.dao.ReviewVO;

public interface MainService {
		public List<AdminVO> getwithboard();
		public List<CampVO> getcamphit();
		public int getReportWrite(AdminVO avo);
		int addStar(MemberVO mvo);
}
