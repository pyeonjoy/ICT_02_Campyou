package com.ict.campyou.bm.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.campyou.bjs.dao.TogetherCommentVO;
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
	try {
		return sqlSessionTemplate.selectOne("bomi.getPw",memberId);		
	} catch (Exception e) {
		System.out.println(e);
	}
	return null;
}

public MemberVO getMember(String member_idx) {
	try {
	
		return sqlSessionTemplate.selectOne("bomi.getUser",member_idx);
	} catch (Exception e) {
		System.out.println(e);
	}
	return null;
}
public int changeUserInfo(MemberVO mvo) {
	try {

		return sqlSessionTemplate.update("bomi.updateUser", mvo);		
	} catch (Exception e) {
		System.out.println(e);
	}
	return 0;
}
public int changeUserPW(MemberVO mvo) {
	try {
   	return sqlSessionTemplate.update("bomi.updatePw", mvo);
	} catch (Exception e) {
		System.out.println(e);
	}
	return 0;
}

public int uploadQna(QnaVO qvo) {
	try {	
		System.out.println("dao: "+qvo.getMember_idx());
		return sqlSessionTemplate.insert("bomi.upQna",qvo);
	} catch (Exception e) {
		System.out.println(e);
	}
	return 0;

}

public int updateQna(QnaVO qvo) {
	try {
		return sqlSessionTemplate.update("bomi.modiQna",qvo);
		
	} catch (Exception e) {
		System.out.println(e);
	}
	return 0;
}

public List<QnaVO> getMyQna(String member_idx) {
	try {
	
		return sqlSessionTemplate.selectList("bomi.getQnas",member_idx);
		
	} catch (Exception e) {
		System.out.println(e);
	}
	return null;
}

public int getTotalCount(String member_idx) {

	return sqlSessionTemplate.selectOne("bomi.count", member_idx);
}

public QnaVO getMyOneQna(String qna_idx) {
	try {
		
		return sqlSessionTemplate.selectOne("bomi.getOne",qna_idx);
		
	} catch (Exception e) {
		System.out.println(e);
	}
	return null;
}

public List<TogetherCommentVO> getMyAcc_List(String member_idx) {	
	try {
	return sqlSessionTemplate.selectList("bomi.getList", member_idx);
	}catch  (Exception e) {
		System.out.println(e);
	}
	return null;
}
public int deletMember(String member_idx) {
	try {
		return sqlSessionTemplate.delete("bomi.getDeleteUser",member_idx);
	
		}catch  (Exception e) {
			System.out.println(e);
		}
		return 0;
}

}