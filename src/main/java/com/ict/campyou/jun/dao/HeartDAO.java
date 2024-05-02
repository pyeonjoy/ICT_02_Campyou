package com.ict.campyou.jun.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class HeartDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public int addHeart(String contentid,String member_idx) {
		try {
			Map<String, String> map = new HashMap<>();
			map.put("contentid", contentid);
			map.put("member_idx", member_idx);
			return sqlSessionTemplate.insert("jun.addHeart", map);          
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
		
	}

	public String checkHeart(String contentid, String member_idx) {
			Map<String, String> map = new HashMap<>();
			map.put("contentid", contentid);
			map.put("member_idx", member_idx);
			return sqlSessionTemplate.selectOne("jun.checkHeart",map);
	}
	
}
