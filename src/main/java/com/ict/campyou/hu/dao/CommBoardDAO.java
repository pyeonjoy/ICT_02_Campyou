package com.ict.campyou.hu.dao;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CommBoardDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int getTotalCount() {
		try {
			return sqlSessionTemplate.selectOne("member.count");
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	public List<CommBoardVO> getCommBoardList(int offset, int limit) {
		try {
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("offset", offset);
			map.put("limit", limit);
			return sqlSessionTemplate.selectList("member.comm_board_list", map);		
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	public int getCommBoardInsert(CommBoardVO cbvo) {
		try {
			return sqlSessionTemplate.insert("member.comm_board_insert", cbvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	public int getCommBoardHit(String b_idx) {
		try {
			return sqlSessionTemplate.update("member.comm_board_hit", b_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	public CommBoardVO getCommBoardDetail(String b_idx) {
		try {
			return sqlSessionTemplate.selectOne("member.comm_board_detail", b_idx);
		}catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

	public int getCommBoardDelete(CommBoardVO cbvo2) {
		try {
			return sqlSessionTemplate.delete("member.comm_board_delete", cbvo2);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	public int getCommBoardUpdate(CommBoardVO cbvo) {
		try {
			return sqlSessionTemplate.update("member.comm_board_update", cbvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	public int getLevUpdate(Map<String, Integer> map) {
		try {
			return sqlSessionTemplate.update("member.comm_lev_update", map);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	
	public int getReplyInsert(CommBoardVO cbvo) {
		try {
			return sqlSessionTemplate.insert("member.comm_reply_insert", cbvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	public CommBoardVO getCommBoardReplyDetail(CommBoardVO cbvo) {
		try {
			return sqlSessionTemplate.selectOne("member.comm_board_reply_detail", cbvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return cbvo;
	}
	
	public List<CommentVO> getCommBoardList2(String b_idx) {
		try {
			return sqlSessionTemplate.selectList("member.comment_list", b_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	public int getCommentInsert(CommentVO cvo) {
		try {
			return sqlSessionTemplate.insert("member.comment_insert", cvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}

	public int getCommentDelete(String c_idx) {
		try {
			return sqlSessionTemplate.delete("member.comment_delete", c_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	
	public int getCommentUpdate(CommentVO cvo) {
		try {
			return sqlSessionTemplate.update("member.comment_update", cvo);

		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	public int getCommBoardAdminDelete(String b_idx) {
		try {
			return sqlSessionTemplate.delete("member.comm_board_admin_delete", b_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	public List<CommentVO> getCommentReplyList(String b_idx) {
		try {
			return sqlSessionTemplate.selectList("member.comment_reply_list", b_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	public int getAnsInsert(CommentVO cvo) {
		try {
			return sqlSessionTemplate.insert("member.ans_insert1", cvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return -1;
	}
	
	public CommentVO getCommentReplyDetail(String c_idx) {
		try {
			return sqlSessionTemplate.selectOne("member.commet_reply_detail", c_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	// 회원 최대 등급 구하기
	public int getMemberGrade(String member_idx) {
		return sqlSessionTemplate.selectOne("member.get_member_grade", member_idx);
	}

	// 쵀대 등급으로 업데이트 하기 
	public int getGreadUpdate(String member_idx2, int res) {
		Map<String,String> map = new HashMap<>();
		map.put("member_idx", member_idx2);
		map.put("res", String.valueOf(res));
		return sqlSessionTemplate.update("member.get_member_grade_update", map);
	}
	
	
	
	
	
	
	
	public int getCommunityBoardContentHideUpdate(String b_idx) {
		
		return sqlSessionTemplate.update("member.community_board_content_hide_update", b_idx);
		
	}
	
	public int getCommunityBoardContentShowUpdate(String b_idx) {
		
		return sqlSessionTemplate.update("member.community_board_content_show_update", b_idx);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}