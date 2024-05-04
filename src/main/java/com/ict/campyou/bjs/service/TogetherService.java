package com.ict.campyou.bjs.service;

import java.util.List;

import com.ict.campyou.bjs.dao.TogetherVO;
import com.ict.campyou.jun.dao.CampVO;

public interface TogetherService {
	public int getToTotalCount() throws Exception;
	public List<TogetherVO> getTogetherList(int offset, int limit) throws Exception;
	public List<CampVO> getTogetherCampList() throws Exception;
	public TogetherVO getTogetherDetail(String t_idx) throws Exception;
	public int getTogetherWriteOK(TogetherVO tvo) throws Exception;
	public String getSearchCamp(String campName) throws Exception;
	public CampVO getSearchCampDetail(String campName);
	public List<TogetherVO> getTogetherListSearch(String searchType, String searchKeyword);
}
