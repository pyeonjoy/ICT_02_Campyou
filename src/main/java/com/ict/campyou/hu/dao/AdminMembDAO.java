package com.ict.campyou.hu.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminMembDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
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
}
