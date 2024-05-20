package com.ict.campyou.hu.dao;

import java.util.List;

import java.util.Map;

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
	
	// 회원가입 아이디 중복체크
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
	
	public List<CommentVO> getCommBoardList2(String b_idx) {
		try {
			return sqlSessionTemplate.selectList("member.commBoardList2", b_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	//데이터베이스에 카카오 맴버 저장되어있나 확인. 저장되어 있으면 불러오기
	public MemberVO getKakaoLogInOk(Map<String, String> map) {
		try {
			return sqlSessionTemplate.selectOne("member.search_kakao_id_in_db", map);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	//데이터베이스에 카카오 맴버 저장되어있나 확인. 없으면 데이터베이스에 insert 하기
	public int getInsertKakaoId(Map<String, String> map) {
		try {
			return sqlSessionTemplate.insert("member.insert_kakao_info_for_log_in", map);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//데이터베이스에 네이버 맴버 저장되어있나 확인. 없으면 데이터베이스에 insert 하기
		public int getInsertNaverId(Map<String, String> map) {
			try {
				return sqlSessionTemplate.insert("member.insert_naver_info_for_log_in", map);
			} catch (Exception e) {
				System.out.println(e);
			}
			return 0;
		}
	
	//데이터베이스에 네이버 맴버 저장되어있나 확인. 저장되어 있으면 불러오기
	public MemberVO getNaverLogInOk(Map<String, String> map) {
		try {
			return sqlSessionTemplate.selectOne("member.search_naver_id_in_db", map);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}	
}