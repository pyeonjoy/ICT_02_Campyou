package com.ict.campyou.jun.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ict.campyou.jun.dao.Admin2VO;
import com.ict.campyou.jun.service.Admin2Service;

@RestController
public class AdminAjaxController {

	@Autowired
	private Admin2Service adminService;
	
	// 사이트 이용 문의 로드
	@RequestMapping(value = "use_faqload.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public List<Admin2VO> getUseFAQLoad(Admin2VO a2vo){
		List<Admin2VO> res = adminService.getUseFAQLoad(a2vo);
		return res;
	}
	
	@RequestMapping(value = "promise_faqload.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public List<Admin2VO> getPromiseFAQLoad(Admin2VO a2vo){
		List<Admin2VO> res = adminService.getPromiseFAQLoad(a2vo);
		return res;
	}
	
	
}
