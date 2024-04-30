package com.ict.campyou.joy.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<AdminVO> getadminmainmember() {
		try {
			return sqlSessionTemplate.selectList("joy.getMemberCounts");
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	public List<AdminVO> getadminboard() {
		try {
			return sqlSessionTemplate.selectList("joy.boardmix");
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	public int getadminqna() {
		try {
			return sqlSessionTemplate.selectOne("joy.adminmainqna");
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getadminreport() {
		try {
			return sqlSessionTemplate.selectOne("joy.adminmainreport");
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getadminmatch() {
		try {
			return sqlSessionTemplate.selectOne("joy.adminmainmatch");
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	
	public List<AdminMemberVO> getboardall() {
		try {
			return sqlSessionTemplate.selectList("joy.boardall");
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	public List<AdminMemberVO> getadminmemberreport(String member_idx) {
		try {
			return sqlSessionTemplate.selectList("joy.adminmemberreport");
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
		
		
	}
	public int getreportall() {
		try {
			return sqlSessionTemplate.selectOne("joy.reportall");
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	
	public List<AdminMemberVO> getmember(AdminMemberVO amvo) {
		try {
			return sqlSessionTemplate.selectList("joy.getmember");
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

	public int getmemberstop(String member_idx) {
		try {
			return sqlSessionTemplate.update("joy.memberstop");
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}

	public int getmemberedit(String member_idx) {
		try {
			return sqlSessionTemplate.update("joy.memberedit");
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getmemberdelete(String member_idx) {
		try {
			return sqlSessionTemplate.delete("joy.memberdelete");
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
}
