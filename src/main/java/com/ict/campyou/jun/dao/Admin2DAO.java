package com.ict.campyou.jun.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class Admin2DAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<Admin2VO> getUseFAQLoad(Admin2VO a2vo,int offset, int limit) {
		Map<String, Object> map = new HashMap<>();
		map.put("a2vo",a2vo);
		map.put("offset",offset);
		map.put("limit",limit);
		return sqlSessionTemplate.selectList("jun.getUseFAQLoad",map);
	}

	public List<Admin2VO> getPromiseFAQLoad(Admin2VO a2vo,int offset, int limit) {
		Map<String, Object> map = new HashMap<>();
		map.put("a2vo",a2vo);
		map.put("offset",offset);
		map.put("limit",limit);
		return sqlSessionTemplate.selectList("jun.getPromiseFAQLoad",map);
	}

	public int writeUserFAQ(Admin2VO a2vo) {
		return sqlSessionTemplate.insert("jun.writeUserFAQ",a2vo);
	}

	public int writePromiseFAQ(Admin2VO a2vo) {
		return sqlSessionTemplate.insert("jun.writePromiseFAQ",a2vo);
	}

	public int StatusUserChange(List<Integer> faq_idx) {
		return sqlSessionTemplate.update("jun.StatusUserChange",faq_idx);
	}

	public int StatusPromiseChange(List<Integer> faq_idx) {
		return sqlSessionTemplate.update("jun.StatusPromiseChange",faq_idx);
	}

	public int getUseFAQCount(Admin2VO a2vo) {
		return sqlSessionTemplate.selectOne("jun.getUseFAQCount",a2vo);
	}

	public int getPromiseFAQCount(Admin2VO a2vo) {
		return sqlSessionTemplate.selectOne("jun.getPromiseFAQCount",a2vo);
	}

	public int loadInquiryCount(Admin2VO a2vo) {
		return sqlSessionTemplate.selectOne("jun.loadInquiryCount",a2vo);
	}

	public List<Admin2VO> loadInquiry(Admin2VO a2vo, int offset, int limit) {
		Map<String, Object> map = new HashMap<>();
		map.put("a2vo",a2vo);
		map.put("offset",offset);
		map.put("limit",limit);
		return sqlSessionTemplate.selectList("jun.loadInquiry",map);
	}

	public int SearchInquiryCount(Admin2VO a2vo, String keywordInput, String searchType) {
		Map<String, Object> map = new HashMap<>();
		map.put("a2vo",a2vo);
		map.put("keywordInput",keywordInput);
		map.put("searchType",searchType);
		return sqlSessionTemplate.selectOne("jun.SearchInquiryCount",map);
	}

	public List<Admin2VO> SearchInquiry(Admin2VO a2vo, String keywordInput, String searchType, int offset, int limit) {
		Map<String, Object> map = new HashMap<>();
		map.put("a2vo",a2vo);
		map.put("keywordInput",keywordInput);
		map.put("searchType",searchType);
		map.put("offset",offset);
		map.put("limit",limit);
		return sqlSessionTemplate.selectList("jun.SearchInquiry",map);
	}

	public Admin2VO getInquiryDetail(String qna_idx) {
		return sqlSessionTemplate.selectOne("jun.getInquiryDetail",qna_idx);
	}

	public int redirect_qna(String qna_idx, String qna_title, String qna_content) {
		Map<String, Object> map = new HashMap<>();
		map.put("qna_idx",qna_idx);
		map.put("qna_title",qna_title);
		map.put("qna_content",qna_content);
		return sqlSessionTemplate.insert("jun.redirect_qna",map);
	}

	public int updateStatus(String qna_idx) {
		return sqlSessionTemplate.update("jun.updateStatus",qna_idx);
	}

	public int w_board_count(Admin2VO a2vo) {
		return sqlSessionTemplate.selectOne("jun.w_board_count",a2vo);
	}

	public List<Admin2VO> loadBoardList(Admin2VO a2vo, int offset, int limit) {
		Map<String, Object> map = new HashMap<>();
		map.put("a2vo",a2vo);
		map.put("offset",offset);
		map.put("limit",limit);
		return sqlSessionTemplate.selectList("jun.loadBoardList",map);
	}

	public Admin2VO w_board_detail(String t_idx) {
		return sqlSessionTemplate.selectOne("jun.w_board_detail",t_idx);
	}

	public List<Admin2VO> w_board_detail_comment(String t_idx) {
		return sqlSessionTemplate.selectList("jun.w_board_detail_comment",t_idx);
	}

	public int hide_post(Object t_idx) {
		return sqlSessionTemplate.update("jun.hide_post",t_idx);
	}

	public int show_post(String t_idx) {
		return sqlSessionTemplate.update("jun.show_post",t_idx);
	}

	public int comment_show(String wc_idx) {
		return sqlSessionTemplate.update("jun.comment_show",wc_idx);
	}

	public int comment_hide(String wc_idx) {
		return sqlSessionTemplate.update("jun.comment_hide",wc_idx);
	}

	public int Search_W_board_count(Admin2VO a2vo, String keywordInput, String searchType) {
		Map<String, Object> map = new HashMap<>();
		map.put("a2vo",a2vo);
		map.put("keywordInput",keywordInput);
		map.put("searchType",searchType);
		return sqlSessionTemplate.selectOne("jun.Search_W_board_count",map);
	}

	public List<Admin2VO> SearchWithBoard(Admin2VO a2vo, String keywordInput, String searchType, int offset, int limit) {
		Map<String, Object> map = new HashMap<>();
		map.put("a2vo",a2vo);
		map.put("keywordInput",keywordInput);
		map.put("searchType",searchType);
		map.put("offset",offset);
		map.put("limit",limit);
		return sqlSessionTemplate.selectList("jun.SearchWithBoard",map);
	}
}
