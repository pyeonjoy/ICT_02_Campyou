package com.ict.campyou.joy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.campyou.joy.service.AdminService;

@Controller
public class PopupController {
	@Autowired
	private AdminService adminService;
		
	
	@RequestMapping("popup.do")
	public ModelAndView popup(){
		ModelAndView mv = new ModelAndView("joy/popup");
		return mv;
	}
}
