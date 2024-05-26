package com.ict.campyou.jun.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AdminPageController {

	@GetMapping("admin_faq.do")
	public ModelAndView getAdmin_FAQ() {
		return new ModelAndView("jun/admin_faq");
	}
	
	@GetMapping("admin_inquiry.do")
	public ModelAndView getAdmin_Inquiry() {
		return new ModelAndView("jun/admin_inquiry");
	}
	@GetMapping("admin_board_w.do")
	public ModelAndView getWithBoard() {
		return new ModelAndView("jun/admin_board_with");
	}
}
