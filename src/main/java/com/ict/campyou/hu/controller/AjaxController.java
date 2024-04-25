package com.ict.campyou.hu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ict.campyou.hu.service.MemberService;

@RestController
public class AjaxController {
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping(value="getIdChk.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String getIdChk(String member_id) {
		String result = memberService.getIdChk(member_id);
		return result;
	}

}
