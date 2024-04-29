package com.ict.campyou.hu.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int getSignUp(MemberVO vo) {
		try {
			return sqlSessionTemplate.insert("member.insert", vo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	public String getIdChk(String member_id) {
		try {
		  	int result = sqlSessionTemplate.selectOne("member.idchk", member_id);
		  	if(result > 0) {
		  		return "0";
		  	}
		  	return "1" ;
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	// login Id Check
	public String getLogInIdChk(String member_id) {
		try {
		  	int result = sqlSessionTemplate.selectOne("member.loginIdchk", member_id);
		  	if(result > 0) {
		  		return "0";
		  	}
		  	return "1" ;
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	public MemberVO getLogInOK(MemberVO vo) {
		try {
			return sqlSessionTemplate.selectOne("member.login", vo);
		}catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	public MemberVO getMyPwd(MemberVO mvo2) {
		try {
			return sqlSessionTemplate.selectOne("member.findPwd", mvo2);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	public int getTempPwdUpdate(MemberVO mvo) {
		try {
			return sqlSessionTemplate.update("member.tempPwdUpdate", mvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	public MemberVO getMyID(String member_name) {
		try {
			return sqlSessionTemplate.selectOne("member.findId", member_name);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	public String getNickNameChk(String member_nickname) {
		try {
		  	int result = sqlSessionTemplate.selectOne("member.nickNameChk", member_nickname);
		  	if(result > 0) {
		  		return "0";
		  	}
		  	return "1" ;
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
}