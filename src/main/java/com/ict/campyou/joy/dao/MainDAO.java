package com.ict.campyou.joy.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.campyou.jun.dao.CampVO;

@Repository
public class MainDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<AdminVO> getwithboard() {
		try {
			return sqlSessionTemplate.selectList("joy.getwithboard");
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

	public List<CampVO> getcamphit() {
		try {
			return sqlSessionTemplate.selectList("joy.camphit");
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	public int getreportwriteok(AdminVO avo) {
		try {
			
			return sqlSessionTemplate.insert("joy.reportwriteok",avo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getStart(MemberVO mvo) {
		try {
			return sqlSessionTemplate.update("joy.getstar",mvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	
}

	
