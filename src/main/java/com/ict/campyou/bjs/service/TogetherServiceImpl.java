package com.ict.campyou.bjs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.bjs.dao.TogetherDAO;
import com.ict.campyou.bjs.dao.TogetherVO;
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
	public List<TogetherVO> getTogetherList(int offset, int limit) throws Exception {
		return togetherDAO.getTogetherList(offset, limit);
	}

	@Override
	public List<CampVO> getTogetherCampList() throws Exception {
		return togetherDAO.getTogetherCampList();
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
	public String getSearchCamp(String campName) throws Exception {
		return togetherDAO.getSearchCamp(campName);
	}

	@Override
	public CampVO getSearchCampDetail(String campName) {
		return togetherDAO.getSearchCampDetail(campName);
	}

	@Override
	public List<TogetherVO> getTogetherListSearch(String searchType, String searchKeyword) {
		return togetherDAO.getTogetherListSearch(searchType, searchKeyword);
	}


}
