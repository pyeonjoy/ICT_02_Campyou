package com.ict.campyou.hs.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.campyou.jun.dao.CampVO;

@Repository
public class HsDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<CampVO> getLocalKeyword() throws Exception {
		return sqlSessionTemplate.selectList("has.local_keyword");
	}

}