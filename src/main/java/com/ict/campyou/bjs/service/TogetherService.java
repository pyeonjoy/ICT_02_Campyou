package com.ict.campyou.bjs.service;

import java.util.List;
import java.util.Map;

import com.ict.campyou.bjs.dao.PromiseVO;
import com.ict.campyou.bjs.dao.StarRatingVO;
import com.ict.campyou.bjs.dao.TogetherVO;
import com.ict.campyou.bjs.dao.TogetherCommentVO;
import com.ict.campyou.jun.dao.CampVO;

public interface TogetherService {
	public int getToTotalCount() throws Exception;
	public int getToTotalCount2(String searchType, String searchKeyword) throws Exception;
	public List<TogetherVO> getTogetherList(int offset, int limit) throws Exception;
	public List<CampVO> getTogetherCampList() throws Exception;
	public TogetherVO getTogetherDetail(String t_idx) throws Exception;
	public int getPomiseCount(String t_idx) throws Exception;
	public int getTogetherWriteOK(TogetherVO tvo) throws Exception;
	public int getPromiseUpdate(PromiseVO pvo) throws Exception;
	public String getSearchCamp(String campName) throws Exception;
	public CampVO getSearchCampDetail(String campName) throws Exception;
	public List<TogetherVO> getTogetherListSearch(int offset, int limit, String searchType, String searchKeyword) throws Exception;
	public String getPromiseChk(PromiseVO pvo) throws Exception;
	public int getPmStateChk(PromiseVO pvo) throws Exception;
	public int getToPomise(PromiseVO pvo) throws Exception;
	public int getToPomiseCancel(PromiseVO pvo) throws Exception;
	public int getTogetherUpdateOK(TogetherVO tvo) throws Exception;
	public int getTogetherDeleteOK(String t_idx) throws Exception;
	public List<PromiseVO> getPromiseList(String member_idx) throws Exception;
	public int getAcceptPromise(String pm_idx) throws Exception;
	public int getPromiseMyCount(String member_idx) throws Exception;
	public int getDeclinePromise(String pm_idx) throws Exception;
	public int getToHistoryCount(String member_idx) throws Exception;
	public List<PromiseVO> getTogetherHistoryGet(String member_idx, int offset, int limit) throws Exception;
	public int getToHistorySendCount(String member_idx) throws Exception;
	public List<PromiseVO> getTogetherSendHistory(String member_idx, int offset, int limit) throws Exception;
	public List<TogetherCommentVO> getToCommentList(String t_idx) throws Exception;
	public int getToCommentMaxStep(Map<String, Integer> map) throws Exception;
	public int getToCommentSame(Map<String, Integer> map) throws Exception;
	public List<TogetherCommentVO> getGroupList(Map<String, Integer> map) throws Exception;
	public int getToCommentGSUpdate(Map<String, Integer> map) throws Exception;
	public int getToCommentWrite(TogetherCommentVO tcvo) throws Exception;
	public int getToCommentDelete(String wc_idx) throws Exception;
	public int getToCommentUpdate(TogetherCommentVO tcvo) throws Exception;
	public int getBoardWithCount(String member_idx) throws Exception;
	public List<TogetherVO> getPromiseIng(String member_idx, int offset, int limit) throws Exception;
	public List<PromiseVO> getPromisePeopleDetail(String t_idx) throws Exception;
	public int getStarRatingCheck(StarRatingVO srvo) throws Exception;
	public int getPromiseBanMember(PromiseVO pvo) throws Exception;
	public int getBoardWithCountReady(String member_idx) throws Exception;
	public List<TogetherVO> getPromiseReady(String member_idx, int offset, int limit) throws Exception;
	public int getBoardWithCountEnd(String member_idx) throws Exception;
	public List<TogetherVO> getPromiseEnd(String member_idx, int offset, int limit) throws Exception;
	public int getEnddateUpdate(String t_idx) throws Exception;
	public int getConfirmPartner(PromiseVO pvo) throws Exception;
	public int getEndCampChk(String member_idx) throws Exception;
	public int getWPStateUpdate(String member_idx) throws Exception;
}
