package com.ict.campyou.jun.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Admin2DAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<Admin2VO> getUseFAQLoad(Admin2VO a2vo) {
		return sqlSessionTemplate.selectList("jun.getUseFAQLoad",a2vo);
	}

	public List<Admin2VO> getPromiseFAQLoad(Admin2VO a2vo) {
		return sqlSessionTemplate.selectList("jun.getPromiseFAQLoad",a2vo);
	}

	
	
	
}
