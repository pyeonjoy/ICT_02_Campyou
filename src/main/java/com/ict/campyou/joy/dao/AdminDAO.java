package com.ict.campyou.joy.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.campyou.hu.dao.CampingGearSearchVO;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.jun.dao.CampVO;

@Repository
public class AdminDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
// 관리자페이지 메인 ============================================================================================================================================================
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
	
	public List<AdminMemberVO> getboardall(String member_idx) {
		try {
			System.out.println("오나?"+member_idx);
			return sqlSessionTemplate.selectList("joy.boardall",member_idx);
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
	public int getreportall(String member_idx) {
		try {
			return sqlSessionTemplate.selectOne("joy.reportall",member_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	
//회원관리  ============================================================================================================================================================
	public List<AdminMemberVO> getradmineporteach(String member_idx) {
		try {
			return sqlSessionTemplate.selectList("joy.getradmineporteach",member_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	public List<AdminMemberVO> getradminstop(String member_idx) {
		try {
			return sqlSessionTemplate.selectList("joy.getradminstop",member_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
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
	public List<MemberVO> allmember(int offset, int limit) {
		try {
			Map<String, Integer> map = new HashMap<String, Integer>();
			System.out.println("offset"+offset);
			System.out.println("limit"+limit);
			map.put("offset", offset);
			map.put("limit", limit);
			return sqlSessionTemplate.selectList("joy.allmember",map);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	//팝업 
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
	public int getTotalCount2() {
		try {
			return sqlSessionTemplate.selectOne("joy.count2");	
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getTotalCount3() {
		try {
			return sqlSessionTemplate.selectOne("joy.count3");	
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getpopupdate(AdminVO avo) {
		try {
			return sqlSessionTemplate.update("joy.popupdate",avo);	
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getpopupdate2(AdminVO avo) {
		try {
			return sqlSessionTemplate.update("joy.popupdate2",avo);	
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

	public int getpopdelete(String popidx) {
		try {
			return sqlSessionTemplate.delete("joy.popdelete",popidx);	
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public String getPopmain() {
		try {
			return sqlSessionTemplate.selectOne("joy.popmain");	
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	public int getmainadminreport() {
		try {
			return sqlSessionTemplate.selectOne("joy.getmainadminreport");	
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	
	public int getadminreport(String report_day,String report_idx) {
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("report_day", report_day);
			map.put("report_idx", report_idx);
			return sqlSessionTemplate.update("joy.adminreport",map);	
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getadminreportadd(String report_day,String report_idx,String admin_idx,String reportmember_idx) {
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("report_day", report_day);
			map.put("report_idx", report_idx);
			map.put("admin_idx", admin_idx);
			map.put("reportmember_idx", reportmember_idx);
			return sqlSessionTemplate.update("joy.adminreportadd",map);	
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getadminreportadd2(String report_day,String report_idx,String admin_idx,String reportmember_idx) {
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("report_day", report_day);
			map.put("report_idx", report_idx);
			map.put("admin_idx", admin_idx);
			map.put("reportmember_idx",reportmember_idx);
			return sqlSessionTemplate.update("joy.adminreportadd2",map);	
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getadminreportadd3(String report_day,String report_idx,String admin_idx,String reportmember_idx) {
		try {
			Map<String, String> map = new HashMap<String, String>();
			map.put("report_day", report_day);
			map.put("report_idx", report_idx);
			map.put("admin_idx", admin_idx);
			map.put("reportmember_idx", reportmember_idx);
			return sqlSessionTemplate.update("joy.adminreportadd3",map);	
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getstatusupdate() {
		try {
			return sqlSessionTemplate.update("joy.statusupdate");	
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	
	public List<AdminMemberVO> getmemberSearch(String searchType, String keyword, int offset, int limit) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchType", searchType);
		map.put("keyword", keyword);
		map.put("offset", offset);
		map.put("limit", limit);
		System.out.println("offset"+ offset);
		System.out.println("limit"+ limit);
		return sqlSessionTemplate.selectList("joy.getmemberSearch", map);
	}
	public List<AdminMemberVO> getreportSearch(String searchType, String keyword, int offset, int limit) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchType", searchType);
		map.put("keyword", keyword);
		map.put("offset", offset);
		map.put("limit", limit);
		System.out.println("offset"+ offset);
		System.out.println("limit"+ limit);
		return sqlSessionTemplate.selectList("joy.getreportSearch", map);
	}
	
	public List<AdminMemberVO> allreport(int offset, int limit) {
		try {
			Map<String, Integer> map = new HashMap<String, Integer>();
			System.out.println("offset"+offset);
			System.out.println("limit"+limit);
			map.put("offset", offset);
			map.put("limit", limit);
			return sqlSessionTemplate.selectList("joy.allreport",map);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	
	public int getadminreportall(AdminMemberVO amvo) {
		try {
			return sqlSessionTemplate.insert("joy.reportallwrite",amvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getadminreportall2(AdminMemberVO amvo) {
		try {
			return sqlSessionTemplate.insert("joy.reportallwrite2",amvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getadminreportall3(AdminMemberVO amvo) {
		try {
			return sqlSessionTemplate.insert("joy.reportallwrite3",amvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	public int getadminreportall4(AdminMemberVO amvo) {
		try {
			return sqlSessionTemplate.insert("joy.reportallwrite4",amvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	
}
