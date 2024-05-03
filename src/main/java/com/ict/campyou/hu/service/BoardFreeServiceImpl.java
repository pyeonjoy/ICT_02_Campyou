package com.ict.campyou.hu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.hu.dao.BoardFreeDAO;
import com.ict.campyou.hu.dao.BoardFreeVO;

@Service
public class BoardFreeServiceImpl implements BoardFreeService {
	@Autowired
	private BoardFreeDAO boardFreeDAO;

	@Override
	public List<BoardFreeVO> getBoardFreeList() {
		
		return boardFreeDAO.getBoardFreeList();
	}

	@Override
	public List<BoardFreeVO> getBoardFreeSearchList(String searchType, String searchValue) {
	
		return boardFreeDAO.getBoardFreeSearchList(searchType, searchValue);
	}
}
