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
	public ModelAndView adminMemberDetail(String member_idx) {
		ModelAndView mv = new ModelAndView("joy/admin_member_detail");
		int report_all = adminService.getreportall();
		List<AdminMemberVO> board_all = adminService.getboardall();
		List<AdminMemberVO> member_report = adminService.getadminmemberreport(member_idx);
		if (board_all != null) {
			mv.addObject("report", report_all);
			mv.addObject("board", board_all);
			mv.addObject("member", member_report);
			return mv;
		}
		return new ModelAndView("board/error");
	}
	
	@RequestMapping("member_edit.do")
	public ModelAndView adminMemberEdit(String member_idx) {
		ModelAndView mv = new ModelAndView("joy/admin_member_edit");
		List<AdminMemberVO> member_report = adminService.getadminmemberreport(member_idx);
		if (member_report != null) {
			mv.addObject("member",member_report);
			return mv;
		}
		return new ModelAndView("board/error");
	}
	
	@RequestMapping("member_edit_ok.do")
	public ModelAndView adminMemberEditOk(AdminMemberVO avo) {
		ModelAndView mv = new ModelAndView();
		int result = adminService.getmemberedit(avo);
		if (result > 0 ) {
			mv.setViewName("redirect:admin_member_detail.do");
			return mv;
		}
		return new ModelAndView("board/error");
	}
	

	@RequestMapping("member_stop.do")
	public ModelAndView adminMemberStop(String member_idx, HttpServletResponse response) throws IOException {
		ModelAndView mv = new ModelAndView();
	    int result = adminService.getmemberstop(member_idx);
	    if (result > 0) {
	        response.setCharacterEncoding("UTF-8");
	        response.setContentType("text/html; charset=utf-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script> alert('회원 정지되었습니다.'); window.location.href='admin_member_detail.do'; </script>");
	        out.close();
	        return null;
	    } else {
	        return new ModelAndView("board/error");
	    }
	}
	@RequestMapping("member_stopcancel.do")
	public ModelAndView adminMemberStopCancel(String member_idx, HttpServletResponse response) throws IOException {
		ModelAndView mv = new ModelAndView();
		int result = adminService.getmemberstopcancel(member_idx);
		if (result > 0) {
			mv.setViewName("redirect:admin_member_detail.do");
			return mv;
		} else {
			return new ModelAndView("board/error");
		}
	}

	@RequestMapping("member_upgrade.do")
	public ModelAndView adminMemberUpgrade(String member_idx){
		ModelAndView mv = new ModelAndView();
		int result = adminService.getmemberupgrade(member_idx);
		if (result > 0) {
			mv.setViewName("redirect:admin_member_detail.do");
			return mv;
		} else {
			return new ModelAndView("board/error");
		}
	}
	@RequestMapping("removeimg.do")
	public ModelAndView adminRemoveImg(String member_idx){
		ModelAndView mv = new ModelAndView();
		int result = adminService.getremoveimg(member_idx);
		if (result > 0) {
			mv.setViewName("redirect:admin_member_detail.do");
			return mv;
		} else {
			return new ModelAndView("board/error");
		}
	}

}
