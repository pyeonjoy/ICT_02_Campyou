package com.ict.campyou.hu.controller;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ict.campyou.hu.service.AdminMembService;
import com.ict.campyou.hu.service.MemberService;

@RestController
public class AjaxController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private AdminMembService adminMembService;
	
	//일반회원 아이디 중복 체크
	@RequestMapping(value = "getIdChk.do", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String getIdChk(String member_id) {
		String result = memberService.getIdChk(member_id);
		return result;
	}
	
	//관리자 아이디 아이디 중복 체크
	@RequestMapping(value = "getAdminIdChk.do", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String getAdminIdChk(String admin_id) {
		String result = adminMembService.getAdminIdChk(admin_id);
		return result;
	}
	
	@RequestMapping(value="getNickNameChk.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String getNickNameChk(String member_nickname) {
		String result = memberService.getNickNameChk(member_nickname);
		return result;
	}
	
	@RequestMapping(value="getLogInIdChk.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String getLogInIdChk(String member_id) {
		String result = memberService.getLogInIdChk(member_id);
		return result;
	}
}