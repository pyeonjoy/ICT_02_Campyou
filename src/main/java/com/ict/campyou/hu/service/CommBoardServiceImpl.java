package com.ict.campyou.hu.service;

import java.util.List;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.hu.dao.CommBoardDAO;
import com.ict.campyou.hu.dao.CommBoardVO;
import com.ict.campyou.hu.dao.CommentVO;
import com.ict.campyou.hu.dao.MemberVO;

@Service
public class CommBoardServiceImpl implements CommBoardService {
	@Autowired
	private CommBoardDAO commBoardDAO;

	@Override
	public int getTotalCount() {
		return commBoardDAO.getTotalCount();
	}

	@Override
	public List<CommBoardVO> getCommBoardList(int offset, int limit) {
		return commBoardDAO.getCommBoardList(offset, limit);
	}

	@Override
	public int getCommBoardInsert(CommBoardVO cbvo) {
		return commBoardDAO.getCommBoardInsert(cbvo);
	}

	@Override
	public int getCommBoardHit(String b_idx) {
		return commBoardDAO.getCommBoardHit(b_idx);
	}

	@Override
	public CommBoardVO getCommBoardDetail(String b_idx) {
		return commBoardDAO.getCommBoardDetail(b_idx);
	}

	@Override
	public int getCommBoardDelete(CommBoardVO cbvo2) {
		return commBoardDAO.getCommBoardDelete(cbvo2);
	}

	@Override
	public int getCommBoardUpdate(CommBoardVO cbvo) {
		return commBoardDAO.getCommBoardUpdate(cbvo);
	}

	@Override
	public int getReplyInsert(CommBoardVO cbvo) {
		return commBoardDAO.getReplyInsert(cbvo);
	}

	@Override
	public CommBoardVO getCommBoardReplyDetail(CommBoardVO cbvo) {
		return commBoardDAO.getCommBoardReplyDetail(cbvo);
	}

	@Override
	public List<CommentVO> getCommBoardList2(String b_idx) {
		return commBoardDAO.getCommBoardList2(b_idx);
	}
	
	@Override
	public int getCommentInsert(CommentVO cvo) {
		return commBoardDAO.getCommentInsert(cvo);
	}

	@Override
	public int getCommentDelete(String c_idx) {
		return commBoardDAO.getCommentDelete(c_idx);
	}

	@Override
	public int getCommentUpdate(CommentVO cvo) {
		return commBoardDAO.getCommentUpdate(cvo);
	}

	@Override
	public int getCommBoardAdminDelete(String b_idx) {
		return commBoardDAO.getCommBoardAdminDelete(b_idx);
	}

	@Override
	public List<CommentVO> getCommentReplyList(String b_idx) {
		return commBoardDAO.getCommentReplyList(b_idx);
	}

	@Override
	public int getLevUpdate(Map<String, Integer> map) {
		return commBoardDAO.getLevUpdate(map);
	}

	@Override
	public int getAnsInsert(CommentVO cvo) {
		return commBoardDAO.getAnsInsert(cvo);
	}

	@Override
	public CommentVO getCommentReplyDetail(String c_idx) {
		return commBoardDAO.getCommentReplyDetail(c_idx);
	}
	
	// 최대 권한 구하기
	@Override
	public int getGread(String member_idx2) {
		return commBoardDAO.getGread(member_idx2);
	}
	
	// 쵀대 권한으로 업데이트 하기
	@Override
	public int getGreadUpdate(String member_idx2, int res) {
		return commBoardDAO.getGreadUpdate(member_idx2, res);
	}
	
	
	
	
	
	
	
	
	
	

	@Override
	public int getCommunityBoardContentHideUpdate(String b_idx) {
		// TODO Auto-generated method stub
		return commBoardDAO.getCommunityBoardContentHideUpdate(b_idx);
	}

	@Override
	public int getCommunityBoardContentShowUpdate(String b_idx) {
		// TODO Auto-generated method stub
		return commBoardDAO.getCommunityBoardContentShowUpdate(b_idx);
	}	
}