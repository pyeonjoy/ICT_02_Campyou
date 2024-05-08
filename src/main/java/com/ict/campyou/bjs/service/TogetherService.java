package com.ict.campyou.bjs.service;

import java.util.List;

import com.ict.campyou.bjs.dao.PromiseVO;
import com.ict.campyou.bjs.dao.TogetherVO;
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
	public int getPromiseChk(PromiseVO pvo);
	public int getToPomise(PromiseVO pvo) throws Exception;
	public int getToPomiseCancel(PromiseVO pvo) throws Exception;
	public int getTogetherUpdateOK(TogetherVO tvo) throws Exception;
	public int getTogetherDeleteOK(String t_idx);
//	public List<PromiseVO> getPromiseList();
}
