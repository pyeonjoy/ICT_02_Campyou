package com.ict.campyou.hu.service;

import java.util.List;

import com.ict.campyou.hu.dao.CampingGearSearchVO;

public interface CampingGearSearchService {
	
	List<CampingGearSearchVO> getCampingGearSearchList();
	
	List<CampingGearSearchVO> getCampingGearSearchListOk(String searchType, String searchValue);
	
	//�Խ��� �� �˻� ���
	public List<CampingGearSearchVO> getCampingGearSearchList2(int offset, int limit);

}
