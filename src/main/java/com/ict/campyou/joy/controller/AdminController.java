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

import com.ict.campyou.joy.dao.AdminVO;
import com.ict.campyou.common.Paging;
import com.ict.campyou.common.Paging2;
import com.ict.campyou.common.Paging3;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.joy.dao.AdminMemberVO;
import com.ict.campyou.joy.service.AdminService;

@Controller
public class AdminController {
	@Autowired
	private AdminService adminService;
	
	
	@Autowired
	private Paging2 paging;
	
	
	@RequestMapping("admin_main.do")
	public ModelAndView boardList(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("joy/admin_main");
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
		mvo.setMember_idx(mvo.getMember_idx());
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
	@RequestMapping("admin_member_list.do")
	public ModelAndView adminMemberList(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("joy/admin_member_list");
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
		mvo.setMember_idx(mvo.getMember_idx());
		// 페이징 기법
				// 전체 게시물의 수
				int count = adminService.getTotalCount();
				paging.setTotalRecord(count);
				System.out.println("ccount"+count);
				
				// 전체 페이지의 수
				if (paging.getTotalRecord() <= paging.getNumPerPage()) {
					paging.setTotalPage(1);
				} else {
					paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage());
					if (paging.getTotalRecord() % paging.getNumPerPage() != 0) {
						paging.setTotalPage(paging.getTotalPage() + 1);
					}
				}

				// 현재 페이지 구함
				String cPage = request.getParameter("cPage");
				System.out.println("cpage"+cPage);
				if (cPage == null) {
					paging.setNowPage(1);
				} else {
					paging.setNowPage(Integer.parseInt(cPage));
				}

				// begin, end 구하기 (Oracle)
				// offset 구하기
				// offset = limit * (현재페이지-1);
				paging.setOffset(paging.getNumPerPage() * (paging.getNowPage() - 1));

				// 시작 블록 // 끝블록
				paging.setBeginBlock(
						(int) ((paging.getNowPage() - 1) / paging.getPagePerBlock()) * paging.getPagePerBlock() + 1);
				paging.setEndBlock(paging.getBeginBlock() + paging.getPagePerBlock() - 1);

				if (paging.getEndBlock() > paging.getTotalPage()) {
					paging.setEndBlock(paging.getTotalPage());
				}
					List<MemberVO> member = adminService.allmember(paging.getOffset(), paging.getNumPerPage());
					if (member != null) {
						mv.addObject("member", member);
						mv.addObject("paging", paging);
						return mv;
					}
					return new ModelAndView("board/error");
	}
	
	@RequestMapping("admin_member_detail.do")
	public ModelAndView adminMemberDetail(String member_idx) {
		ModelAndView mv = new ModelAndView("joy/admin_member_detail");
		System.out.println(member_idx);
		int report_all = adminService.getreportall(member_idx);
		List<AdminMemberVO> board_all = adminService.getboardall(member_idx);
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
	public ModelAndView adminMemberEdit(String member_idx,HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
		mvo.setMember_idx(mvo.getMember_idx());
		ModelAndView mv = new ModelAndView("joy/admin_member_edit");
		List<AdminMemberVO> member_report = adminService.getadminmemberreport(member_idx);
		if (member_report != null) {
			mv.addObject("member",member_report);
			return mv;
		}
		return new ModelAndView("board/error");
	}
	
	@RequestMapping("member_edit_ok.do")
	public ModelAndView adminMemberEditOk(AdminMemberVO avo,HttpServletRequest request) {
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
		mvo.setMember_idx(mvo.getMember_idx());
		ModelAndView mv = new ModelAndView();
		int result = adminService.getmemberedit(avo);
		if (result > 0 ) {
			mv.setViewName("redirect:admin_member_detail.do");
			return mv;
		}
		return new ModelAndView("board/error");
	}
	

	@RequestMapping("member_stop.do")
	public ModelAndView adminMemberStop(String member_idx, HttpServletResponse response,HttpServletRequest request) throws IOException {
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
		mvo.setMember_idx(mvo.getMember_idx());
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
	public ModelAndView adminMemberStopCancel(String member_idx, HttpServletResponse response,HttpServletRequest request) throws IOException {
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
		mvo.setMember_idx(mvo.getMember_idx());
		int result = adminService.getmemberstopcancel(member_idx);
		if (result > 0) {
			mv.setViewName("redirect:admin_member_detail.do");
			return mv;
		} else {
			return new ModelAndView("board/error");
		}
	}

	@RequestMapping("member_upgrade.do")
	public ModelAndView adminMemberUpgrade(String member_idx,HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
		mvo.setMember_idx(mvo.getMember_idx());
		int result = adminService.getmemberupgrade(member_idx);
		if (result > 0) {
			mv.setViewName("redirect:admin_member_detail.do");
			return mv;
		} else {
			return new ModelAndView("board/error");
		}
	}
	@RequestMapping("removeimg.do")
	public ModelAndView adminRemoveImg(String member_idx,HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
		mvo.setMember_idx(mvo.getMember_idx());
		int result = adminService.getremoveimg(member_idx);
		if (result > 0) {
			mv.setViewName("redirect:admin_member_detail.do");
			return mv;
		} else {
			return new ModelAndView("board/error");
		}
	}

}
