package com.ict.campyou.hu.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Conditional;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.campyou.common.Paging;
import com.ict.campyou.hu.dao.AdminMembVO;
import com.ict.campyou.hu.dao.CommBoardVO;
import com.ict.campyou.hu.dao.CommentVO;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.hu.service.AdminMembService;
import com.ict.campyou.hu.service.BoardFreeService;
import com.ict.campyou.hu.service.CommBoardService;
import com.ict.campyou.hu.service.CommentReplyService;
import com.ict.campyou.hu.service.MemberService;
import com.ict.campyou.joy.dao.AdminMemberVO;

@Controller
public class AdministratorController {
	@Autowired
	private CommBoardService commBoardService;
	
	@Autowired
	private AdminMembService adminMembService;

	@Autowired
	private Paging paging;
	
	
	  @RequestMapping("admin_page.do")
	  public ModelAndView getCommunityBoard(HttpServletRequest request, HttpSession session) {
		  try {
			  ModelAndView mv = new ModelAndView("hu/adminPage");
			  
			  int count = adminMembService.getTotalCount();
			  paging.setTotalRecord(count);
			  
			  if(paging.getTotalRecord() <= paging.getNumPerPage()) {
				  paging.setTotalPage(1);
			  }else {
				  paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage());
				  if(paging.getTotalRecord() % paging.getNumPerPage() != 0) {
					  paging.setTotalPage(paging.getTotalPage() + 1);
				  }
			  }
			  
			  String cPage = request.getParameter("cPage");
			  if(cPage == null) {
				  paging.setNowPage(1);
			  }else {
				  paging.setNowPage(Integer.parseInt(cPage));
			  }
			  
			  paging.setOffset(paging.getNumPerPage() * (paging.getNowPage() - 1));
			  
			  paging.setBeginBlock(
						(int) ((paging.getNowPage() - 1) / paging.getPagePerBlock()) * paging.getPagePerBlock() + 1);
				paging.setEndBlock(paging.getBeginBlock() + paging.getPagePerBlock() - 1);
				
			  if (paging.getEndBlock() > paging.getTotalPage()) {
				  paging.setEndBlock(paging.getTotalPage());
			  }
			  
			  List<AdminMembVO> admin_list = adminMembService.getAdminList(paging.getOffset(), paging.getNumPerPage());
			  
			  AdminMembVO adminInfo = (AdminMembVO) session.getAttribute("admin");
			
			  AdminMembVO admvo = new AdminMembVO();
		

			  if(adminInfo != null) {
				  admvo.setAdmin_idx(adminInfo.getAdmin_idx());
			  }
			  
			  if (admin_list != null) {
					mv.addObject("admin_list", admin_list);
					mv.addObject("paging", paging);
					mv.addObject("adminInfo", adminInfo);
					return mv;
				}
				return new ModelAndView("hu/error");
		} catch (Exception e) {
			System.out.println(e);
		}
		return new ModelAndView("hu/error");
	  }
	  
	  //관리자 권한주기 업데이트
	  @RequestMapping("give_admin_permission_update.do")
		public ModelAndView getGiveAdminPermissionUpdate(AdminMembVO admvo, String admin_idx) {
			ModelAndView mv =  new ModelAndView("redirect:admin_page.do");
			
			int result = adminMembService.getGiveAdminPermissionUpdate(admvo);
			
			if(result > 0) {
				
				mv.addObject("paging", paging);
				mv.addObject("admin_idx", admin_idx);
				return mv;
			}
			return new ModelAndView("hu/boardFree/error");
		}
	  
	  //관리자 권한 빼앗기 업데이트
	  @RequestMapping("revoke_admin_permission_update.do")
	  public ModelAndView getRevokeAdminPermissionUpdate(AdminMembVO admvo, String admin_idx) {
		  ModelAndView mv =  new ModelAndView("redirect:admin_page.do");
			
		  int result = adminMembService.getRevokeAdminPermissionUpdate(admvo);
			
		  if(result > 0) {
				
			  mv.addObject("paging", paging);
			  mv.addObject("admin_idx", admin_idx);
			  return mv;
		  }
		  return new ModelAndView("hu/boardFree/error");
	  }
	  
	  //슈퍼관리자가 부하관리자 강제삭제
	  @RequestMapping("delete_assistant_admin.do")
	  public ModelAndView getAssistantAdminDelete(String admin_idx, String cPage) {
		  ModelAndView mv =  new ModelAndView("redirect:admin_page.do");
		  
		  int result = adminMembService.getAssistantAdminDelete(admin_idx);
		  
		  if(result > 0) {
			  mv.addObject("cPage", cPage);
			  mv.addObject("admin_idx", admin_idx);
			  return mv;
		  }
		  return mv;
	  }
	  
	  //관리자 정보수정 페이지 가기
	  @RequestMapping("update_admin.do")
		public ModelAndView getCommBoardUpdate(@ModelAttribute("cPage") String cPage, @ModelAttribute("admin_idx") String admin_idx) {
			ModelAndView mv = new ModelAndView("hu/adminUpdate");
			
			AdminMembVO admvo = adminMembService.getAdminInfoDetail(admin_idx);
			if(admvo != null) {
				mv.addObject("admvo", admvo);
				return mv;
			}
			return new ModelAndView("hu/error");
		}
	  	
	    //관리자 정보수정 하기
	  	@RequestMapping("admin_update_ok.do")
	  	public ModelAndView getAdminUpdateOK(@RequestParam("cPage") String cPage, @RequestParam("admin_idx") String admin_idx, @ModelAttribute("admvo") AdminMembVO admvo) {
			ModelAndView mv = new ModelAndView();
			
			int result = adminMembService.getAdminUpdateOk(admvo);	
			if(result > 0) {
				mv.setViewName("redirect:admin_page.do");
				return mv;
			} 
			return new ModelAndView("hu/error");
		}
}
