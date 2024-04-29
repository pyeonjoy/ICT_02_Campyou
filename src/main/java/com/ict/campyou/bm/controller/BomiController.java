package com.ict.campyou.bm.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.campyou.bm.dao.FaqVO;
import com.ict.campyou.bm.service.MyService;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.hu.service.MemberService;

@Controller
public class BomiController {

	@Autowired
	private MyService myService;

//	page router
	@GetMapping("inquiry_form.do")
	public ModelAndView gotoFormWriting() {
		ModelAndView mv = new ModelAndView("bm/my_inquiry_form");
		return mv;
	}
	@GetMapping("my_info.do")
	public ModelAndView gotoMyinfo(HttpSession session) {
		ModelAndView mv = new ModelAndView("bm/my_info");
		MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
		mv.addObject("mvo", mvo);
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
