package com.ict.campyou.hu.dao;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardFreeDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<BoardFreeVO> getBoardFreeList() {
		return sqlSessionTemplate.selectList("member.board_free_list");
	}
	
	public List<BoardFreeVO> getBoardFreeSearchList(String searchType, String searchValue) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("searchType", searchType);
		map.put("searchValue", searchValue);
		
		return sqlSessionTemplate.selectList("member.board_free_search_list", map);
	}
}
