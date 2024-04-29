package com.ict.campyou.bjs.service;

import java.util.List;

import com.ict.campyou.bjs.dao.TogetherVO;

public interface TogetherService {
	public int getToTotalCount() throws Exception;
	public List<TogetherVO> getTogetherList(int offset, int limit) throws Exception;
}
