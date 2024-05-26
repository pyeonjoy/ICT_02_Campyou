package com.ict.campyou.joy.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.campyou.bjs.dao.StarRatingVO;
import com.ict.campyou.hu.dao.MemberVO;
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
	public int addStar(StarRatingVO srvo) {
		try {
			int result = sqlSessionTemplate.insert("joy.addStar",srvo);
			if(result > 0) {
				return sqlSessionTemplate.update("joy.member_star_update", srvo);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	
}

	
