package com.ict.campyou.jun.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.jun.dao.CampDAO;
import com.ict.campyou.jun.dao.CampVO;
import com.ict.campyou.jun.dao.HeartDAO;
import com.ict.campyou.jun.dao.ReviewDAO;
import com.ict.campyou.jun.dao.ReviewVO;

@Service
public class CampServiceImpl implements CampService{

	@Autowired
	private CampDAO campDAO;
	
	@Autowired
	private ReviewDAO reviewDAO;
	
	@Autowired
	private HeartDAO heartDAO;
	@Override
	public CampVO getCampInfo(CampVO cvo,String contentid) {
		return campDAO.getCampInfo(cvo,contentid);
	}

	@Override
	public int addReview(ReviewVO rvo) {
		return reviewDAO.addReview(rvo);
	}

	@Override
	public List<ReviewVO> loadReview(String contentid) {
		return reviewDAO.loadReview(contentid);
	}

	@Override
	public int updateHit(String contentid) {
		return campDAO.updateHit(contentid);
	}

	@Override
	public int addHeart(String contentid,String member_idx) {
		return heartDAO.addHeart(contentid,member_idx);
	}

	@Override
	public String checkHeart(String contentid, String member_idx) {
		return heartDAO.checkHeart(contentid,member_idx);
	}

	@Override
	public int delHeart(String contentid, String member_idx) {
		return heartDAO.delHeart(contentid,member_idx);
	}

	@Override
	public List<CampVO> searchCampDetail(String keyword, String lctCl, String induty, String sbrscl,int offset, int limit,String s_sido,String s_sigungu) {
		return campDAO.searchCampDetail(keyword,lctCl,induty,sbrscl,offset,limit, s_sido, s_sigungu);
	}

	@Override
	public int searchCount(String keyword, String lctCl, String induty, String sbrscl,String s_sido,String s_sigungu) {
		return campDAO.searchCount(keyword,lctCl,induty,sbrscl, s_sido, s_sigungu);
	}


}
