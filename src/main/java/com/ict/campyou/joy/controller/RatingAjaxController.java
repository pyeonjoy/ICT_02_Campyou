package com.ict.campyou.joy.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.ict.campyou.bjs.dao.StarRatingVO;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.joy.service.MainService;
import com.ict.campyou.jun.dao.ReviewVO;

@RestController
public class RatingAjaxController {
	@Autowired
	private MainService mainservice; 
	
	@RequestMapping(value = "addstarok.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String addReview(@RequestBody StarRatingVO srvo, HttpSession session) {
		int res = mainservice.addStar(srvo);
		if (res > 0) {
			return String.valueOf(res);
		}
		return "error";
	}
}
