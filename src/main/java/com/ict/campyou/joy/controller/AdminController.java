package com.ict.campyou.joy.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ict.campyou.joy.dao.AdminVO;
import com.ict.campyou.common.Paging;
import com.ict.campyou.common.Paging2;
import com.ict.campyou.common.Paging3;
import com.ict.campyou.hu.dao.AdminMembVO;
import com.ict.campyou.hu.dao.CampingGearSearchVO;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.joy.dao.AdminMemberVO;
import com.ict.campyou.joy.service.AdminService;
import com.jcraft.jsch.Logger;

@Controller
public class AdminController {
	@Autowired
	private AdminService adminService;
	
	
	@Autowired
	private Paging paging;
	
//관리자페이지 메인 =====================================================================================================================================================================
	@RequestMapping("admin_main.do")
	public ModelAndView boardList(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("joy/admin_main");
//		HttpSession session = request.getSession();
//		AdminMembVO admin = (AdminMembVO) session.getAttribute("admin");
//		admin.setAdmin_idx(admin.getAdmin_idx());
		List<AdminVO> admin_member = adminService.getadminmainmember();
		List<AdminVO> admin_board = adminService.getadminboard();
		int admin_qna = adminService.getadminqna();
		int admin_report = adminService.getmainadminreport();
		int admin_match = adminService.getadminmatch();
		//System.out.println("admin_idx"+admin);
		if (admin_member != null) {
			mv.addObject("member", admin_member);
			mv.addObject("board", admin_board);
			mv.addObject("qna", admin_qna);
			mv.addObject("report", admin_report);
			return mv;
		}
		return new ModelAndView("board/error");
	}

//멤버리스트=========================================================================================================================================================================
	 @RequestMapping("member_search.do")
	   public ModelAndView getCampingGearSearchList(@ModelAttribute("searchType")String searchType, int offset, int limit, String keyword, HttpServletRequest request) {
		   try {
				ModelAndView mv = new ModelAndView("joy/admin_member_search");
				// 페이징 기법
				// 전체 게시물의 수
				int count = adminService.getTotalCount2();
				paging.setTotalRecord(count);
				System.out.println("전체게시글"+paging.getTotalRecord());
				System.out.println("paging.getBeginBlock()"+paging.getBeginBlock());
				System.out.println("paging.getPagePerBlock()"+paging.getPagePerBlock());
				
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
				List<AdminMemberVO> searchmember = adminService.getmemberSearch(searchType, keyword,paging.getOffset(), paging.getNumPerPage());
				if(searchmember != null) {
					mv.addObject("searchmember", searchmember);
					mv.addObject("paging",paging);
					return mv;
				}
			} catch (Exception e) {
				System.out.println(e);
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
					int count = adminService.getTotalCount2();
					paging.setTotalRecord(count);
					System.out.println("전체게시글"+paging.getTotalRecord());
					System.out.println("paging.getBeginBlock()"+paging.getBeginBlock());
					System.out.println("paging.getPagePerBlock()"+paging.getPagePerBlock());
					
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
						int statusupdate = adminService.getstatusupdate();
						System.out.println("statusupdate"+statusupdate);
						if (member != null) {
							mv.addObject("member", member);
							mv.addObject("paging", paging);
							return mv;
						}
						return new ModelAndView("board/error");
		}
		
//회원정보디테일==========================================================================================================================================
	@RequestMapping("admin_member_detail.do")
	public ModelAndView adminMemberDetail(String member_idx,String reportmember_idx) {
		ModelAndView mv = new ModelAndView("joy/admin_member_detail");
		int report_all = adminService.getreportall(member_idx);

		List<AdminMemberVO> board_all = adminService.getboardall(member_idx);
		List<AdminMemberVO> member = adminService.getadminmemberreport(member_idx);
		List<AdminMemberVO> reporteach = adminService.getradmineporteach(member_idx);
		List<AdminMemberVO> stop = adminService.getradminstop(member_idx);
		if (board_all != null) {
			System.out.println("report_all"+report_all);
			mv.addObject("stop", stop);
			mv.addObject("reporteach", reporteach);
			mv.addObject("report", report_all);
			mv.addObject("board", board_all);
			mv.addObject("member", member);
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
	public ModelAndView adminMemberEditOk(@RequestParam("member_idx") String member_idx, AdminMemberVO avo, HttpServletRequest request) {
	    HttpSession session = request.getSession();
	    MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
	    mvo.setMember_idx(mvo.getMember_idx());
	    ModelAndView mv = new ModelAndView();
	    int result = adminService.getmemberedit(avo);
	    if (result > 0) {
	        mv.setViewName("redirect:admin_member_detail.do?member_idx=" + member_idx);
	        return mv;
	    }
	    return new ModelAndView("board/error");
	}

	@RequestMapping("member_stop.do")
	public ModelAndView adminMemberStop(@RequestParam("member_idx") String member_idx, HttpServletResponse response, HttpServletRequest request) throws IOException {
	    ModelAndView mv = new ModelAndView();
	    HttpSession session = request.getSession();
	    MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
	    mvo.setMember_idx(mvo.getMember_idx());
	    int result = adminService.getmemberstop(member_idx);
	    if (result > 0) {
	        response.setCharacterEncoding("UTF-8");
	        response.setContentType("text/html; charset=utf-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script> alert('회원 정지 되었습니다.'); window.location.href='admin_member_detail.do?member_idx=" + member_idx + "'; </script>");
	        out.close();
	        return null;
	    } else {
	        return new ModelAndView("board/error");
	    }
	}

	@RequestMapping("member_stopcancel.do")
	public ModelAndView adminMemberStopCancel(@RequestParam("member_idx") String member_idx, HttpServletResponse response, HttpServletRequest request) throws IOException {
	    ModelAndView mv = new ModelAndView();
	    HttpSession session = request.getSession();
	    MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
	    mvo.setMember_idx(mvo.getMember_idx());
	    int result = adminService.getmemberstopcancel(member_idx);
	    if (result > 0) {
	        response.setCharacterEncoding("UTF-8");
	        response.setContentType("text/html; charset=utf-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script> alert('회원 복구 되었습니다.'); window.location.href='admin_member_detail.do?member_idx=" + member_idx + "'; </script>");
	        out.close();
	        mv.setViewName("redirect:admin_member_detail.do");
	        return mv;
	    } else {
	        return new ModelAndView("board/error");
	    }
	}

	@RequestMapping("member_upgrade.do")
	public ModelAndView adminMemberUpgrade(@RequestParam("member_idx") String member_idx, HttpServletRequest request) {
	    ModelAndView mv = new ModelAndView();
	    HttpSession session = request.getSession();
	    MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
	    mvo.setMember_idx(mvo.getMember_idx());
	    int result = adminService.getmemberupgrade(member_idx);
	    if (result > 0) {
	        mv.setViewName("redirect:admin_member_detail.do?member_idx=" + member_idx);
	        return mv;
	    } else {
	        return new ModelAndView("board/error");
	    }
	}

	@RequestMapping("removeimg.do")
	public ModelAndView adminRemoveImg(@RequestParam("member_idx") String member_idx,HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
		mvo.setMember_idx(mvo.getMember_idx());
		int result = adminService.getremoveimg(member_idx);
		if (result > 0) {
			mv.setViewName("redirect:admin_member_detail.do?member_idx=" + member_idx);
			return mv;
		} else {
			return new ModelAndView("board/error");
		}
	}

//신고게시판==========================================================================================================================================================================
	@RequestMapping("report_search.do")
	   public ModelAndView getReportSearchList(@ModelAttribute("searchType")String searchType, int offset, int limit, String keyword, HttpServletRequest request) {
		   try {
				ModelAndView mv = new ModelAndView("joy/admin_report_search");
				// 페이징 기법
				// 전체 게시물의 수
				int count = adminService.getTotalCount3();
				paging.setTotalRecord(count);
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
				List<AdminMemberVO> searchreport = adminService.getreportSearch(searchType, keyword,paging.getOffset(), paging.getNumPerPage());
				if(searchreport != null) {
					mv.addObject("report", searchreport);
					mv.addObject("paging",paging);
					return mv;
				}
			} catch (Exception e) {
				System.out.println(e);
			}
		   return new ModelAndView("board/error");
	   }
	 
		@RequestMapping("report_list.do")
		public ModelAndView adminReportList(HttpServletRequest request) {
			ModelAndView mv = new ModelAndView("joy/admin_report_list");
			HttpSession session = request.getSession();
			MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
			mvo.setMember_idx(mvo.getMember_idx());
			// 페이징 기법
					// 전체 게시물의 수
					int count = adminService.getTotalCount3();
					paging.setTotalRecord(count);
					System.out.println("전체게시글"+paging.getTotalRecord());
					System.out.println("paging.getBeginBlock()"+paging.getBeginBlock());
					System.out.println("paging.getPagePerBlock()"+paging.getPagePerBlock());
					System.out.println("paging.nowPage()"+paging.getNowPage());
					
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
						List<AdminMemberVO> report = adminService.allreport(paging.getOffset(), paging.getNumPerPage());
						if (report != null) {
							mv.addObject("report", report);
							mv.addObject("paging", paging);
							return mv;
						}
						return new ModelAndView("board/error");
		}
		
	
	@RequestMapping("admin_report.do")
	public ModelAndView adminReport(@RequestParam("report_idx") String report_idx,
	                                 @RequestParam("reportmember_idx") String reportmember_idx,
	                                 @RequestParam("report_day") String report_day,
	                                 HttpServletRequest request, String admin_idx) {
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
		admin_idx = mvo.getMember_idx();
	    ModelAndView mv = new ModelAndView();
	    System.out.println("reportmember_idx" + reportmember_idx);
	    int result = adminService.getadminreport(report_day, report_idx,admin_idx,reportmember_idx);
	    if (result > 0) {
	        mv.setViewName("redirect:admin_member_detail.do?member_idx=" + reportmember_idx);
	        return mv;
	    } else {
	        return new ModelAndView("board/error");
	    }
	}

	
	 @RequestMapping("report_write2.do")
		public ModelAndView reportwrite2(HttpServletRequest request,String member_idx){
			ModelAndView mv = new ModelAndView("joy/report_write2");
			HttpSession session = request.getSession();
			String reportmember_idx = member_idx; 
			MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
			List<AdminMemberVO> member = adminService.getadminmemberreport(member_idx);
			if (member != null) {
				System.out.println(member.get(0).getMember_idx());
				mv.addObject("member", member);
				return mv;
			}
			return new ModelAndView("board/error");
	 }
		@RequestMapping("report_writeok2.do")
		public ModelAndView reportwriteOK2(AdminMemberVO amvo, HttpServletRequest request, String member_idx, String reportmember_idx, String admin_idx) {
			try {
				ModelAndView mv = new ModelAndView();
				HttpSession session = request.getSession();
				MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
		        amvo.setMember_idx(member_idx);
		        amvo.setAdmin_idx(mvo.getMember_idx());
				System.out.println(member_idx);
				int result = adminService.getadminreportall(amvo);
			    if (result > 0) {
			        mv.setViewName("redirect:admin_member_detail.do?member_idx=" + member_idx);
			        return mv;
			    } else {
			        return new ModelAndView("board/error");
			    }
			} catch (Exception e) {
				System.out.println(e);
			}
			return new ModelAndView("board/error");
		}
}
