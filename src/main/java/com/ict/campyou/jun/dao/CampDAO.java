package com.ict.campyou.jun.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CampDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public CampVO getCampInfo(CampVO cvo,String contentid) {
		return sqlSessionTemplate.selectOne("jun.getCampInfo",contentid);
	}

	public int updateHit(String contentid) {
		return sqlSessionTemplate.update("jun.updateHit",contentid);
	}

	public List<CampVO> searchCampDetail(String keyword, String lctCl, String induty, String sbrscl,int offset, int limit,String s_sido,String s_sigungu) {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("keyword", keyword);
			map.put("lctCl", lctCl);
			map.put("induty", induty);
			map.put("sbrscl", sbrscl);
			map.put("offset",offset);
			map.put("limit",limit);
			map.put("s_sido",s_sido);
			map.put("s_sigungu",s_sigungu);
			return sqlSessionTemplate.selectList("jun.searchDetail",map);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

	public int searchCount(String keyword, String lctCl, String induty, String sbrscl,String s_sido,String s_sigungu) {
		try {
			Map<String, String> map = new HashMap<>();
			map.put("keyword", keyword);
			map.put("lctCl", lctCl);
			map.put("induty", induty);
			map.put("sbrscl", sbrscl);
			map.put("s_sido",s_sido);
			map.put("s_sigungu",s_sigungu);
			return sqlSessionTemplate.selectOne("jun.searchCount",map);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}

	public int countReview(String contentid) {
		return sqlSessionTemplate.selectOne("jun.countReview",contentid);
	}

	public int addRating(String contentid) {
		return sqlSessionTemplate.selectOne("jun.addRating",contentid);
	}
	
	
}
