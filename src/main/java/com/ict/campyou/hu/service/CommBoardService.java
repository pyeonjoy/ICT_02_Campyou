package com.ict.campyou.hu.service;

import java.util.List;
import java.util.Map;

import com.ict.campyou.hu.dao.CommBoardVO;

public interface CommBoardService {
	public int getTotalCount();
	
	public List<CommBoardVO> getCommBoardList(int offset, int limit);
	
	public int getCommBoardInsert(CommBoardVO cbvo);
	
	public int getCommBoardHit(String b_idx);
	
	public CommBoardVO getCommBoardDetail(String b_idx);
	
	public int getCommBoardDelete(CommBoardVO cbvo2);
	
	public int getCommBoardUpdate(CommBoardVO cbvo);
	
	public int getLevUpdate(Map<String, Integer> map);
	
	public int getReplyInsert(CommBoardVO cbvo);
	
	public CommBoardVO getCommBoardReplyDetail(CommBoardVO cbvo);
}
