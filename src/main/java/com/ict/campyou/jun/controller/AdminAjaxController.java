package com.ict.campyou.jun.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ict.campyou.common.Paging;
import com.ict.campyou.jun.dao.Admin2VO;
import com.ict.campyou.jun.service.Admin2Service;

@RestController
public class AdminAjaxController {

	@Autowired
	private Admin2Service adminService;
	
	@Autowired
	private Paging paging;
	
	
	// 사이트 이용 문의 로드
	@RequestMapping(value = "use_faqload.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> getUseFAQLoad(Admin2VO a2vo,HttpServletRequest request){
		int count = adminService.getUseFAQCount(a2vo);
		paging.setTotalRecord(count);
		if(paging.getTotalRecord() <= paging.getNumPerPage()) {
			paging.setTotalPage(1);
		}else {
			paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage());
			if(paging.getTotalRecord() % paging.getNumPerPage() != 0) {
				paging.setTotalPage(paging.getTotalPage() +1);
			}
		}
		
		String cPage = request.getParameter("cPage");
		if(cPage == null) {
			paging.setNowPage(1);
		}else {
			paging.setNowPage(Integer.parseInt(cPage));
		}
		
		paging.setOffset(paging.getNumPerPage() * (paging.getNowPage() -1));
		
		paging.setBeginBlock((paging.getNowPage() - 1) / paging.getPagePerBlock() * paging.getPagePerBlock() + 1);
		paging.setEndBlock(paging.getBeginBlock() + paging.getPagePerBlock() - 1);

		if (paging.getEndBlock() > paging.getTotalPage()) {
		    paging.setEndBlock(paging.getTotalPage());
		}
		if (paging.getTotalRecord() == 0) {
		    paging.setTotalPage(1);
		} else {
		    paging.setTotalPage((int)Math.ceil((double)paging.getTotalRecord() / paging.getNumPerPage()));
		}
		
		List<Admin2VO> res = adminService.getUseFAQLoad(a2vo,paging.getOffset(), paging.getNumPerPage());
	    Map<String, Object> response = new HashMap<>();
	    response.put("res", res);
	    response.put("paging", paging);

	    return response;
	}
	
	// 동행 FAQ 로드
	@RequestMapping(value = "promise_faqload.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> getPromiseFAQLoad(Admin2VO a2vo,HttpServletRequest request){
		int count = adminService.getPromiseFAQCount(a2vo);
		paging.setTotalRecord(count);
		if(paging.getTotalRecord() <= paging.getNumPerPage()) {
			paging.setTotalPage(1);
		}else {
			paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage());
			if(paging.getTotalRecord() % paging.getNumPerPage() != 0) {
				paging.setTotalPage(paging.getTotalPage() +1);
			}
		}
		
		String cPage = request.getParameter("cPage");
		if(cPage == null) {
			paging.setNowPage(1);
		}else {
			paging.setNowPage(Integer.parseInt(cPage));
		}
		
		paging.setOffset(paging.getNumPerPage() * (paging.getNowPage() -1));
		
		paging.setBeginBlock((paging.getNowPage() - 1) / paging.getPagePerBlock() * paging.getPagePerBlock() + 1);
		paging.setEndBlock(paging.getBeginBlock() + paging.getPagePerBlock() - 1);

		if (paging.getEndBlock() > paging.getTotalPage()) {
		    paging.setEndBlock(paging.getTotalPage());
		}
		if (paging.getTotalRecord() == 0) {
		    paging.setTotalPage(1);
		} else {
		    paging.setTotalPage((int)Math.ceil((double)paging.getTotalRecord() / paging.getNumPerPage()));
		}
		List<Admin2VO> res = adminService.getPromiseFAQLoad(a2vo,paging.getOffset(), paging.getNumPerPage());
	    Map<String, Object> response = new HashMap<>();
	    response.put("res", res);
	    response.put("paging", paging);

	    return response;
	}
	
	@RequestMapping(value = "faq_user_write_go.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public int writeUserFAQ(@RequestBody Admin2VO a2vo){
	    int res = adminService.writeUserFAQ(a2vo);
	    return res;
	}
	
	@RequestMapping(value = "faq_promise_write_go.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public int writePromiseFAQ(@RequestBody Admin2VO a2vo){
		int res = adminService.writePromiseFAQ(a2vo);
		return res;
	}
	
	@RequestMapping(value = "StatusUserChange.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public int StatusUserChange(@RequestBody Map<String, List<Integer>> requestData){
		List<Integer> faq_idx = requestData.get("faq_ids");
		int res = adminService.StatusUserChange(faq_idx);
		return res;
	}
	
	@RequestMapping(value = "StatusPromiseChange.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public int StatusPromiseChange(@RequestBody Map<String, List<Integer>> requestData){
		List<Integer> faq_idx = requestData.get("faq_ids");
		int res = adminService.StatusPromiseChange(faq_idx);
		return res;
	}

		@RequestMapping(value = "load_inquiry.do", produces = "application/json; charset=utf-8")
		@ResponseBody
		public Map<String, Object> loadInquiry(Admin2VO a2vo,HttpServletRequest request){
			int count = adminService.loadInquiryCount(a2vo);
			paging.setTotalRecord(count);
			if(paging.getTotalRecord() <= paging.getNumPerPage()) {
				paging.setTotalPage(1);
			}else {
				paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage());
				if(paging.getTotalRecord() % paging.getNumPerPage() != 0) {
					paging.setTotalPage(paging.getTotalPage() +1);
				}
			}
			
			String cPage = request.getParameter("cPage");
			if(cPage == null) {
				paging.setNowPage(1);
			}else {
				paging.setNowPage(Integer.parseInt(cPage));
			}
			
			paging.setOffset(paging.getNumPerPage() * (paging.getNowPage() -1));
			
			paging.setBeginBlock((paging.getNowPage() - 1) / paging.getPagePerBlock() * paging.getPagePerBlock() + 1);
			paging.setEndBlock(paging.getBeginBlock() + paging.getPagePerBlock() - 1);

			if (paging.getEndBlock() > paging.getTotalPage()) {
			    paging.setEndBlock(paging.getTotalPage());
			}
			if (paging.getTotalRecord() == 0) {
			    paging.setTotalPage(1);
			} else {
			    paging.setTotalPage((int)Math.ceil((double)paging.getTotalRecord() / paging.getNumPerPage()));
			}
			
			List<Admin2VO> res = adminService.loadInquiry(a2vo,paging.getOffset(), paging.getNumPerPage());
		    Map<String, Object> response = new HashMap<>();
		    response.put("res", res);
		    response.put("paging", paging);

		    return response;
		}
		@RequestMapping(value = "inquiry_search.do", produces = "application/json; charset=utf-8")
		@ResponseBody
		public Map<String, Object> SearchInquiry(Admin2VO a2vo,HttpServletRequest request,@RequestParam()String keywordInput,@RequestParam()String searchType){
			int count = adminService.SearchInquiryCount(a2vo , keywordInput, searchType);
			paging.setTotalRecord(count);
			if(paging.getTotalRecord() <= paging.getNumPerPage()) {
				paging.setTotalPage(1);
			}else {
				paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage());
				if(paging.getTotalRecord() % paging.getNumPerPage() != 0) {
					paging.setTotalPage(paging.getTotalPage() +1);
				}
			}
			
			String cPage = request.getParameter("cPage");
			if(cPage == null) {
				paging.setNowPage(1);
			}else {
				paging.setNowPage(Integer.parseInt(cPage));
			}
			
			paging.setOffset(paging.getNumPerPage() * (paging.getNowPage() -1));
			
			paging.setBeginBlock((paging.getNowPage() - 1) / paging.getPagePerBlock() * paging.getPagePerBlock() + 1);
			paging.setEndBlock(paging.getBeginBlock() + paging.getPagePerBlock() - 1);

			if (paging.getEndBlock() > paging.getTotalPage()) {
			    paging.setEndBlock(paging.getTotalPage());
			}
			if (paging.getTotalRecord() == 0) {
			    paging.setTotalPage(1);
			} else {
			    paging.setTotalPage((int)Math.ceil((double)paging.getTotalRecord() / paging.getNumPerPage()));
			}

			
			List<Admin2VO> res = adminService.SearchInquiry(a2vo,keywordInput,searchType,paging.getOffset(), paging.getNumPerPage());
		    Map<String, Object> response = new HashMap<>();
			
		    response.put("res", res);
		    response.put("paging", paging);

		    return response;
		}
		
		@RequestMapping(value = "inquiry_detail.do", produces = "application/json; charset=utf-8")
		@ResponseBody
		public Admin2VO get_inquiry_detail(@RequestParam()String qna_idx){
			Admin2VO res = adminService.getInquiryDetail(qna_idx);
			return res;
		}
		
		@RequestMapping(value = "redirect_qna.do", produces = "application/json; charset=utf-8")
		@ResponseBody
		public int redirect_qna(@RequestParam()String qna_idx,@RequestParam()String qna_title,@RequestParam()String qna_content){
			int res = adminService.redirect_qna(qna_idx,qna_title,qna_content);
			if (res > 0) {
				int res2 = adminService.updateStatus(qna_idx);
				return res;
			}
			return 0;
		}
}
