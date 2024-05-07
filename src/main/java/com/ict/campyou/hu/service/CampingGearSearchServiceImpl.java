package com.ict.campyou.hu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.hu.dao.CampingGearSearchDAO;
import com.ict.campyou.hu.dao.CampingGearSearchVO;

@Service
public class CampingGearSearchServiceImpl implements CampingGearSearchService {
	@Autowired
	private CampingGearSearchDAO campingGearSearchDAO;

	@Override
	public List<CampingGearSearchVO> getCampingGearSearchList() {
		
		return campingGearSearchDAO.getCampingGearSearchList();
	}

	@Override
	public List<CampingGearSearchVO> getCampingGearSearchListOk(String searchType, String searchValue) {
		
		return campingGearSearchDAO.getCampingGearSearchListOk(searchType, searchValue);
	}
}
