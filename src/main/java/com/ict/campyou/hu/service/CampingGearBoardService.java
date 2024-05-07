package com.ict.campyou.hu.service;

import java.util.List;
import java.util.Map;

import com.ict.campyou.hu.dao.CampingGearBoardCommentVO;
import com.ict.campyou.hu.dao.CampingGearBoardVO;
import com.ict.campyou.hu.dao.CommentVO;

public interface CampingGearBoardService {
	
	// 캠핑 추천 게시판 전체 게시물 수
	public int getTotalCount();
	
	//리스트
	public List<CampingGearBoardVO> getCampingGearList(int offset, int limit);
	
	//캠핑추천게시판 글쓰기
	public int getCampingGearWriteInsert(CampingGearBoardVO cgbvo);
	
	//조회수
	public int getCampingGearHit(String cp_idx);
	
	//게시판 회원 상세보기
	public CampingGearBoardVO getCampingGearDetail(String cp_idx);
	
	//게시판 회원 정보 업데이트
	public int getCampingGearUpdate(CampingGearBoardVO cgbvo);
	
	//게시판 회원글 삭제
	public int getCampingGearDelete(CampingGearBoardVO cgbvo2);
	
	//관리자 강제 삭제
	public int getCampingGearAdminDelete(String cp_idx);
	
	//댓글 리스트
	public List<CampingGearBoardCommentVO> getCampingGearList2(String cp_idx);
	
	// 댓글 삽입
	public int getCampingGearCommentInsert(CampingGearBoardCommentVO cgbvo);
			 
	// 댓글 삭제
	public int getCampingGearCommentDelete(String cp_idx);
		
	//댓글 수정
	public int getCampingGearCommentUpdate(CampingGearBoardCommentVO cgbvo);
	
	//댓글댓글
	public List<CampingGearBoardCommentVO> getCampingGearCommentReplyList(String cp_idx);
	
	//댓글 lev 
	public int getLevUpdate(Map<String, Integer> map);
	
	//댓글
	public int getAnsInsert(CampingGearBoardCommentVO cgbvo);
	
	//댓글댓굴
	public CampingGearBoardCommentVO getCampingGearDetail2(String c_idx);
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
