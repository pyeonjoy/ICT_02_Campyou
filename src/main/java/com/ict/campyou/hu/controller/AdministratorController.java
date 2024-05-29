package com.ict.campyou.hu.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
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
import com.ict.campyou.hu.dao.BoardFreeVO;
import com.ict.campyou.hu.dao.CampingGearBoardCommentVO;
import com.ict.campyou.hu.dao.CampingGearBoardVO;
import com.ict.campyou.hu.dao.CampingGearSearchVO;
import com.ict.campyou.hu.dao.CommBoardVO;
import com.ict.campyou.hu.dao.CommentVO;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.hu.service.AdminMembService;
import com.ict.campyou.hu.service.BoardFreeService;
import com.ict.campyou.hu.service.CampingGearBoardService;
import com.ict.campyou.hu.service.CampingGearSearchService;
import com.ict.campyou.hu.service.CommBoardService;
import com.ict.campyou.hu.service.MemberService;

@Controller
public class AdministratorController {
	@Autowired
	private AdminMembService adminMembService;
	
	@Autowired
	private CommBoardService commBoardService;
	
	@Autowired
	private CampingGearBoardService campingGearBoardService;
	
	@Autowired
	private BoardFreeService boardFreeService;
	
	@Autowired
	private CampingGearSearchService campingGearSearchService;
	
	@Autowired
	private Paging paging;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
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
	  	
	  	// 관리자 페이지 자유 게시판
	  	@RequestMapping("admin_community_board.do")
		  public ModelAndView getAdminCommunityBoard(HttpServletRequest request, HttpSession session) {
			  try {
				  ModelAndView mv = new ModelAndView("hu/adminCommunityBoard");
				  
				  int count = commBoardService.getTotalCount();
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
				  
				  List<CommBoardVO> commBoard_list = commBoardService.getCommBoardList(paging.getOffset(), paging.getNumPerPage());
				  
				  MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
				  AdminMembVO adminInfo = (AdminMembVO) session.getAttribute("admin");
				  MemberVO kakaoMemberInfo = (MemberVO) session.getAttribute("kakaoMemberInfo");
				  MemberVO naverMemberInfo = (MemberVO) session.getAttribute("naverMemberInfo");
				  
				  CommBoardVO cbvo = new CommBoardVO();
			
				  if(memberInfo != null) {
					  cbvo.setMember_idx(memberInfo.getMember_idx());
				  }
				  
				  if(memberInfo != null) {
					  cbvo.setMember_grade(memberInfo.getMember_grade());
				  }
				  
				  if(adminInfo != null) {
					  cbvo.setMember_idx(adminInfo.getAdmin_idx());
				  }
				  
				  if (commBoard_list != null) {
						mv.addObject("commBoard_list", commBoard_list);
						mv.addObject("paging", paging);
						mv.addObject("memberInfo", memberInfo);
						mv.addObject("adminInfo", adminInfo);
						mv.addObject("kakaoMemberInfo", kakaoMemberInfo);
						mv.addObject("naverMemberInfo", naverMemberInfo);
						return mv;
					}
					return new ModelAndView("hu/boardFree/error");
			} catch (Exception e) {
				System.out.println(e);
			}
			return new ModelAndView("hu/boardFree/error");
		  }
	  		  	   	
	  	@RequestMapping("admin_commBoard_content.do")
	  	public ModelAndView getCommBoardContent(@ModelAttribute("cPage") String cPage, String b_idx, HttpSession session) {
	  		try {
	  			ModelAndView mv = new ModelAndView("hu/adminCommunityBoardContent");
				MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
				AdminMembVO adminInfo = (AdminMembVO) session.getAttribute("admin");
				MemberVO kakaoMemberInfo = (MemberVO) session.getAttribute("kakaoMemberInfo");
				MemberVO naverMemberInfo = (MemberVO) session.getAttribute("naverMemberInfo");
				  
				int result = commBoardService.getCommBoardHit(b_idx);
				  
				if(memberInfo == null && adminInfo == null && kakaoMemberInfo == null && naverMemberInfo == null) {
					CommBoardVO cbvo = commBoardService.getCommBoardDetail(b_idx);
					List<CommentVO> commBoard_list2 = commBoardService.getCommBoardList2(b_idx);
					 
					if(result > 0 && cbvo != null ){
						mv.addObject("commBoard_list2", commBoard_list2);
						mv.addObject("cbvo", cbvo);
						return mv;
					} 
					return mv;
				}
				if(memberInfo != null) {
					CommBoardVO cbvo = commBoardService.getCommBoardDetail(b_idx);
					cbvo.setMember_idx(memberInfo.getMember_idx());

					if(result > 0 && cbvo != null && cbvo.getMember_idx().equals(memberInfo.getMember_idx())) {
						List<CommentVO> commBoard_list2 = commBoardService.getCommBoardList2(b_idx);
						mv.addObject("commBoard_list2", commBoard_list2);
						mv.addObject("cbvo", cbvo);
						mv.addObject("memberInfo", memberInfo);
						return mv;
					}  
				}
				if(adminInfo != null) {
					CommBoardVO cbvo = commBoardService.getCommBoardDetail(b_idx);  
					cbvo.setAdmin_idx(adminInfo.getAdmin_idx());
					
					if(result > 0 && cbvo != null && cbvo.getAdmin_idx().equals(adminInfo.getAdmin_idx())) {
						List<CommentVO> commBoard_list2 = commBoardService.getCommBoardList2(b_idx);
						mv.addObject("commBoard_list2", commBoard_list2);
						mv.addObject("cbvo", cbvo);
						mv.addObject("adminInfo", adminInfo);
						return mv;
					}  
				}
				if(kakaoMemberInfo != null) {
					CommBoardVO cbvo = commBoardService.getCommBoardDetail(b_idx);  
					cbvo.setMember_idx(kakaoMemberInfo.getMember_idx());
					
					if(result > 0 && cbvo != null && cbvo.getMember_idx().equals(kakaoMemberInfo.getMember_idx())) {
						List<CommentVO> commBoard_list2 = commBoardService.getCommBoardList2(b_idx);
						mv.addObject("commBoard_list2", commBoard_list2);
						mv.addObject("cbvo", cbvo);
						mv.addObject("kakaoMemberInfo", kakaoMemberInfo);
						return mv;
					}  
				}
				if(naverMemberInfo != null) {
					CommBoardVO cbvo = commBoardService.getCommBoardDetail(b_idx);  
					cbvo.setMember_idx(naverMemberInfo.getMember_idx());
					cbvo.setMember_name(naverMemberInfo.getMember_name());
					
					if(result > 0 && cbvo != null && cbvo.getMember_idx().equals(naverMemberInfo.getMember_idx())) {
						List<CommentVO> commBoard_list2 = commBoardService.getCommBoardList2(b_idx);
						mv.addObject("commBoard_list2", commBoard_list2);
						mv.addObject("cbvo", cbvo);
						mv.addObject("naverMemberInfo", naverMemberInfo);
						return mv;
					}  
				}
			 } catch (Exception e) {
				 	System.out.println(e);
			 }
			 return new ModelAndView("hu/boardFree/error");
	  	}
	  		
	  	@RequestMapping("admin_comm_board_write.do")
		  public ModelAndView getBoardWrite(HttpSession session) {
			  try {
				  ModelAndView mv = new ModelAndView("hu/adminCommunityBoardWrite");
				  
				  MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
				  AdminMembVO adminInfo = (AdminMembVO) session.getAttribute("admin");
				  MemberVO kakaoMemberInfo = (MemberVO) session.getAttribute("kakaoMemberInfo");
				  MemberVO naverMemberInfo = (MemberVO) session.getAttribute("naverMemberInfo");

				  if(memberInfo != null) {
					  mv.addObject("memberInfo", memberInfo);
					  return mv;
				  }
				  if(adminInfo != null) {
					  mv.addObject("adminInfo", adminInfo);
					  return mv;
				  }
				  if(kakaoMemberInfo != null) {
					  mv.addObject("kakaoMemberInfo", kakaoMemberInfo);
					  return mv;
				  }
				  if(naverMemberInfo != null) {
					  mv.addObject("naverMemberInfo", naverMemberInfo);
					  return mv;
				  }
			  } catch (Exception e) {
				  System.out.println(e);
			  }
			  return new ModelAndView("hu/boardFree/error");
		  }
		  
		  @RequestMapping("admin_comm_board_write_ok.do")
		  public ModelAndView getCommBoardWriteOk(CommBoardVO cbvo, String b_idx, HttpServletRequest request, HttpSession session) {
			  try {
				  ModelAndView mv = new ModelAndView("redirect:admin_community_board.do");
				  
				  MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
				  AdminMembVO adminInfo = (AdminMembVO) session.getAttribute("admin");
				  MemberVO kakaoMemberInfo = (MemberVO) session.getAttribute("kakaoMemberInfo");
				  MemberVO naverMemberInfo = (MemberVO) session.getAttribute("naverMemberInfo");
				 
				  String path = request.getSession().getServletContext().getRealPath("/resources/upload");
				  MultipartFile file = cbvo.getFile();
				  			
				  //관리자 글쓰기
				  if(adminInfo != null) {
					  cbvo.setAdmin_idx(adminInfo.getAdmin_idx());
					  cbvo.setMember_grade("0");
					  
					  if(file.isEmpty()) {
						  cbvo.setBf_name(""); 
					  }else {
						  UUID uuid = UUID.randomUUID();
						  String f_name = uuid.toString() + "_" + file.getOriginalFilename();
						  cbvo.setBf_name(f_name);
						  
						  byte[] in = file.getBytes();
						  File out = new File(path, f_name);
						  FileCopyUtils.copy(in, out);
					  }	
					  cbvo.setB_pwd(passwordEncoder.encode(cbvo.getB_pwd()));
					  int result = commBoardService.getCommBoardInsert(cbvo);
					  if(result > 0) {
						  return mv;
					  } 
				  }
			} catch (Exception e) {
				System.out.println(e);
			}
			  return new ModelAndView("hu/boardFree/error");
		  }
	  	
		  @RequestMapping("admin_comm_board_update.do")
			public ModelAndView getAdminCommBoardUpdate(@ModelAttribute("cPage") String cPage, @ModelAttribute("b_idx") String b_idx) {
				ModelAndView mv = new ModelAndView("hu/admincommunityBoardUpdate");
				CommBoardVO cbvo = commBoardService.getCommBoardDetail(b_idx);
				if(cbvo != null) {
					mv.addObject("cbvo", cbvo);
					return mv;
				}
				return new ModelAndView("hu/boardFree/error");
			}
		  	
		  	@RequestMapping("admin_comm_board_update_ok.do")
			public ModelAndView getCommBoardUpdateOK(@ModelAttribute("cPage")String cPage, @ModelAttribute("b_idx")String b_idx,
					                                 CommBoardVO cbvo, HttpServletRequest request) {
				try {
					ModelAndView mv = new ModelAndView();
					String path = request.getSession().getServletContext().getRealPath("/resources/upload");
					MultipartFile file = cbvo.getFile();
					if(file.isEmpty()) {
						cbvo.setBf_name(cbvo.getOld_f_name());
					}else {
						UUID uuid = UUID.randomUUID();
						String f_name = uuid.toString()+"_"+ file.getOriginalFilename();
						cbvo.setBf_name(f_name);
						
						byte[] in = file.getBytes();
						File out = new File(path, f_name);
						FileCopyUtils.copy(in, out);
					}
					int result = commBoardService.getCommBoardUpdate(cbvo);
					
					if(result>0) {
						mv.setViewName("redirect:admin_commBoard_detail.do");
						return mv;
					}
				} catch (Exception e) {
					System.out.println(e);
				}
			
				return new ModelAndView("hu/boardFree/error");
			}
		  	  	
	  	 @RequestMapping("admin_commBoard_detail.do")
		  public ModelAndView getCommBoardDetail(@ModelAttribute("cPage") String cPage, String b_idx, HttpSession session) {
			  try {
				  ModelAndView mv = new ModelAndView("hu/adminCommunityBoardDetail");
				  
				  AdminMembVO adminInfo = (AdminMembVO) session.getAttribute("admin");
				  
				  int result = commBoardService.getCommBoardHit(b_idx);
				  
				  if(adminInfo != null) {
					  CommBoardVO cbvo = commBoardService.getCommBoardDetail(b_idx);
					  cbvo.setAdmin_idx(adminInfo.getAdmin_idx());
					  
					  if(result > 0 && cbvo != null && cbvo.getAdmin_idx().equals(adminInfo.getAdmin_idx())) {
						  mv.addObject("cbvo", cbvo);
					
						  mv.addObject("adminInfo", adminInfo);
						  return mv;
					  }  
				  }
			  } catch (Exception e) {
				System.out.println(e);
			  }
			  return new ModelAndView("hu/boardFree/error");
		  }
	  	 
	  	 
	  	  //관리자 직권삭제 (비밀번호 입력 없음)
		  @RequestMapping("admin_comm_board_admin_delete.do")
		  public ModelAndView getCommBoardAdminDelete(String c_idx, String cPage, @ModelAttribute("b_idx") String b_idx) {
			  ModelAndView mv =  new ModelAndView("redirect:admin_community_board.do");
			  int result = commBoardService.getCommBoardAdminDelete(b_idx);
			  if(result > 0) {
				  mv.addObject("cPage", cPage);
				  return mv;
			  }
			  return mv;
		  }
		  
	  	//댓글입력 저장
	  	@RequestMapping("admin_comment_insert.do")
		public ModelAndView getCommentInsert(CommentVO cvo, String cPage, @ModelAttribute("b_idx")String b_idx) {
			ModelAndView mv = new ModelAndView("redirect:admin_comm_board_reply_ok.do");
			
			int result = commBoardService.getCommentInsert(cvo);
			if(result > 0) {
				mv.addObject("cPage", cPage);
				return mv;
			}
			return new ModelAndView("hu/boardFree/error");
		}
		  	
	   @RequestMapping("admin_comm_board_reply_ok.do")
	   public ModelAndView getBbsDetail(String b_idx, String cPage, HttpSession session) {
		  
		   ModelAndView mv = new ModelAndView("hu/adminCommunityBoardContent");
		  
		   MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
		   AdminMembVO adminInfo = (AdminMembVO) session.getAttribute("admin");
		   MemberVO kakaoMemberInfo = (MemberVO) session.getAttribute("kakaoMemberInfo");
		   MemberVO naverMemberInfo = (MemberVO) session.getAttribute("naverMemberInfo");
		  
		   //hit 카운트 계산
		   int result = commBoardService.getCommBoardHit(b_idx);
		  			   
		   CommBoardVO cbvo = commBoardService.getCommBoardDetail(b_idx);
		  
		   if(result>0 && cbvo != null) {
			   List<CommentVO> commBoard_list2 = commBoardService.getCommBoardList2(b_idx);
			   mv.addObject("commBoard_list2", commBoard_list2);
			   mv.addObject("memberInfo", memberInfo);
			   mv.addObject("kakaoMemberInfo", kakaoMemberInfo);
			   mv.addObject("naverMemberInfo", naverMemberInfo);
			   mv.addObject("adminInfo", adminInfo);
			   mv.addObject("cbvo", cbvo);
			   mv.addObject("cPage", cPage);
		 	   return mv;
		   }
		   return new ModelAndView("hu/boardFree/error");
	   }
	  		
	  		
  		@RequestMapping("admin_comment_delete.do")
		public ModelAndView getCommentDelete(String c_idx, String cPage, @ModelAttribute("b_idx")String b_idx) {
			ModelAndView mv =  new ModelAndView("redirect:admin_comm_board_reply_ok.do");
			int result = commBoardService.getCommentDelete(c_idx);
			if(result > 0) {
				mv.addObject("cPage", cPage);
				return mv;
			}
			return mv;
		}
			
		@RequestMapping("admin_comment_update.do")
		public ModelAndView getCommentUpdate(CommentVO cvo, String c_idx, String cPage, String content, @ModelAttribute("b_idx")String b_idx) {
			ModelAndView mv =  new ModelAndView("redirect:admin_comm_board_reply_ok.do");
			
			int result = commBoardService.getCommentUpdate(cvo);
			if(result > 0) {
				mv.addObject("cPage", cPage);
				return mv;
			}
			return new ModelAndView("hu/boardFree/error");
		}
		 
		//관리자 자유 게시판 검색
		@RequestMapping("admin_board_free_list_go.do")
		public ModelAndView getBoardFreeSearch() {
		   try {
			   ModelAndView mv = new ModelAndView("hu/adminBoardFreeList");
			   List<BoardFreeVO> boardFreeList = boardFreeService.getBoardFreeList();
			    
			   if(boardFreeList != null) {
				   mv.addObject("empList", boardFreeList);
				   return mv;
			   }
			} catch (Exception e) {
				System.out.println(e);
			}
			  return new ModelAndView("hu/boardFree/error");
		  }
	      
		//관리자 자유 게시판 검색
		@RequestMapping("admin_board_free_search.do")
		public ModelAndView getBoardFreeSearchList(@ModelAttribute("b_idx")String b_idx, String keyword) {
			try {
				ModelAndView mv = new ModelAndView("hu/adminBoardFreeSearchlist");
				List<BoardFreeVO> searchlist = boardFreeService.getBoardFreeSearchList(b_idx, keyword);
				if(searchlist != null) {
					mv.addObject("searchlist", searchlist);
					return mv;
				}
			} catch (Exception e) {
				System.out.println(e);
			}
			  return new ModelAndView("hu/boardFree/error");
		}	
			
			
	  //관리자 캠핑게시판 시작
		
	  // 관리자 페이지 캠핑 추천 게시판
  	  @RequestMapping("admin_camping_gear_board.do")
	  public ModelAndView getCampingGearBoard(HttpServletRequest request, HttpSession session) {
		  try {
			  ModelAndView mv = new ModelAndView("hu/adminCampingGearBoard");
			  
			
			  int count = campingGearBoardService.getTotalCount();
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
			  
			  List<CampingGearBoardVO> camping_gear_list = campingGearBoardService.getCampingGearList(paging.getOffset(), paging.getNumPerPage());
			  
			  MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			  AdminMembVO adminInfo = (AdminMembVO) session.getAttribute("admin");
			  MemberVO kakaoMemberInfo = (MemberVO) session.getAttribute("kakaoMemberInfo");
			  MemberVO naverMemberInfo = (MemberVO) session.getAttribute("naverMemberInfo");
			  
			  CampingGearBoardVO cgbvo = new CampingGearBoardVO();
			  
			  if(memberInfo != null) {
				  cgbvo.setMember_idx(memberInfo.getMember_idx());
			  }
			  
			  if(memberInfo != null) {
				  cgbvo.setMember_grade(memberInfo.getMember_grade());
			  }
			  
			  if(adminInfo != null) {
				  cgbvo.setMember_idx(adminInfo.getAdmin_idx());
			  }
			  
			  if (camping_gear_list != null) {
					mv.addObject("camping_gear_list", camping_gear_list);
					mv.addObject("paging", paging);
					mv.addObject("memberInfo", memberInfo);
					mv.addObject("adminInfo", adminInfo);
					mv.addObject("kakaoMemberInfo", kakaoMemberInfo);
					mv.addObject("naverMemberInfo", naverMemberInfo);
					return mv;
				}
				return new ModelAndView("hu/campingGearBoard/error");
		} catch (Exception e) {
			System.out.println(e);
		}
		return new ModelAndView("hu/campingGearBoard/error");
	  }
	  	  
  	  @RequestMapping("admin_camping_gear_write.do")
	  public ModelAndView getCampingGearWrite(HttpSession session) {
		  try {
			  ModelAndView mv = new ModelAndView("hu/adminCampingGearWrite");
			  
			  MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			  AdminMembVO adminInfo = (AdminMembVO) session.getAttribute("admin");
			  MemberVO kakaoMemberInfo = (MemberVO) session.getAttribute("kakaoMemberInfo");
			  MemberVO naverMemberInfo = (MemberVO) session.getAttribute("naverMemberInfo");
			  
			  if(memberInfo != null) {
				  mv.addObject("memberInfo", memberInfo);
				  return mv;
			  }
			  if(adminInfo != null) {
				  mv.addObject("adminInfo", adminInfo);
				  return mv;
			  }
			  if(kakaoMemberInfo != null) {
				  mv.addObject("kakaoMemberInfo", kakaoMemberInfo);
				  return mv;
			  }
			  if(naverMemberInfo != null) {
				  mv.addObject("naverMemberInfo", naverMemberInfo);
				  return mv;
			  }
		  } catch (Exception e) {
			  System.out.println(e);
		  }
		  return new ModelAndView("hu/campingGearBoard/error");
	  }
		 
	  @RequestMapping("admin_camping_gear_write_ok.do")
	  public ModelAndView getCampingGearWriteOk(CampingGearBoardVO cgbvo, HttpServletRequest request, HttpSession session) {
		  try {
			  ModelAndView mv = new ModelAndView("redirect:admin_camping_gear_board.do");
			  
			  AdminMembVO adminInfo = (AdminMembVO) session.getAttribute("admin");
	
			  String path = request.getSession().getServletContext().getRealPath("/resources/upload");
			  MultipartFile file = cgbvo.getFile();
			  			  
			  //관리자 글쓰기
			  if(adminInfo != null) {
				  cgbvo.setAdmin_idx(adminInfo.getAdmin_idx());
				  
				  if(file.isEmpty()) {
					  cgbvo.setCpf_name("");
				  }else {
					  UUID uuid = UUID.randomUUID();
					  String f_name = uuid.toString() + "_" + file.getOriginalFilename();
					  cgbvo.setCpf_name(f_name);
					  
					  byte[] in = file.getBytes();
					  File out = new File(path, f_name);
					  FileCopyUtils.copy(in, out);
				  }	
				  cgbvo.setCp_pwd(passwordEncoder.encode(cgbvo.getCp_pwd()));
				  int result = campingGearBoardService.getCampingGearWriteInsert(cgbvo);
				  if(result > 0) {
					  return mv;
				  } 
			  }
		} catch (Exception e) {
			System.out.println(e);
		}
		  return new ModelAndView("hu/campingGearBoard/error");
	  }
		 
		 
	//캠핑게시판 관리자 글쓰기
	@RequestMapping("admin_camping_gear_content.do")
  	public ModelAndView getAdminCommBoardContent(@ModelAttribute("cPage") String cPage, String cp_idx, HttpSession session) {
  		try {
  			ModelAndView mv = new ModelAndView("hu/adminCampingGearContent");
			MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			AdminMembVO adminInfo = (AdminMembVO) session.getAttribute("admin");
			MemberVO kakaoMemberInfo = (MemberVO) session.getAttribute("kakaoMemberInfo");
			MemberVO naverMemberInfo = (MemberVO) session.getAttribute("naverMemberInfo");
			  
			int result = campingGearBoardService.getCampingGearHit(cp_idx);
			  
			if(memberInfo == null && adminInfo == null && kakaoMemberInfo == null && naverMemberInfo == null) {
				CampingGearBoardVO cgbvo = campingGearBoardService.getCampingGearDetail(cp_idx);
				List<CampingGearBoardCommentVO> camping_gear_list2 = campingGearBoardService.getCampingGearList2(cp_idx);
				 
				if(result > 0 && cgbvo != null ){
					mv.addObject("camping_gear_list2", camping_gear_list2);
					mv.addObject("cgbvo", cgbvo);
					return mv;
				} 
				return mv;
			}
			if(memberInfo != null) {
				CampingGearBoardVO cgbvo = campingGearBoardService.getCampingGearDetail(cp_idx);
				  
				cgbvo.setMember_idx(memberInfo.getMember_idx());

				if(result > 0 && cgbvo != null && cgbvo.getMember_idx().equals(memberInfo.getMember_idx())) {
					List<CampingGearBoardCommentVO> camping_gear_list2 = campingGearBoardService.getCampingGearList2(cp_idx);
					mv.addObject("camping_gear_list2", camping_gear_list2);
					mv.addObject("cgbvo", cgbvo);
					mv.addObject("memberInfo", memberInfo);
					return mv;
				}  
			}
			if(adminInfo != null) {
				CampingGearBoardVO cgbvo = campingGearBoardService.getCampingGearDetail(cp_idx);	  
				cgbvo.setAdmin_idx(adminInfo.getAdmin_idx());
		
				if(result > 0 && cgbvo != null && cgbvo.getAdmin_idx().equals(adminInfo.getAdmin_idx())) {
					List<CampingGearBoardCommentVO> camping_gear_list2 = campingGearBoardService.getCampingGearList2(cp_idx);
					mv.addObject("camping_gear_list2", camping_gear_list2);
					mv.addObject("cgbvo", cgbvo);
					mv.addObject("adminInfo", adminInfo);
					return mv;
				}  
			}
			if(kakaoMemberInfo != null) {
				CampingGearBoardVO cgbvo = campingGearBoardService.getCampingGearDetail(cp_idx);
				cgbvo.setMember_idx(kakaoMemberInfo.getMember_idx());

				if(result > 0 && cgbvo != null && cgbvo.getMember_idx().equals(kakaoMemberInfo.getMember_idx())) {
					List<CampingGearBoardCommentVO> camping_gear_list2 = campingGearBoardService.getCampingGearList2(cp_idx);
					mv.addObject("camping_gear_list2", camping_gear_list2);
					mv.addObject("cgbvo", cgbvo);
					mv.addObject("kakaoMemberInfo", kakaoMemberInfo);
					return mv;
				}  
			}
			if(naverMemberInfo != null) {
				CampingGearBoardVO cgbvo = campingGearBoardService.getCampingGearDetail(cp_idx);
				cgbvo.setMember_idx(naverMemberInfo.getMember_idx());

				if(result > 0 && cgbvo != null && cgbvo.getMember_idx().equals(naverMemberInfo.getMember_idx())) {
					List<CampingGearBoardCommentVO> camping_gear_list2 = campingGearBoardService.getCampingGearList2(cp_idx);
					mv.addObject("camping_gear_list2", camping_gear_list2);
					mv.addObject("cgbvo", cgbvo);
					mv.addObject("naverMemberInfo", naverMemberInfo);
					return mv;
				}  
			}	
		} catch (Exception e) {
			System.out.println(e);
		}
		return new ModelAndView("hu/campingGearBoard/error");
  	}
		  	  
	//관리자 캠핑게시판 업데이트
	@RequestMapping("admin_camping_gear_update.do")
	 public ModelAndView getAdminCampingGearUpdate(@ModelAttribute("cPage") String cPage, @ModelAttribute("cp_idx") String cp_idx) {		  
		 ModelAndView mv = new ModelAndView("hu/adminCampingGearUpdate");
		  
		 CampingGearBoardVO cgbvo = campingGearBoardService.getCampingGearDetail(cp_idx);
		 if(cgbvo != null) {
			 mv.addObject("cgbvo", cgbvo);
			 return mv;
		 }
		 return new ModelAndView("hu/campingGearBoard/error");
	 }
		 
	//관리자 캠핑게시판 업데이트
  	@RequestMapping("admin_camping_gear_update_ok.do")
	public ModelAndView getAdminCampingGearUpdateOK(@ModelAttribute("cPage")String cPage, @ModelAttribute("cp_idx")String cp_idx,
											  CampingGearBoardVO cgbvo, HttpServletRequest request) {
		try {
			ModelAndView mv = new ModelAndView();
			String path = request.getSession().getServletContext().getRealPath("/resources/upload");
			MultipartFile file = cgbvo.getFile();
			if(file.isEmpty()) {
				cgbvo.setCpf_name(cgbvo.getOld_f_name());
			}else {
				UUID uuid = UUID.randomUUID();
				String f_name = uuid.toString()+"_"+ file.getOriginalFilename();
				cgbvo.setCpf_name(f_name);
				
				byte[] in = file.getBytes();
				File out = new File(path, f_name);
				FileCopyUtils.copy(in, out);
			}
			int result = campingGearBoardService.getCampingGearUpdate(cgbvo);
			
			if(result>0) {
				mv.setViewName("redirect:admin_camping_gear_detail.do");
				return mv;
			}
		} catch (Exception e) {
			System.out.println(e);
		}
	
		return new ModelAndView("hu/campingGearBoard/error");
	}
	  	
	  //관리자 캠핑추천게시판 강제 삭제
	  @RequestMapping("admin_camping_gear_admin_delete.do")
	  public ModelAndView getAdminCommBoardAdminDelete(String c_idx, String cPage, @ModelAttribute("cp_idx") String cp_idx) {
		  ModelAndView mv =  new ModelAndView("redirect:admin_camping_gear_board.do");
		  int result = campingGearBoardService.getCampingGearAdminDelete(cp_idx);
		  if(result > 0) {
			  mv.addObject("cPage", cPage);
			  return mv;
		  }
		  return mv;
	  }
	  
	  //관리자 캠핑추천게시판 상세보기
	  @RequestMapping("admin_camping_gear_detail.do")
	  public ModelAndView getAdminCampingGearDetail(@ModelAttribute("cPage") String cPage, String cp_idx, HttpSession session) {
		  try {
			  ModelAndView mv = new ModelAndView("hu/adminCampingGearDetail");
			  
			  MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			  AdminMembVO adminInfo = (AdminMembVO) session.getAttribute("admin");
			  MemberVO kakaoMemberInfo = (MemberVO) session.getAttribute("kakaoMemberInfo");
			  MemberVO naverMemberInfo = (MemberVO) session.getAttribute("naverMemberInfo");
			  
			  int result = campingGearBoardService.getCampingGearHit(cp_idx);
			  
			  if(memberInfo != null) {
				  CampingGearBoardVO cgbvo = campingGearBoardService.getCampingGearDetail(cp_idx);
				  cgbvo.setMember_idx(memberInfo.getMember_idx());

				  if(result > 0 && cgbvo != null && cgbvo.getMember_idx().equals(memberInfo.getMember_idx())) {
					  mv.addObject("cgbvo", cgbvo);
					  mv.addObject("memberInfo", memberInfo);
					  mv.addObject("adminInfo", adminInfo);
					  return mv;
				  }  
			  }
			  if(adminInfo != null) {	
				  CampingGearBoardVO cgbvo = campingGearBoardService.getCampingGearDetail(cp_idx);				  
				  cgbvo.setAdmin_idx(adminInfo.getAdmin_idx());
				 
				  if(result > 0 && cgbvo != null && cgbvo.getAdmin_idx().equals(adminInfo.getAdmin_idx())) {
					  mv.addObject("cgbvo", cgbvo);
					  mv.addObject("memberInfo", memberInfo);
					  mv.addObject("adminInfo", adminInfo);
					  return mv;
				  }  
			  }
			  if(kakaoMemberInfo != null) {
				  CampingGearBoardVO cgbvo = campingGearBoardService.getCampingGearDetail(cp_idx);
				  cgbvo.setMember_idx(kakaoMemberInfo.getMember_idx());

				  if(result > 0 && cgbvo != null && cgbvo.getMember_idx().equals(kakaoMemberInfo.getMember_idx())) {
					  mv.addObject("cgbvo", cgbvo);
					  mv.addObject("memberInfo", memberInfo);
					  mv.addObject("adminInfo", adminInfo);
					  mv.addObject("kakaoMemberInfo", kakaoMemberInfo);
					  return mv;
				  }  
			  }
			  if(naverMemberInfo != null) {
				  CampingGearBoardVO cgbvo = campingGearBoardService.getCampingGearDetail(cp_idx);
				  cgbvo.setMember_idx(naverMemberInfo.getMember_idx());

				  if(result > 0 && cgbvo != null && cgbvo.getMember_idx().equals(naverMemberInfo.getMember_idx())) {
					  mv.addObject("cgbvo", cgbvo);
					  mv.addObject("memberInfo", memberInfo);
					  mv.addObject("adminInfo", adminInfo);
					  mv.addObject("naverMemberInfo", naverMemberInfo);
					  return mv;
				  }  
			  }
		  } catch (Exception e) {
			System.out.println(e);
		  }
		  return new ModelAndView("hu/campingGearBoard/error");
	  }
	  	
	  //관리자 캠핑추천게시판 댓글 삽입
	  @RequestMapping("admin_cgb_comment_insert.do")
	  public ModelAndView getAdminCampingGearBoardCommentInsert(CampingGearBoardCommentVO cgbvo, String cPage, @ModelAttribute("cp_idx")String cp_idx) {
		  ModelAndView mv = new ModelAndView("redirect:admin_cgb_board_reply_ok.do");
		
		  int result = campingGearBoardService.getCampingGearCommentInsert(cgbvo);
		  if(result > 0) {
			  mv.addObject("cPage", cPage);
			  return mv;
		  }
		  return new ModelAndView("hu/campingGearBoard/error");
	  }
	  
	  //관리자 캠핑추천게시판 댓글 삭제
	  @RequestMapping("admin_cgb_comment_delete.do")
	  public ModelAndView getAdminCampingGearBoardCommentDelete(String c_idx, String cPage, @ModelAttribute("cp_idx")String cp_idx) {
		  ModelAndView mv =  new ModelAndView("redirect:admin_cgb_board_reply_ok.do");
		  int result = campingGearBoardService.getCampingGearCommentDelete(c_idx);
		  if(result > 0) {
			  mv.addObject("cPage", cPage);
			  return mv;
		  }
		  return new ModelAndView("hu/campingGearBoard/error");
	  }
	  
	  //관리자 캠핑추천게시판 댓글 수정
	  @RequestMapping("admin_cgb_comment_update.do")
	  public ModelAndView getAdminCampingGearBoardCommentUpdate(CampingGearBoardCommentVO cgbvo, String c_idx, String cPage, String content, @ModelAttribute("cp_idx")String cp_idx) {
		  ModelAndView mv =  new ModelAndView("redirect:admin_cgb_board_reply_ok.do");
			
		  int result = campingGearBoardService.getCampingGearCommentUpdate(cgbvo);
		  if(result > 0) {
			  mv.addObject("cPage", cPage);
			  return mv;
		  }
		  return new ModelAndView("hu/campingGearBoard/error");
	  }
	  
	  //관리자 캠핑추천게시판 댓글
	  @RequestMapping("admin_cgb_board_reply_ok.do")
	  public ModelAndView getAdminBbsDetail(String cp_idx, String cPage, HttpSession session) {
		  
		  ModelAndView mv = new ModelAndView("hu/adminCampingGearContent");
		  
		  MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
		  AdminMembVO adminInfo = (AdminMembVO) session.getAttribute("admin");
		  MemberVO kakaoMemberInfo = (MemberVO) session.getAttribute("kakaoMemberInfo");
		  MemberVO naverMemberInfo = (MemberVO) session.getAttribute("naverMemberInfo");
		  
		  //hit 카운트 계산
		  int result = campingGearBoardService.getCampingGearHit(cp_idx);
		 
		  CampingGearBoardVO cgbvo = campingGearBoardService.getCampingGearDetail(cp_idx);
		  
		  if(result>0 && cgbvo != null) {
			  List<CampingGearBoardCommentVO> camping_gear_list2 = campingGearBoardService.getCampingGearList2(cp_idx);
			  mv.addObject("camping_gear_list2", camping_gear_list2);
			  mv.addObject("memberInfo", memberInfo);
			  mv.addObject("kakaoMemberInfo", kakaoMemberInfo);
			  mv.addObject("naverMemberInfo", naverMemberInfo);
			  mv.addObject("adminInfo", adminInfo);
			  mv.addObject("cgbvo", cgbvo);
			  mv.addObject("cPage", cPage);
		 	  return mv;
		  }
		  return new ModelAndView("hu/campingGearBoard/error");
	  }
	  
	  @RequestMapping("admin_camping_gear_list_go.do")
	   public ModelAndView getCampingGearSearch() {
		 try {
			ModelAndView mv = new ModelAndView("hu/adminCampingGearList");
			
		    List<CampingGearSearchVO> CampingGearList = campingGearSearchService.getCampingGearSearchList();
		    
		    if(CampingGearList != null) {
		    	mv.addObject("CampingGearList", CampingGearList);
		    	return mv;
		    }
		} catch (Exception e) {
			System.out.println(e);
		}
		   return new ModelAndView("hu/campingGearBoard/error");
	   }
	   
	   @RequestMapping("admin_camping_gear_search.do")
	   public ModelAndView getCampingGearSearchList(@ModelAttribute("cp_idx")String cp_idx, String keyword) {
		   try {
				ModelAndView mv = new ModelAndView("hu/adminCampingGearSearchList");
				List<CampingGearSearchVO> searchlist = campingGearSearchService.getCampingGearSearchListOk(cp_idx, keyword);
				if(searchlist != null) {
					mv.addObject("searchlist", searchlist);
					return mv;
				}
			} catch (Exception e) {
				System.out.println(e);
			}
		   return new ModelAndView("hu/campingGearBoard/error");
	   }	   	  	
}