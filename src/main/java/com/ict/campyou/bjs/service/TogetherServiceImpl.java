package com.ict.campyou.bjs.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.bjs.dao.PromiseVO;
import com.ict.campyou.bjs.dao.StarRatingVO;
import com.ict.campyou.bjs.dao.TogetherVO;
import com.ict.campyou.bjs.dao.TogetherDAO;
import com.ict.campyou.bjs.dao.TogetherCommentVO;
import com.ict.campyou.jun.dao.CampVO;

@Service
public class TogetherServiceImpl implements TogetherService{
	@Autowired
	private TogetherDAO togetherDAO;

	@Override
	public int getToTotalCount() throws Exception{
		return togetherDAO.getToTotalCount();
	}

	@Override
	public int getToTotalCount2(String searchType, String searchKeyword) throws Exception {
		return togetherDAO.getToTotalCount2(searchType, searchKeyword);
	}

	@Override
	public List<TogetherVO> getTogetherList(int offset, int limit) throws Exception {
		return togetherDAO.getTogetherList(offset, limit);
	}

	@Override
	public List<CampVO> getTogetherCampList() throws Exception {
		return togetherDAO.getTogetherCampList();
	}
	
	@Override
	public int getPomiseCount(String t_idx) throws Exception {
		return togetherDAO.getPomiseCount(t_idx);
	}

	@Override
	public TogetherVO getTogetherDetail(String t_idx) throws Exception {
		return togetherDAO.getTogetherDetail(t_idx);
	}

	@Override
	public int getTogetherWriteOK(TogetherVO tvo) throws Exception {
		return togetherDAO.getTogetherWriteOK(tvo);
	}
	
	@Override
	public int getPromiseUpdate(PromiseVO pvo) throws Exception {
		return togetherDAO.getPromiseUpdate(pvo);
	}

	@Override
	public String getSearchCamp(String campName) throws Exception {
		return togetherDAO.getSearchCamp(campName);
	}

	@Override
	public CampVO getSearchCampDetail(String campName) throws Exception{
		return togetherDAO.getSearchCampDetail(campName);
	}

	@Override
	public List<TogetherVO> getTogetherListSearch(int offset, int limit, String searchType, String searchKeyword) throws Exception{
		return togetherDAO.getTogetherListSearch(offset, limit, searchType, searchKeyword);
	}

	@Override
	public String getPromiseChk(PromiseVO pvo) {
		return togetherDAO.getPromiseChk(pvo);
	}
	
	@Override
	public int getPmStateChk(PromiseVO pvo) throws Exception {
		return togetherDAO.getPmStateChk(pvo);
	}
	
	@Override
	public int getToPomise(PromiseVO pvo) throws Exception {
		return togetherDAO.getToPomise(pvo);
	}

	@Override
	public int getToPomiseCancel(PromiseVO pvo) throws Exception {
		return togetherDAO.getToPomiseCancel(pvo);
	}

	@Override
	public int getTogetherUpdateOK(TogetherVO tvo) throws Exception {
		return togetherDAO.getTogetherUpdateOK(tvo);
	}

	@Override
	public int getTogetherDeleteOK(String t_idx) throws Exception {
		return togetherDAO.getTogetherDeleteOK(t_idx);
	}
	
	@Override
	public List<PromiseVO> getPromiseList(String member_idx) throws Exception {
		return togetherDAO.getPromiseList(member_idx);
	}
	
	@Override
	public int getAcceptPromise(String pm_idx) throws Exception {
		return togetherDAO.getAcceptPromise(pm_idx);
	}
	
	@Override
	public int getPromiseMyCount(String member_idx) throws Exception {
		return togetherDAO.getPromiseMyCount(member_idx);
	}
	
	@Override
	public int getDeclinePromise(String pm_idx) throws Exception {
		return togetherDAO.getDeclinePromise(pm_idx);
	}
	
	@Override
	public int getToHistoryCount(String member_idx) throws Exception {
		return togetherDAO.getToHistoryCount(member_idx);
	}
	
	@Override
	public List<PromiseVO> getTogetherHistoryGet(String member_idx, int offset, int limit) throws Exception {
		return togetherDAO.getTogetherHistoryGet(member_idx, offset, limit);

	}
	
	@Override
	public int getToHistorySendCount(String member_idx) throws Exception {
		return togetherDAO.getToHistorySendCount(member_idx);
	}
	
	@Override
	public List<PromiseVO> getTogetherSendHistory(String member_idx, int offset, int limit) throws Exception {
		return togetherDAO.getTogetherSendHistory(member_idx, offset, limit);
	}
	
	@Override
	public List<TogetherCommentVO> getToCommentList(String t_idx) throws Exception {
		return togetherDAO.getToCommentList(t_idx);
	}
	
	@Override
	public int getToCommentMaxStep(Map<String, Integer> map) throws Exception {
		return togetherDAO.getToCommentMaxStep(map);
	}

	@Override
	public int getToCommentSame(Map<String, Integer> map) throws Exception {
		return togetherDAO.getToCommentSame(map);
	}
	
	@Override
	public List<TogetherCommentVO> getGroupList(Map<String, Integer> map) throws Exception {
		return togetherDAO.getGroupList(map);
	}
	
	@Override
	public int getToCommentGSUpdate(Map<String, Integer> map) throws Exception {
		return togetherDAO.getToCommentGSUpdate(map);
	}
	
	@Override
	public int getToCommentWrite(TogetherCommentVO tcvo) throws Exception {
		return togetherDAO.getToCommentWrite(tcvo);
	}

	@Override
	public int getToCommentDelete(String wc_idx) throws Exception {
		return togetherDAO.getToCommentDelete(wc_idx);
	}
	
	@Override
	public int getToCommentUpdate(TogetherCommentVO tcvo) throws Exception {
		return togetherDAO.getToCommentUpdate(tcvo);
	}
	
	@Override
	public int getBoardWithCount(String member_idx) throws Exception {
		return togetherDAO.getBoardWithCount(member_idx);
	}
	
	@Override
	public List<TogetherVO> getPromiseIng(String member_idx, int offset, int limit) throws Exception {
		return togetherDAO.getPromiseIng(member_idx, offset, limit);
	}
	
	@Override
	public List<PromiseVO> getPromisePeopleDetail(String t_idx) throws Exception {
		return togetherDAO.getPromisePeopleDetail(t_idx);
	}
	
	@Override
	public int getStarRatingCheck(StarRatingVO srvo) throws Exception {
		return togetherDAO.getStarRatingCheck(srvo);
	}
	
	@Override
	public int getPromiseBanMember(PromiseVO pvo) throws Exception {
		return togetherDAO.getPromiseBanMember(pvo);
	}
	
	@Override
	public int getBoardWithCountReady(String member_idx) throws Exception {
		return togetherDAO.getBoardWithCountReady(member_idx);
	}
	
	@Override
	public List<TogetherVO> getPromiseReady(String member_idx, int offset, int limit) throws Exception {
		return togetherDAO.getPromiseReady(member_idx, offset, limit);
	}
	
	@Override
	public int getBoardWithCountEnd(String member_idx) throws Exception {
		return togetherDAO.getBoardWithCountEnd(member_idx);
	}
	
	@Override
	public List<TogetherVO> getPromiseEnd(String member_idx, int offset, int limit) throws Exception {
		return togetherDAO.getPromiseEnd(member_idx, offset, limit);
	}
	
	@Override
	public int getEnddateUpdate(String t_idx) throws Exception {
		return togetherDAO.getEnddateUpdate(t_idx);
	}

	@Override
	public int getConfirmPartner(PromiseVO pvo) throws Exception {
		return togetherDAO.getConfirmPartner(pvo);
	}
	
}
