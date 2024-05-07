package com.ict.campyou.hu.service;

import java.util.List;
import java.util.Map;

import com.ict.campyou.hu.dao.CampingGearBoardCommentVO;
import com.ict.campyou.hu.dao.CampingGearBoardVO;
import com.ict.campyou.hu.dao.CommentVO;

public interface CampingGearBoardService {
	
	// ķ�� ��õ �Խ��� ��ü �Խù� ��
	public int getTotalCount();
	
	//����Ʈ
	public List<CampingGearBoardVO> getCampingGearList(int offset, int limit);
	
	//ķ����õ�Խ��� �۾���
	public int getCampingGearWriteInsert(CampingGearBoardVO cgbvo);
	
	//��ȸ��
	public int getCampingGearHit(String cp_idx);
	
	//�Խ��� ȸ�� �󼼺���
	public CampingGearBoardVO getCampingGearDetail(String cp_idx);
	
	//�Խ��� ȸ�� ���� ������Ʈ
	public int getCampingGearUpdate(CampingGearBoardVO cgbvo);
	
	//�Խ��� ȸ���� ����
	public int getCampingGearDelete(CampingGearBoardVO cgbvo2);
	
	//������ ���� ����
	public int getCampingGearAdminDelete(String cp_idx);
	
	//��� ����Ʈ
	public List<CampingGearBoardCommentVO> getCampingGearList2(String cp_idx);
	
	// ��� ����
	public int getCampingGearCommentInsert(CampingGearBoardCommentVO cgbvo);
			 
	// ��� ����
	public int getCampingGearCommentDelete(String cp_idx);
		
	//��� ����
	public int getCampingGearCommentUpdate(CampingGearBoardCommentVO cgbvo);
	
	//��۴��
	public List<CampingGearBoardCommentVO> getCampingGearCommentReplyList(String cp_idx);
	
	//��� lev 
	public int getLevUpdate(Map<String, Integer> map);
	
	//���
	public int getAnsInsert(CampingGearBoardCommentVO cgbvo);
	
	//��۴�
	public CampingGearBoardCommentVO getCampingGearDetail2(String c_idx);
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
