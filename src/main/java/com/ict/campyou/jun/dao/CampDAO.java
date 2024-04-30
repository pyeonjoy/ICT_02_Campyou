package com.ict.campyou.jun.dao;

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
	
	
}
