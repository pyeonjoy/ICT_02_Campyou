package com.ict.campyou.hs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HsController {

	@RequestMapping("camp_map_list.do")
	public ModelAndView camp_map_search() {
		try {
			ModelAndView mv = new ModelAndView("hs/camp_map_list");
			return mv;
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	}

}
