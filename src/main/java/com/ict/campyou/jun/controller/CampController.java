package com.ict.campyou.jun.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ict.campyou.jun.dao.CampVO;
import com.ict.campyou.jun.service.CampService;

@Controller
public class CampController {

		@Autowired
		private CampService campService;
	
	  @GetMapping("camplist.do")
	  public ModelAndView getCampList() {
		  return new ModelAndView("jun/camp_list");
	  }
	  @GetMapping("camp_map.do")
	  public ModelAndView getCampMap() {
		  return new ModelAndView("jun/camp_map");
	  }
	  @RequestMapping("camp_detail.do")
	  public ModelAndView getCampDetail(@RequestParam()String contentid,CampVO cvo) {
		  ModelAndView mv = new ModelAndView("jun/camp_detail");
		  CampVO info = campService.getCampInfo(cvo,contentid); // DB에 저장된 캠핑리스트 정보 받아오기 
		  if (info != null) {
			  int hit = campService.updateHit(contentid); // 조회수 늘려주는거
			  mv.addObject("info", info); // JSP에 넣기
			  return mv;
		}else {
			return null;
		}
		  
	  }
	  
}
