package com.ict.campyou.joy.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.campyou.joy.dao.AdminVO;
import com.google.gson.Gson;
import com.ict.campyou.bjs.service.TogetherService;
import com.ict.campyou.common.Paging3;
import com.ict.campyou.joy.dao.AdminMemberVO;
import com.ict.campyou.joy.service.AdminService;
import com.ict.campyou.joy.service.MainService;
import com.ict.campyou.jun.dao.CampVO;

@Controller
public class MainController {
	@Autowired
	private MainService mainService;
	@Autowired
	private AdminService adminService;

	@Autowired
	private TogetherService togetherService;
	
	@Autowired
	private Paging3 paging;
	
	@RequestMapping("/")
	public ModelAndView mainwithboard() throws Exception {
		ModelAndView mv = new ModelAndView("home");
		List<AdminVO> with_board = mainService.getwithboard();
		List<CampVO> camphit = mainService.getcamphit();
		List<AdminVO> pop_list = adminService.getPopList(paging.getOffset(), paging.getNumPerPage());
		List<CampVO> campList = togetherService.getTogetherCampList();
		if (with_board != null) {
			mv.addObject("pop", pop_list);
			mv.addObject("camphit", camphit);
			mv.addObject("board", with_board);
			Gson gson = new Gson();
			String jsonCampList = gson.toJson(campList);
			mv.addObject("campList", jsonCampList);
			return mv;
		}
		return new ModelAndView("board/error");
	}
}
