package com.ict.campyou.hu.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CampingGearSearchDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<CampingGearSearchVO> getCampingGearSearchList() {
		
		return sqlSessionTemplate.selectList("member.camping_gear_search_list");
	}
	
	public List<CampingGearSearchVO> getCampingGearSearchListOk(String searchType, String searchValue) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("searchType", searchType);
		map.put("searchValue", searchValue);
		
		return sqlSessionTemplate.selectList("member.camping_gear_search_list_ok", map);
	}
}
