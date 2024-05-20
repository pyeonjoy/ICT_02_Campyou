package com.ict.campyou.hu.dao;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminMembDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	//관리자 페이지 페이지수 카운트
	public int getTotalCount() {
		try {
			return sqlSessionTemplate.selectOne("member.admin_page_count");
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//관리자 가입
	public int getAdminSignUp(AdminMembVO admvo) {
		try {
			return sqlSessionTemplate.insert("member.admin_insert", admvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//관리자 로그인
	public AdminMembVO getAdminLogInOK(AdminMembVO admvo) {
		try {
			return sqlSessionTemplate.selectOne("member.admin_login", admvo);
		}catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	// 관리자 가입 아이디 중복체크
	public String getAdminIdChk(String admin_id) {
		try {
			 int result = sqlSessionTemplate.selectOne("member.adminidchk", admin_id);
			 if(result > 0) {
			  	return "0";
			  }
			  return "1" ;
		} catch (Exception e) {
				System.out.println(e);
		}
		return null;
	}
	
	// 관리자 리스트
	public List<AdminMembVO> getAdminList(int offset, int limit) {
		try {
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("offset", offset);
			map.put("limit", limit);
			return sqlSessionTemplate.selectList("member.admin_list", map);		
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	//관리자 권한 주기 업데이트
	public int getGiveAdminPermissionUpdate(AdminMembVO admvo) {
		try {
			return sqlSessionTemplate.update("member.give_admin_permission_update", admvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//관리자 권한 빼앗기 업데이트
	public int getRevokeAdminPermissionUpdate(AdminMembVO admvo) {
		try {
			return sqlSessionTemplate.update("member.revoke_admin_permission_update", admvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//슈퍼관리자가 부하관리자 강제삭제
	public int getAssistantAdminDelete(String admin_idx) {
		try {
			return sqlSessionTemplate.update("member.assistant_admin_delete", admin_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//관리자 정보 가지고 오기
	public AdminMembVO getAdminInfoDetail(String admin_idx) {
		try {
			return sqlSessionTemplate.selectOne("member.admin_info_update", admin_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	//관리자 정보수정
	public int getAdminUpdateOk(AdminMembVO admvo) {
		try {
			return sqlSessionTemplate.update("member.admin_update_ok", admvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}	
}