package com.ict.campyou.joy.service;

import java.util.List;

import com.ict.campyou.joy.dao.AdminVO;
import com.ict.campyou.jun.dao.CampVO;

public interface MainService {
		public List<AdminVO> getwithboard();
		public List<CampVO> getcamphit();
}