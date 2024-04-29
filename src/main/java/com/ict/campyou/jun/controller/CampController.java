package com.ict.campyou.jun.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CampController {

	  @GetMapping("camplist.do")
	  public ModelAndView getCampList() {
		  return new ModelAndView("jun/camp_list");
	  }
	  @GetMapping("camp_map.do")
	  public ModelAndView getCampMap() {
		  return new ModelAndView("jun/camp_map");
	  }
	
}
