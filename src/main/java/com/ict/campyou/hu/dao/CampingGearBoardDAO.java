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
	
	//��ü �Խù���
	public int getTotalCount() {
		try {
			return sqlSessionTemplate.selectOne("member.cgb_count");
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//����Ʈ
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
	
	//ķ����õ�Խ��� �۾���
	public int getCampingGearWriteInsert(CampingGearBoardVO cgbvo) {
		try {
			return sqlSessionTemplate.insert("member.camping_gear_write_insert", cgbvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//�Խ��� ��ȸ��
	public int getCampingGearHit(String cp_idx) {
		try {
			return sqlSessionTemplate.update("member.camping_gear_hit", cp_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//�Լ��� ȸ�� ������
	public CampingGearBoardVO getCampingGearDetail(String cp_idx) {
		try {
			return sqlSessionTemplate.selectOne("member.camping_gear_detail", cp_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	// �Խ��� ����(������Ʈ)
	public int getCampingGearUpdate(CampingGearBoardVO cgbvo) {
		try {
			return sqlSessionTemplate.update("member.camping_gear_update", cgbvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//�Խ��� ����
	public int getCampingGearDelete(CampingGearBoardVO cgbvo2) {
		try {
			return sqlSessionTemplate.delete("member.camping_gear_delete", cgbvo2);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//������ ���� ����
	public int getCampingGearAdminDelete(String cp_idx) {
		try {
			return sqlSessionTemplate.delete("member.camping_gear_admin_delete", cp_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//��� ������ ����
	public List<CampingGearBoardCommentVO> getCampingGearList2(String cp_idx) {
		try {
			return sqlSessionTemplate.selectList("member.camping_gear_comment_list", cp_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	//��� ����
	public int getCampingGearCommentInsert(CampingGearBoardCommentVO cgbvo) {
		try {
			return sqlSessionTemplate.insert("member.camping_gear_comment_insert", cgbvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}

	//��� ����
	public int getCampingGearCommentDelete(String cp_idx) {
		try {
			return sqlSessionTemplate.delete("member.camping_gear_comment_delete", cp_idx); 
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}

	//��� ����
	public int getCampingGearBoardCommentUpdate(CampingGearBoardCommentVO cgbvo) {
		try {
			return sqlSessionTemplate.update("member.camping_gear_comment_update", cgbvo);
		} catch (Exception e) {
			System.out.println(e);
		}
		return 0;
	}
	
	//��۴��
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