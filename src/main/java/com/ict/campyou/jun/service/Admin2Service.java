package com.ict.campyou.jun.service;

import java.util.List;

import com.ict.campyou.jun.dao.Admin2VO;

public interface Admin2Service {

	List<Admin2VO> getUseFAQLoad(Admin2VO a2vo,int offset, int limit);

	List<Admin2VO> getPromiseFAQLoad(Admin2VO a2vo,int offset, int limit);

	int writeUserFAQ(Admin2VO a2vo);

	int writePromiseFAQ(Admin2VO a2vo);

	int StatusUserChange(List<Integer> faq_idx);

	int StatusPromiseChange(List<Integer> faq_idx);

	int getUseFAQCount(Admin2VO a2vo);

	int getPromiseFAQCount(Admin2VO a2vo);

	int loadInquiryCount(Admin2VO a2vo);

	List<Admin2VO> loadInquiry(Admin2VO a2vo, int offset, int limit);

	int SearchInquiryCount(Admin2VO a2vo, String keywordInput, String searchType);

	List<Admin2VO> SearchInquiry(Admin2VO a2vo, String keywordInput, String searchType, int offset, int limit);

	Admin2VO getInquiryDetail(String qna_idx);

	int redirect_qna(String qna_idx,String qna_content);

	int updateStatus(String qna_idx);

	int w_board_count(Admin2VO a2vo);

	List<Admin2VO> loadBoardList(Admin2VO a2vo, int offset, int limit);

	Admin2VO w_board_detail(String t_idx);

	List<Admin2VO> w_board_detail_comment(String t_idx);

	int hide_post(String t_idx);

	int show_post(String t_idx);

	int comment_hide(String wc_idx);

	int comment_show(String wc_idx);

	int Search_W_board_count(Admin2VO a2vo, String keywordInput, String searchType);

	List<Admin2VO> SearchWithBoard(Admin2VO a2vo, String keywordInput, String searchType, int offset, int limit);




}
