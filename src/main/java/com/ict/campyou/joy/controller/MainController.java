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
import com.ict.campyou.joy.dao.AdminMemberVO;
import com.ict.campyou.joy.service.AdminService;
import com.ict.campyou.joy.service.MainService;
import com.ict.campyou.jun.dao.CampVO;

@Controller
public class MainController {
	@Autowired
	private MainService mainService;
	
	@RequestMapping("/")
	public ModelAndView mainwithboard() {
		ModelAndView mv = new ModelAndView("home");
		List<AdminVO> with_board = mainService.getwithboard();
		List<CampVO> camphit = mainService.getcamphit();
		if (with_board != null) {
			mv.addObject("camphit", camphit);
			mv.addObject("board", with_board);
			return mv;
		}
		return new ModelAndView("board/error");
	}
}
