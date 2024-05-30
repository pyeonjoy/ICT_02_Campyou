package com.ict.campyou.joy.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.campyou.bjs.service.TogetherService;
import com.ict.campyou.common.Paging3;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.joy.dao.AdminVO;
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
	public ModelAndView mainwithboard(HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView("home");
		List<AdminVO> with_board = mainService.getwithboard();
		List<CampVO> camphit = mainService.getcamphit();
		List<AdminVO> pop_list = adminService.getPopList(paging.getOffset(), paging.getNumPerPage());
		List<CampVO> campList = togetherService.getTogetherCampList();
		if (with_board != null) {
			mv.addObject("pop", pop_list);
			mv.addObject("camphit", camphit);
			mv.addObject("board", with_board);
			mv.addObject("campList", campList);
			return mv;
		}
		return new ModelAndView("board/error");
	}
	
	@RequestMapping("report_write.do")
	public ModelAndView reportwrite(HttpServletRequest request,String member_idx){
		ModelAndView mv = new ModelAndView("joy/report_write");
		HttpSession session = request.getSession();
		String reportmember_idx = member_idx; 
		MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
		mv.addObject("reportmember_idx",reportmember_idx);
		return mv;
		}
	
	@RequestMapping("report_writeok.do")
	public ModelAndView reportwriteOK(AdminVO avo, String member_idx,HttpServletResponse response, HttpServletRequest request) throws IOException {
	    try {
	    	 ModelAndView mv = new ModelAndView();
	        HttpSession session = request.getSession();
	        MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");

	        if (mvo == null) {
	        	response.setCharacterEncoding("UTF-8");
		        response.setContentType("text/html; charset=utf-8");
		        PrintWriter out = response.getWriter();
		        out.println("<script> alert('로그인 후 이용해주세요.'); window.close();</script>");
	        	out.close();
	        	mv.setViewName("hu/loginForm");
	        	return mv;
	        }

	        avo.setMember_idx(mvo.getMember_idx());
	        int result = mainService.getReportWrite(avo);
	        System.out.println(result);
	        if (result > 0) {
	        	mv.setViewName("joy/report_write_close");
	            return mv;
	        }
	    } catch (Exception e) {
	        System.out.println(e);
	    }
	    return new ModelAndView("board/error");
	}
	
	@RequestMapping("addstar.do")
	public ModelAndView star(){
		ModelAndView mv = new ModelAndView("joy/ratingstar");
		return mv;
		}
}
