package com.ict.campyou.hu.service;

import java.util.List;

import java.util.Map;

import com.ict.campyou.hu.dao.CommBoardVO;
import com.ict.campyou.hu.dao.CommentVO;
import com.ict.campyou.hu.dao.MemberVO;

public interface CommBoardService {
	public int getTotalCount();
	
	public List<CommBoardVO> getCommBoardList(int offset, int limit);
	
	public int getCommBoardInsert(CommBoardVO cbvo);
	
	public int getCommBoardHit(String b_idx);
	
	public CommBoardVO getCommBoardDetail(String b_idx);
	
	public int getCommBoardDelete(CommBoardVO cbvo2);
	
	public int getCommBoardUpdate(CommBoardVO cbvo);
	
	public int getReplyInsert(CommBoardVO cbvo);
	
	public CommBoardVO getCommBoardReplyDetail(CommBoardVO cbvo);

	public List<CommentVO> getCommBoardList2(String b_idx);
	
	public int getCommentInsert(CommentVO cvo);
		 
	public int getCommentDelete(String c_idx);
	
	public int getCommentUpdate(CommentVO cvo);
	
	public int getCommBoardAdminDelete(String b_idx);
	
	public List<CommentVO> getCommentReplyList(String b_idx);
	
	public int getLevUpdate(Map<String, Integer> map);
	
	public int getAnsInsert(CommentVO cvo);
	
	public CommentVO getCommentReplyDetail(String c_idx);
	
	// 최대 권한 구하기
	public int getGread(String member_idx2);
	
	// 쵀대 권한으로 업데이트 하기 
	public  int getGreadUpdate(String member_idx2, int res);
	
	
	
	
	public int getCommunityBoardContentHideUpdate(String b_idx);
	public int getCommunityBoardContentShowUpdate(String b_idx);
	
	 
	
	
	
	
}