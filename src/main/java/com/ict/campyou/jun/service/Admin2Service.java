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



}
