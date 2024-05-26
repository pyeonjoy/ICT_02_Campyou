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
	
	// 최대 권한 구하기
	public int getGrade(String member_idx2);
	 
	// 쵀대 권한으로 업데이트 하기 
	public int getGradeUpdate(String member_idx2, int res);
	
	//관리자가 캠핑추천 게시판 회원 글 숨기기
	public int getCampingGearBoardContentHideUpdate(String cp_idx);
	
	//관리자가 캠핑추천 게시판 회원 글 보이게 하기
	public int getCampingGearBoardContentShowUpdate(String cp_idx);
}