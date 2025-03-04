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
	
	//데이터베이스에 카카오 맴버 저장되어있나 확인. 없으면 데이터베이스에 insert 하기
	public int getInsertKakaoId(Map<String, String> map) {
		try {
			System.out.println(map.get(map));
			return sqlSessionTemplate.insert("member.insert_kakao_info_for_log_in", map);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//카카오 맴버 데이터베이스에 존재하나 체크
	public MemberVO getKakaoMemberById(Map<String, String> map) {
		try {
			return sqlSessionTemplate.selectOne("member.kakao_member_check", map);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
		
	//카카오 로그인 하기
	public MemberVO getKakaoLogInOk(Map<String, String> map) {
		try {
			return sqlSessionTemplate.selectOne("member.search_kakao_id_in_db", map);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
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
	
	//네이버 맴버 데이터베이스에 존재하나 체크
	public MemberVO getNaverMemberById(Map<String, String> map) {
		try {
			return sqlSessionTemplate.selectOne("member.naver_member_check", map);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	//네이버 로그인 하기
	public MemberVO getNaverLogInOk(Map<String, String> map) {
		try {
			return sqlSessionTemplate.selectOne("member.search_naver_id_in_db", map);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	//자유 게시판과 캠핑게시판 글쓸때 마다 member_free 등급 올리기
	public int getMemberFreeUpdate(String member_idx) {
		try {
			return sqlSessionTemplate.update("member.member_free_update", member_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	
	public int getUpdateMemberGrade(String member_idx) {
		return sqlSessionTemplate.update("member.member_grade_update", member_idx);
	}
	

	public int getUpdateMemberGrade2(String member_idx) {
		
		return sqlSessionTemplate.update("member.member_grade_update2", member_idx);
	}

	public int getUpdateMemberGrade3(String member_idx) {
		
		return sqlSessionTemplate.update("member.member_grade_update3", member_idx);
	}

	
	public int getUpdateMemberGrade4(String member_idx) {
		
		return sqlSessionTemplate.update("member.member_grade_update4", member_idx);
	}

	
	public int getUpdateMemberGrade5(String member_idx) {
		
		return sqlSessionTemplate.update("member.member_grade_update5", member_idx);
	}
	
	
	
	//맴버 디테일
	public MemberVO getMemeberDetail(String member_idx) {
		
		return sqlSessionTemplate.selectOne("member.member_detail", member_idx);
	}

	public int setUpdateSnsInfo(MemberVO vo) {
		return sqlSessionTemplate.update("member.setUpdateSnsInfo",vo);
	}

	public MemberVO getinfo(MemberVO vo) {
		System.out.println(vo.getMember_id()+"dao");
		System.out.println(vo.getMember_dob()+"dao");
		return sqlSessionTemplate.selectOne("member.getinfo",vo);
	}

	public int setUpdateSnsInfo_naver(MemberVO vo) {
		return sqlSessionTemplate.update("member.setUpdateSnsInfo_naver",vo);
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
}