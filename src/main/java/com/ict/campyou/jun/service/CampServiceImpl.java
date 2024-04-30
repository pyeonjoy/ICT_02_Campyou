package com.ict.campyou.jun.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.jun.dao.CampDAO;
import com.ict.campyou.jun.dao.CampVO;

@Service
public class CampServiceImpl implements CampService{

	@Autowired
	private CampDAO campDAO;
	
	@Override
	public CampVO getCampInfo(CampVO cvo,String contentid) {
		return campDAO.getCampInfo(cvo,contentid);
	}


}
