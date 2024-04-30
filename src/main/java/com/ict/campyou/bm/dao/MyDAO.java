package com.ict.campyou.bm.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.campyou.hu.dao.MemberVO;

@Repository
public class MyDAO {
@Autowired
private SqlSessionTemplate sqlSessionTemplate;

public List<FaqVO> getFaqs() {
	try {
		return sqlSessionTemplate.selectList("bomi.faq_lists");		
	} catch (Exception e) {
		System.out.println(e);
	}
	return null;
}
public List<FaqVO> getFaqs2() {
	try {
		return sqlSessionTemplate.selectList("bomi.faq_lists2");		
	} catch (Exception e) {
		System.out.println(e);
	}
	return null;
}
public MemberVO getMemberPwd(String memberId) {		
	return sqlSessionTemplate.selectOne("bomi.getUser",memberId);
}
}
