package com.ict.campyou.bjs.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TogetherDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int getToTotalCount() throws Exception{
		return sqlSessionTemplate.selectOne("bjs.count");
	}
	
	public List<TogetherVO> getTogetherList(int offset, int limit) throws Exception {
		Map<String, Integer> map = new HashMap<String, Integer>();  
		map.put("offset", offset);
		map.put("limit", limit);
		return sqlSessionTemplate.selectList("bjs.to_list", map);
	}
}
