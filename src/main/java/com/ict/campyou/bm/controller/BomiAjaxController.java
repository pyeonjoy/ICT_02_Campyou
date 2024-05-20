package com.ict.campyou.bm.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.ict.campyou.bm.dao.ChatVO;
import com.ict.campyou.bm.dao.PasswordCheckRequest;
import com.ict.campyou.bm.service.MyService;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.jun.dao.CampVO;
import com.ict.campyou.jun.dao.HeartVO;

@RestController
public class BomiAjaxController {

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private MyService myService;
	

//	@RequestMapping(value = "pwdCheck.do", produces = "application/json; charset=utf-8")
//	public ResponseEntity<String> checkPassword(@RequestBody PasswordCheckRequest request, HttpSession session) {
//
//	    String inputPassword = request.getPassword();
//	    String memberId = request.getMemberId();
//	    MemberVO member = myService.getMemberPwd(memberId);
//
//	    boolean isPasswordMatch = passwordEncoder.matches(inputPassword, member.getMember_pwd());
//	   System.out.println(isPasswordMatch);
//	    if (isPasswordMatch) {
//	    	session.setAttribute("authenticatedMember", member);
//	    	  return ResponseEntity.ok("success");
//	    }
//
//	    return ResponseEntity.ok("fail");
//	}

	@GetMapping(value="my_fav_list.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public ModelAndView myFavList(HttpSession session) throws JsonProcessingException {
		ModelAndView mv = new ModelAndView("bm/my_fav_camping");
	    MemberVO member = (MemberVO) session.getAttribute("memberInfo");
	    String member_idx = member.getMember_idx();
	    List<HeartVO> favlist = myService.getFavList(member_idx);
	    List<CampVO> camps = new ArrayList<>();
	    for (HeartVO heart : favlist) {
	        CampVO cvo = myService.getMyFavoriteCamp(heart.getContentid());
	        camps.add(cvo);
	    }

	    Gson gson = new Gson();
		String jsonString = gson.toJson(camps);
		mv.addObject("jsonString", jsonString);
		return mv;
	}

}