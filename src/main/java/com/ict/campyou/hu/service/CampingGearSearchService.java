package com.ict.campyou.hu.service;

import java.util.List;

import com.ict.campyou.hu.dao.CampingGearSearchVO;

public interface CampingGearSearchService {
	
	List<CampingGearSearchVO> getCampingGearSearchList();
	
	List<CampingGearSearchVO> getCampingGearSearchListOk(String searchType, String searchValue);
	
	//게시판 내 검색 기능
	public List<CampingGearSearchVO> getCampingGearSearchList2(int offset, int limit);

}
