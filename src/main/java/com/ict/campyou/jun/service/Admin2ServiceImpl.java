package com.ict.campyou.jun.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.jun.dao.Admin2DAO;
import com.ict.campyou.jun.dao.Admin2VO;

@Service
public class Admin2ServiceImpl implements Admin2Service{

	@Autowired
	private Admin2DAO admin2DAO;
	
	
	@Override
	public List<Admin2VO> getUseFAQLoad(Admin2VO a2vo) {
		return admin2DAO.getUseFAQLoad(a2vo);
	}


	@Override
	public List<Admin2VO> getPromiseFAQLoad(Admin2VO a2vo) {
		return admin2DAO.getPromiseFAQLoad(a2vo);
	}

}
