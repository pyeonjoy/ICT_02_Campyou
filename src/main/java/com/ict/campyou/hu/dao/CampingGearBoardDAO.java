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
	
	public int getTotalCount() {
		try {
			return sqlSessionTemplate.selectOne("member.cgb_count");
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
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
	
	public int getCampingGearWriteInsert(CampingGearBoardVO cgbvo) {
		try {
			return sqlSessionTemplate.insert("member.camping_gear_write_insert", cgbvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	public int getCampingGearHit(String cp_idx) {
		try {
			return sqlSessionTemplate.update("member.camping_gear_hit", cp_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	public CampingGearBoardVO getCampingGearDetail(String cp_idx) {
		try {
			return sqlSessionTemplate.selectOne("member.camping_gear_detail", cp_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	public int getCampingGearUpdate(CampingGearBoardVO cgbvo) {
		try {
			return sqlSessionTemplate.update("member.camping_gear_update", cgbvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}

	public int getCampingGearDelete(CampingGearBoardVO cgbvo2) {
		try {
			return sqlSessionTemplate.delete("member.camping_gear_delete", cgbvo2);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	public int getCampingGearAdminDelete(String cp_idx) {
		try {
			return sqlSessionTemplate.delete("member.camping_gear_admin_delete", cp_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	public List<CampingGearBoardCommentVO> getCampingGearList2(String cp_idx) {
		try {
			return sqlSessionTemplate.selectList("member.camping_gear_comment_list", cp_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	public int getCampingGearCommentInsert(CampingGearBoardCommentVO cgbvo) {
		try {
			return sqlSessionTemplate.insert("member.camping_gear_comment_insert", cgbvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}

	public int getCampingGearCommentDelete(String cp_idx) {
		try {
			return sqlSessionTemplate.delete("member.camping_gear_comment_delete", cp_idx); 
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}

	public int getCampingGearBoardCommentUpdate(CampingGearBoardCommentVO cgbvo) {
		try {
			return sqlSessionTemplate.update("member.camping_gear_comment_update", cgbvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
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
	
	// 최대 권한 구하기
	public int getGrade(String member_idx) {
		return sqlSessionTemplate.selectOne("member.get_Gear_Grade", member_idx);
	}
	
	// 쵀대 권한으로 업데이트 하기
	public int getGradeUpdate(String member_idx2, int res) {
		Map<String,String> map = new HashMap<>();
		map.put("member_idx", member_idx2);
		map.put("res", String.valueOf(res));
		return sqlSessionTemplate.update("member.gear_Grade_Update", map);
	}
}