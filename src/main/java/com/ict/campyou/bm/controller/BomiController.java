package com.ict.campyou.bm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.campyou.bm.dao.FaqVO;
import com.ict.campyou.bm.service.MyService;

@Controller
public class BomiController {

	@Autowired
	MyService myService;
	
//	page router
	@GetMapping("inquiry_form.do")
	public ModelAndView gotoFormWriting() {
		ModelAndView mv = new ModelAndView("bm/my_inquiry_form");
		return mv;
	}
	@GetMapping("my_info.do")
	public ModelAndView gotoMyinfo() {
		ModelAndView mv = new ModelAndView("bm/my_info");
		return mv;
	}
	
	@GetMapping("my_main.do")
	public ModelAndView gotoMypage() {
		ModelAndView mv = new ModelAndView("bm/my_main");
		return mv;
	}
	@GetMapping("my_change_pw.do")
	public ModelAndView gotoMy_changePw() {
		ModelAndView mv = new ModelAndView("bm/my_change_pw");
		return mv;
	}
	
	@GetMapping("my_faq.do")
	public ModelAndView gotoFaq(FaqVO fvo, FaqVO fvo2) {
		ModelAndView mv = new ModelAndView("bm/my_faq");
		List<FaqVO> faqs = myService.getFaqs();
		List<FaqVO> faqs2 = myService.getFaqs2();
		mv.addObject("faqs", faqs);
		mv.addObject("faqs2", faqs2);
	
		return mv;
	}
	
}
