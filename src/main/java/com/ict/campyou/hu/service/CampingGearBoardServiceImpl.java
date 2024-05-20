package com.ict.campyou.hu.service;

import java.util.List;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.hu.dao.CampingGearBoardCommentVO;
import com.ict.campyou.hu.dao.CampingGearBoardDAO;
import com.ict.campyou.hu.dao.CampingGearBoardVO;

@Service
public class CampingGearBoardServiceImpl implements CampingGearBoardService {
	
	@Autowired
	private CampingGearBoardDAO campingGearBoardDAO;

	@Override
	public int getTotalCount() {
		return campingGearBoardDAO.getTotalCount();
	}

	@Override
	public List<CampingGearBoardVO> getCampingGearList(int offset, int limit) {
		return campingGearBoardDAO.getCampingGearList(offset, limit);
	}

	@Override
	public int getCampingGearWriteInsert(CampingGearBoardVO cgbvo) {
		return campingGearBoardDAO.getCampingGearWriteInsert(cgbvo);
	}

	@Override
	public int getCampingGearHit(String cp_idx) {
		return campingGearBoardDAO.getCampingGearHit(cp_idx);
	}

	@Override
	public CampingGearBoardVO getCampingGearDetail(String cp_idx) {
		return campingGearBoardDAO.getCampingGearDetail(cp_idx);
	}

	@Override
	public int getCampingGearUpdate(CampingGearBoardVO cgbvo) {
		return campingGearBoardDAO.getCampingGearUpdate(cgbvo);
	}
	
	@Override
	public int getCampingGearDelete(CampingGearBoardVO cgbvo2) {
		return campingGearBoardDAO.getCampingGearDelete(cgbvo2);
	}

	@Override
	public List<CampingGearBoardCommentVO> getCampingGearList2(String cp_idx) {
		return campingGearBoardDAO.getCampingGearList2(cp_idx);
	}

	@Override
	public int getCampingGearCommentInsert(CampingGearBoardCommentVO cgbvo) {
		return campingGearBoardDAO.getCampingGearCommentInsert(cgbvo);
	}

	@Override
	public int getCampingGearCommentDelete(String cp_idx) {
		return campingGearBoardDAO.getCampingGearCommentDelete(cp_idx);
	}

	@Override
	public int getCampingGearCommentUpdate(CampingGearBoardCommentVO cgbvo) {
		return campingGearBoardDAO.getCampingGearBoardCommentUpdate(cgbvo);
	}

	@Override
	public List<CampingGearBoardCommentVO> getCampingGearCommentReplyList(String cp_idx) {
		return campingGearBoardDAO.getCampingGearCommentReplyList(cp_idx);
	}

	@Override
	public int getLevUpdate(Map<String, Integer> map) {
		return campingGearBoardDAO.getLevUpdate(map);
	}

	@Override
	public int getAnsInsert(CampingGearBoardCommentVO cgbvo) {
		return campingGearBoardDAO.getAnsInsert(cgbvo);
	}

	@Override
	public int getCampingGearAdminDelete(String cp_idx) {
		return campingGearBoardDAO.getCampingGearAdminDelete(cp_idx);
	}

	@Override
	public CampingGearBoardCommentVO getCampingGearDetail2(String c_idx) {
		return campingGearBoardDAO.getCampingGearDetail2(c_idx);
	}
}