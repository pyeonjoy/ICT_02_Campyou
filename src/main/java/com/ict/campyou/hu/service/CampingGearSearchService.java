package com.ict.campyou.hu.service;

import java.util.List;
import com.ict.campyou.hu.dao.CampingGearSearchVO;

public interface CampingGearSearchService {
	public List<CampingGearSearchVO> getCampingGearSearchList();
	
	public List<CampingGearSearchVO> getCampingGearSearchListOk(String searchType, String searchValue);
	
	public List<CampingGearSearchVO> getCampingGearSearchList2(int offset, int limit);
}
