package com.ict.campyou.joy.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.campyou.jun.dao.CampVO;

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
			return sqlSessionTemplate.selectList("joy.adminmemberreport",member_idx);
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
	

	public int getmemberstop(String member_idx) {
		try {
			return sqlSessionTemplate.update("joy.memberstop",member_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getmemberstopcancel(String member_idx) {
		try {
			return sqlSessionTemplate.update("joy.memberstopcancel",member_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}

	public int getmemberedit(AdminMemberVO avo) {
		try {
			return sqlSessionTemplate.update("joy.memberedit",avo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getmemberdelete(String member_idx) {
		try {
			return sqlSessionTemplate.delete("joy.memberdelete",member_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getmemberupgrade(String member_idx) {
		try {
			return sqlSessionTemplate.update("joy.memberupgrade",member_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getremoveimg(String member_idx) {
		try {
			return sqlSessionTemplate.delete("joy.removeimg",member_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getPopUPWrite(AdminVO avo) {
		try {
			return sqlSessionTemplate.delete("joy.popUPWrite",avo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getTotalCount() {
		try {
		 return sqlSessionTemplate.selectOne("joy.count");	
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	
	public List<AdminVO> getPopList(int offset, int limit) {
		try {
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("offset", offset);
			map.put("limit", limit);
			return sqlSessionTemplate.selectList("joy.popUPlist",map);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
}
