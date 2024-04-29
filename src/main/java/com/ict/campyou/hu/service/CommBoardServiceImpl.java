package com.ict.campyou.hu.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.hu.dao.CommBoardDAO;
import com.ict.campyou.hu.dao.CommBoardVO;

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
	public int getLevUpdate(Map<String, Integer> map) {
		return commBoardDAO.getLevUpdate(map);
	}

	@Override
	public int getReplyInsert(CommBoardVO cbvo) {
		return commBoardDAO.getReplyInsert(cbvo);
	}

	@Override
	public CommBoardVO getCommBoardReplyDetail(CommBoardVO cbvo) {
		return commBoardDAO.getCommBoardReplyDetail(cbvo);
	}
}