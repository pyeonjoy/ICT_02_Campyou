package com.ict.campyou.jun.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public int addReview(ReviewVO rvo) {
		try {
			return sqlSessionTemplate.insert("jun.addReview", rvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}

	public List<ReviewVO> loadReview(String contentid) {
	    try {
	        return sqlSessionTemplate.selectList("jun.loadReview", contentid);
	    } catch (Exception e) {
	        System.out.println(e);
	    }
	    return null;
	}

	
	
}
