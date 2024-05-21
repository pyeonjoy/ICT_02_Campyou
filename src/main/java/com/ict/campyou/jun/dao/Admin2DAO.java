package com.ict.campyou.jun.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Admin2DAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<Admin2VO> getUseFAQLoad(Admin2VO a2vo,int offset, int limit) {
		Map<String, Object> map = new HashMap<>();
		map.put("a2vo",a2vo);
		map.put("offset",offset);
		map.put("limit",limit);
		return sqlSessionTemplate.selectList("jun.getUseFAQLoad",map);
	}

	public List<Admin2VO> getPromiseFAQLoad(Admin2VO a2vo,int offset, int limit) {
		Map<String, Object> map = new HashMap<>();
		map.put("a2vo",a2vo);
		map.put("offset",offset);
		map.put("limit",limit);
		return sqlSessionTemplate.selectList("jun.getPromiseFAQLoad",map);
	}

	public int writeUserFAQ(Admin2VO a2vo) {
		return sqlSessionTemplate.insert("jun.writeUserFAQ",a2vo);
	}

	public int writePromiseFAQ(Admin2VO a2vo) {
		return sqlSessionTemplate.insert("jun.writePromiseFAQ",a2vo);
	}

	public int StatusUserChange(List<Integer> faq_idx) {
		return sqlSessionTemplate.update("jun.StatusUserChange",faq_idx);
	}

	public int StatusPromiseChange(List<Integer> faq_idx) {
		return sqlSessionTemplate.update("jun.StatusPromiseChange",faq_idx);
	}

	public int getUseFAQCount(Admin2VO a2vo) {
		return sqlSessionTemplate.selectOne("jun.getUseFAQCount",a2vo);
	}

	public int getPromiseFAQCount(Admin2VO a2vo) {
		return sqlSessionTemplate.selectOne("jun.getPromiseFAQCount",a2vo);
	}

	
	
	
}
