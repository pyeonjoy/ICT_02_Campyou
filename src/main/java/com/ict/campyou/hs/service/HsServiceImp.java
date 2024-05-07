package com.ict.campyou.hs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.hs.dao.HsDAO;
import com.ict.campyou.jun.dao.CampVO;

@Service
public class HsServiceImp implements HsService {
	@Autowired
	private HsDAO hsDAO;
	
	@Override
	public List<CampVO> getLocalKeyword() {
		return hsDAO.getLocalKeyword();
	}
}
