package com.ict.campyou.hu.service;

import java.util.Map;

import com.ict.campyou.hu.dao.CommentVO;

public interface CommentReplyService {
	public CommentVO getCommentReplyDetail(String b_idx);
	
	public int getLevUpdate(Map<String, Integer> map);
	
	public int getAnsInsert(CommentVO cvo3);
	
	public int getCommentReplyInsert(CommentVO cvo);
}
