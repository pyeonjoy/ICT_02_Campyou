package com.ict.campyou.bm.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ict.campyou.bm.dao.PasswordCheckRequest;
import com.ict.campyou.bm.dao.UserVO;
import com.ict.campyou.bm.service.MyService;
import com.ict.campyou.hu.dao.MemberVO;

@RestController
public class PwdCheckController {

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private MyService myService;
	

	@RequestMapping(value = "pwdCheck.do", produces = "application/json; charset=utf-8")
	public ResponseEntity<String> checkPassword(@RequestBody PasswordCheckRequest request, HttpSession session) {

	    String inputPassword = request.getPassword();
	    String memberId = request.getMemberId();
	    MemberVO member = myService.getMemberPwd(memberId);
//	    UserVO member = myService.getMemberPwd(memberId);

	    boolean isPasswordMatch = passwordEncoder.matches(inputPassword, member.getMember_pwd());
	   System.out.println(isPasswordMatch);
	    if (isPasswordMatch) {
	    	session.setAttribute("authenticatedMember", member);
	    	  return ResponseEntity.ok("success");
	    }

	    return ResponseEntity.ok("fail");
	}	
}