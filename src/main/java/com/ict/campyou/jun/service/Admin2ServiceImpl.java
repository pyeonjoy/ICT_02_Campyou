package com.ict.campyou.jun.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.campyou.jun.dao.Admin2DAO;
import com.ict.campyou.jun.dao.Admin2VO;

@Service
public class Admin2ServiceImpl implements Admin2Service {

	@Autowired
	private Admin2DAO admin2DAO;

	@Override
	public List<Admin2VO> getUseFAQLoad(Admin2VO a2vo, int offset, int limit) {
		return admin2DAO.getUseFAQLoad(a2vo, offset, limit);
	}

	@Override
	public List<Admin2VO> getPromiseFAQLoad(Admin2VO a2vo, int offset, int limit) {
		return admin2DAO.getPromiseFAQLoad(a2vo, offset, limit);
	}

	@Override
	public int writeUserFAQ(Admin2VO a2vo) {
		return admin2DAO.writeUserFAQ(a2vo);
	}

	@Override
	public int writePromiseFAQ(Admin2VO a2vo) {
		return admin2DAO.writePromiseFAQ(a2vo);
	}

	@Override
	public int StatusUserChange(List<Integer> faq_idx) {
		return admin2DAO.StatusUserChange(faq_idx);
	}

	@Override
	public int StatusPromiseChange(List<Integer> faq_idx) {
		return admin2DAO.StatusPromiseChange(faq_idx);
	}

	@Override
	public int getUseFAQCount(Admin2VO a2vo) {
		return admin2DAO.getUseFAQCount(a2vo);
	}

	@Override
	public int getPromiseFAQCount(Admin2VO a2vo) {
		return admin2DAO.getPromiseFAQCount(a2vo);
	}

	@Override
	public int loadInquiryCount(Admin2VO a2vo) {
		return admin2DAO.loadInquiryCount(a2vo);
	}

	@Override
	public List<Admin2VO> loadInquiry(Admin2VO a2vo, int offset, int limit) {
		return admin2DAO.loadInquiry(a2vo, offset, limit);
	}

	@Override
	public int SearchInquiryCount(Admin2VO a2vo, String keyword, String searchType) {
		return admin2DAO.SearchInquiryCount(a2vo, keyword, searchType);
	}

	@Override
	public List<Admin2VO> SearchInquiry(Admin2VO a2vo, String keywordInput, String searchType, int offset, int limit) {
		return admin2DAO.SearchInquiry(a2vo, keywordInput, searchType, offset, limit);
	}

	@Override
	public Admin2VO getInquiryDetail(String qna_idx) {
		return admin2DAO.getInquiryDetail(qna_idx);
	}

	@Override
	public int redirect_qna(String qna_idx, String qna_title, String qna_content) {
		return admin2DAO.redirect_qna(qna_idx, qna_title, qna_content);
	}

	@Override
	public int updateStatus(String qna_idx) {
		return admin2DAO.updateStatus(qna_idx);
	}

	@Override
	public int w_board_count(Admin2VO a2vo) {
		return admin2DAO.w_board_count(a2vo);
	}

	@Override
	public List<Admin2VO> loadBoardList(Admin2VO a2vo, int offset, int limit) {
		return admin2DAO.loadBoardList(a2vo,offset,limit);
	}


}
