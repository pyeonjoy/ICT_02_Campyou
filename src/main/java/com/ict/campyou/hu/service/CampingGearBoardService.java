package com.ict.campyou.hu.service;

import java.util.List;

import java.util.Map;

import com.ict.campyou.hu.dao.CampingGearBoardCommentVO;
import com.ict.campyou.hu.dao.CampingGearBoardVO;

public interface CampingGearBoardService {
	
	public int getTotalCount();
	
	public List<CampingGearBoardVO> getCampingGearList(int offset, int limit);
	
	public int getCampingGearWriteInsert(CampingGearBoardVO cgbvo);
	
	public int getCampingGearHit(String cp_idx);
	
	public CampingGearBoardVO getCampingGearDetail(String cp_idx);
	
	public int getCampingGearUpdate(CampingGearBoardVO cgbvo);
	
	public int getCampingGearDelete(CampingGearBoardVO cgbvo2);
	
	public int getCampingGearAdminDelete(String cp_idx);
	
	public List<CampingGearBoardCommentVO> getCampingGearList2(String cp_idx);
	
	public int getCampingGearCommentInsert(CampingGearBoardCommentVO cgbvo);
			 
	public int getCampingGearCommentDelete(String cp_idx);
		
	public int getCampingGearCommentUpdate(CampingGearBoardCommentVO cgbvo);
	
	public List<CampingGearBoardCommentVO> getCampingGearCommentReplyList(String cp_idx);
	
	public int getLevUpdate(Map<String, Integer> map);
	
	public int getAnsInsert(CampingGearBoardCommentVO cgbvo);
	
	public CampingGearBoardCommentVO getCampingGearDetail2(String c_idx);
}