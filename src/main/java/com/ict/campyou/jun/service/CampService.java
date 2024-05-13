package com.ict.campyou.jun.service;

import java.util.List;

import com.ict.campyou.jun.dao.CampVO;
import com.ict.campyou.jun.dao.ReviewVO;

public interface CampService {

	CampVO getCampInfo(CampVO cvo, String contentid);

	int addReview(ReviewVO rvo);

	public List<ReviewVO> loadReview(String contentid);

	int updateHit(String contentid);

	int addHeart(String contentid, String member_idx);

	String checkHeart(String contentid, String member_idx);

	int delHeart(String contentid, String member_idx);

	List<CampVO> searchCampDetail(String keyword, String lctCl, String induty, String sbrscl,int offset, int limit);

	int searchCount(String keyword, String lctCl, String induty, String sbrscl);


}
