package com.ict.campyou.joy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.joy.dao.AdminVO;
import com.ict.campyou.joy.dao.MainDAO;
import com.ict.campyou.jun.dao.CampVO;

@Service
public class MainServiceImpl implements MainService{
		@Autowired
		private MainDAO maindao;
		
		@Override
		public List<AdminVO> getwithboard() {
			return maindao.getwithboard();
		}

		@Override
		public List<CampVO> getcamphit() {
			return maindao.getcamphit();
		}
	
	
	
}