package com.ict.campyou.bjs.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.bjs.dao.TogetherDAO;
import com.ict.campyou.bjs.dao.TogetherVO;

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


}
