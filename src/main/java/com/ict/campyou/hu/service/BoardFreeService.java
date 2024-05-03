package com.ict.campyou.hu.service;

import java.util.List;

import com.ict.campyou.hu.dao.BoardFreeVO;

public interface BoardFreeService {
	
	List<BoardFreeVO> getBoardFreeList();
	
	List<BoardFreeVO> getBoardFreeSearchList(String searchType, String searchValue);
}
