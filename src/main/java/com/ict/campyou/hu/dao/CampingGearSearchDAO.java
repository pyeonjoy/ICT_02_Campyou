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
		try {
			return sqlSessionTemplate.selectList("member.camping_gear_search_list");
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	public List<CampingGearSearchVO> getCampingGearSearchListOk(String searchType, String searchValue) {
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("searchType", searchType);
			map.put("searchValue", searchValue);
			return sqlSessionTemplate.selectList("member.camping_gear_search_list_ok", map);
			
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	public List<CampingGearSearchVO> getCampingGearSearchList2(int offset, int limit) {
		try {
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("offset", offset);
			map.put("limit", limit);
			return sqlSessionTemplate.selectList("member.camping_board_search_list2", map);		
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
}