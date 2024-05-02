package com.ict.campyou.hs.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class ViewController {
	@RequestMapping("admin_menu.do")
	public ModelAndView getHeader() {
		try {
			ModelAndView mv = new ModelAndView("hs/admin_menu");
			return mv;
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	@RequestMapping("mypage_menu.do")
	public ModelAndView getHeader2() {
		try {
			ModelAndView mv = new ModelAndView("hs/mypage_menu");
			return mv;
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	@RequestMapping("footer.do")
	public ModelAndView getHeader3() {
		try {
			ModelAndView mv = new ModelAndView("hs/footer");
			return mv;
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	@RequestMapping("admin_header.do")
	public ModelAndView getHeader4() {
		try {
			ModelAndView mv = new ModelAndView("hs/admin_header");
			return mv;
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}
	
	@RequestMapping("profile_small_info.do")
	public ModelAndView profile_small_info() {
		try {
			ModelAndView mv = new ModelAndView("hs/profile_small_info");
			return mv;
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

}
