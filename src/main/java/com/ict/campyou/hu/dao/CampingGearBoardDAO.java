package com.ict.campyou.hu.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CampingGearBoardDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	//전체 게시물수
	public int getTotalCount() {
		try {
			return sqlSessionTemplate.selectOne("member.cgb_count");
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//리스트
	public List<CampingGearBoardVO> getCampingGearList(int offset, int limit) {
		try {
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("offset", offset);
			map.put("limit", limit);
			return sqlSessionTemplate.selectList("member.cgb_list", map);		
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	//캠핑추천게시판 글쓰기
	public int getCampingGearWriteInsert(CampingGearBoardVO cgbvo) {
		try {
			return sqlSessionTemplate.insert("member.camping_gear_write_insert", cgbvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//게시판 조회수
	public int getCampingGearHit(String cp_idx) {
		try {
			return sqlSessionTemplate.update("member.camping_gear_hit", cp_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//게세판 회원 상세정보
	public CampingGearBoardVO getCampingGearDetail(String cp_idx) {
		try {
			return sqlSessionTemplate.selectOne("member.camping_gear_detail", cp_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	// 게시판 수정(업데이트)
	public int getCampingGearUpdate(CampingGearBoardVO cgbvo) {
		try {
			return sqlSessionTemplate.update("member.camping_gear_update", cgbvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//게시판 삭제
	public int getCampingGearDelete(CampingGearBoardVO cgbvo2) {
		try {
			return sqlSessionTemplate.delete("member.camping_gear_delete", cgbvo2);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//관리자 강제 삭제
	public int getCampingGearAdminDelete(String cp_idx) {
		try {
			return sqlSessionTemplate.delete("member.camping_gear_admin_delete", cp_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//댓글 가지고 오기
	public List<CampingGearBoardCommentVO> getCampingGearList2(String cp_idx) {
		try {
			return sqlSessionTemplate.selectList("member.camping_gear_comment_list", cp_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	//댓글 삽입
	public int getCampingGearCommentInsert(CampingGearBoardCommentVO cgbvo) {
		try {
			return sqlSessionTemplate.insert("member.camping_gear_comment_insert", cgbvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}

	//댓글 삭제
	public int getCampingGearCommentDelete(String cp_idx) {
		try {
			return sqlSessionTemplate.delete("member.camping_gear_comment_delete", cp_idx); 
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}

	//댓글 수정
	public int getCampingGearBoardCommentUpdate(CampingGearBoardCommentVO cgbvo) {
		try {
			return sqlSessionTemplate.update("member.camping_gear_comment_update", cgbvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//댓글댓글
	public List<CampingGearBoardCommentVO> getCampingGearCommentReplyList(String cp_idx) {
		try {
			return sqlSessionTemplate.selectList("member.camping_gear_comment_reply_list", cp_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	public int getLevUpdate(Map<String, Integer> map) {
		try {
			return sqlSessionTemplate.update("member.camping_gear_comm_lev_update", map);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}

	public int getAnsInsert(CampingGearBoardCommentVO cgbvo) {
		try {
			return sqlSessionTemplate.insert("member.camping_gear_ans_insert", cgbvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	
	
	public CampingGearBoardCommentVO getCampingGearDetail2(String c_idx) {
		
		return sqlSessionTemplate.selectOne("member.camping_gear_reply_detail", c_idx);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
