package com.ict.campyou.joy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.campyou.joy.dao.AdminVO;
import com.ict.campyou.joy.dao.MemberVO;
import com.ict.campyou.joy.service.AdminService;

@Controller
public class AdminController {
	@Autowired
	private AdminService adminService;
	
	
	
	
	@RequestMapping("admin_main.do")
	public ModelAndView boardList() {
		ModelAndView mv = new ModelAndView("joy/admin_main");
		List<AdminVO> admin_member = adminService.getadminmainmember();
		List<AdminVO> admin_board = adminService.getadminboard();
		int admin_qna = adminService.getadminqna();
		int admin_report = adminService.getadminreport();
		int admin_match = adminService.getadminmatch();
		if (admin_member != null) {
			mv.addObject("member", admin_member);
			mv.addObject("board", admin_board);
			mv.addObject("qna", admin_qna);
			mv.addObject("report", admin_report);
			mv.addObject("match", admin_match);
			return mv;
		}
		return new ModelAndView("board/error");
	}
	
	@RequestMapping("admin_member_detail.do")
	public ModelAndView adminMemberDetail() {
		ModelAndView mv = new ModelAndView("joy/admin_member_detail");
		int report_all = adminService.getreportall();
		List<MemberVO> board_all = adminService.getboardall();
		List<MemberVO> member_report = adminService.getadminmemberreport();
		System.out.println(board_all);
		if (board_all != null) {
			mv.addObject("report", report_all);
			mv.addObject("board", board_all);
			mv.addObject("member", member_report);
			return mv;
		}
		return new ModelAndView("board/error");
	}
	

}
