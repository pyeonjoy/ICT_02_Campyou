package com.ict.campyou.hu.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.hu.dao.CommentReplyDAO;
import com.ict.campyou.hu.dao.CommentVO;

@Service
public class CommentReplyServiceImpl implements CommentReplyService {
	@Autowired
	private CommentReplyDAO commentReplyDAO;

	@Override
	public CommentVO getCommentReplyDetail(String b_idx) {
		return commentReplyDAO.getCommentReplyDetail(b_idx);
	}

	@Override
	public int getLevUpdate(Map<String, Integer> map) {
		return commentReplyDAO.getLevUpdate(map);
	}

	@Override
	public int getAnsInsert(CommentVO cvo3) {
		return commentReplyDAO.getAnsInsert(cvo3);
	}

	@Override
	public int getCommentReplyInsert(CommentVO cvo) {
		return commentReplyDAO.getCommentReplyInsert(cvo);
	}
}
