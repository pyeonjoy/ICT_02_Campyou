package com.ict.campyou.bjs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.bjs.dao.PromiseVO;
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
//	@Override
//	public List<TogetherVO> getTogetherListSearch(int offset, int limit, String searchType, String searchKeyword) throws Exception{
//		return togetherDAO.getTogetherListSearch(offset, limit, searchType, searchKeyword);
//	}

	@Override
	public int getPromiseChk(PromiseVO pvo) {
		return togetherDAO.getPromiseChk(pvo);
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
	public int getTogetherDeleteOK(String t_idx) {
		return togetherDAO.getTogetherDeleteOK(t_idx);
	}


}
