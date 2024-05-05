package com.ict.campyou.hu.controller;

import java.io.File;

import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.campyou.common.Paging;
import com.ict.campyou.hu.dao.BoardFreeVO;

import com.ict.campyou.hu.dao.CommBoardVO;
import com.ict.campyou.hu.dao.CommentVO;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.hu.service.BoardFreeService;

import com.ict.campyou.hu.service.CommBoardService;
import com.ict.campyou.hu.service.CommentReplyService;
import com.ict.campyou.hu.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CommBoardService commBoardService;
	
	@Autowired
	private CommentReplyService comReplyService;
	
	@Autowired
	private BoardFreeService boardFreeService;
	
	//@Autowired
	//private CampingGearService campingGearService;
	
	@Autowired
	private Paging paging;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	  @RequestMapping("/")
	  public ModelAndView getMain() {
		  return new ModelAndView("home");
	  }
	
	  @RequestMapping("sign_up_page_go.do") 
	  public ModelAndView getSignUpPage() { 
		  try {
			  	ModelAndView mv = new ModelAndView("hu/signUp"); 
			  	return mv; 
		  }
		  catch (Exception e) { 
			  System.out.println(e); 
		  } 
		  return new ModelAndView("error"); 
	  }
	  
	  @RequestMapping("sign_up_go.do")
	  public ModelAndView getSignUp(MemberVO mvo, HttpServletRequest request) {
		  try {
			  ModelAndView mv = new ModelAndView();
			  
			  String member_id = request.getParameter("member_id");
			  String member_name = request.getParameter("member_name");
			  String member_nickname = request.getParameter("member_nickname");
			  String member_dob = request.getParameter("member_dob");
			  String member_email = request.getParameter("member_email");
			  String member_pwd = request.getParameter("member_pwd");
			  String member_phone = request.getParameter("member_phone");
			  
			  String member_encrypt_pwd = passwordEncoder.encode(member_pwd);
			  
			  MemberVO vo = new MemberVO();
			  vo.setMember_id(member_id);
			  vo.setMember_name(member_name);
			  vo.setMember_nickname(member_nickname);
			  vo.setMember_dob(member_dob);
			  vo.setMember_email(member_email);
			  vo.setMember_pwd(member_encrypt_pwd);
			  vo.setMember_phone(member_phone);
			  
			  int result = memberService.getSignUp(vo);
			  
			  if(result > 0) {
				  mv.setViewName("hu/loginForm");
				  return mv;
			  }
		  }catch (Exception e) {
			System.out.println(e);
		}
		return new ModelAndView("hu/error");
	  }
	  
	  @RequestMapping("login_form.do")
	  public ModelAndView getLoginForm() {
		  try {
			  ModelAndView mv = new ModelAndView("hu/loginForm");
			  return mv;
		  }catch (Exception e) {
			System.out.println(e);
		}
		  return new ModelAndView("hu/error");
	  }
	  
	  @RequestMapping("login_go_ok.do")
	  public ModelAndView getLogin(HttpServletRequest request, MemberVO vo) {
		  try {
			  HttpSession session = request.getSession();
	          ModelAndView mv = new ModelAndView();
	          
	          MemberVO vo2 = memberService.getLogInOK(vo);
	     
	          if(!passwordEncoder.matches(vo.getMember_pwd(), vo2.getMember_pwd())) {
	        	  mv.setViewName("redirect:login_form.do");
	        	  //mv.addObject("pwdchk", "fail");
	              return mv;
	          }else {
	        	  if(vo2 != null && vo2.getMember_active().equals("1")){
	        		  session.setAttribute("admin", "ok"); 
				  }		 
				  session.setAttribute("memberInfo", vo2);
				  mv.setViewName("redirect:/");
				  return mv;  
	          }
		  }catch (Exception e) {
			System.out.println(e);
		}
		  return new ModelAndView("hu/error");
	  }
	  
	   @RequestMapping("logout_form.do")
	   public ModelAndView getLogOut(HttpSession session) {
		   try {
			   ModelAndView mv = new ModelAndView("home");
			   session.removeAttribute("memberInfo");
			   session.removeAttribute("admin");
			   return mv;
		    } catch (Exception e) {
		  	   System.out.println(e);
		   }
		   return null;
	   }
	  
	  @RequestMapping("admin_page_go.do")
	  public ModelAndView getAdminPage() {
		  try {
			  ModelAndView mv = new ModelAndView("hu/boardFree/adminPage");
			  return mv;
		} catch (Exception e) {
			System.out.println(e);
		}
		  return new ModelAndView("hu/boardFree/error");
	  }
	  
	  @RequestMapping("terms_of_use_go.do")
	  public ModelAndView getTermsOfUse() {
		  try {
			  ModelAndView mv = new ModelAndView("hu/termsOfUse");
			  return mv;
		} catch (Exception e) {
			System.out.println(e);
		}
		  return new ModelAndView("hu/error");
	  }
	  
	  @RequestMapping("community_board.do")
	  public ModelAndView getCommunityBoard(HttpServletRequest request, HttpSession session) {
		  try {
			  ModelAndView mv = new ModelAndView("hu/boardFree/communityBoard");
			  
			  //페이징 기법 & 전체 게시물 수
			  int count = commBoardService.getTotalCount();
			  paging.setTotalRecord(count);
			  
			  //전체 페이지 수
			  if(paging.getTotalRecord() <= paging.getNumPerPage()) {
				  paging.setTotalPage(1);
			  }else {
				  //전체 페이지 수 (DB게시물 수 / 한페이지당 10줄)
				  paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage());
				  // (DB게시물 수 % 한페이지당 10줄 != 0) 이면 1pg를 더한다.
				  if(paging.getTotalRecord() % paging.getNumPerPage() != 0) {
					  paging.setTotalPage(paging.getTotalPage() + 1);
				  }
			  }
			  
			  //현재 페이지 구함
			  String cPage = request.getParameter("cPage");
			  if(cPage == null) {
				  paging.setNowPage(1);
			  }else {
				  paging.setNowPage(Integer.parseInt(cPage));
			  }
			  
			  // begin, end 구하기 (Oracle)
			  // offset 구하기
			  // offset = limit * (현재페이지-1);
			  paging.setOffset(paging.getNumPerPage() * (paging.getNowPage() - 1));
			  
			  //시작 블록 // 끝블록
			  paging.setBeginBlock(
						(int) ((paging.getNowPage() - 1) / paging.getPagePerBlock()) * paging.getPagePerBlock() + 1);
				paging.setEndBlock(paging.getBeginBlock() + paging.getPagePerBlock() - 1);
				
			  if (paging.getEndBlock() > paging.getTotalPage()) {
				  paging.setEndBlock(paging.getTotalPage());
			  }
			  
			  List<CommBoardVO> commBoard_list = commBoardService.getCommBoardList(paging.getOffset(), paging.getNumPerPage());
			  
			  //맴버정보 세선 부르기
			  MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			  CommBoardVO cbvo = new CommBoardVO();
			  
			  if(memberInfo != null) {
				  //맴버세션 정보를 담기
				  cbvo.setMember_idx(memberInfo.getMember_idx());
			  }
			  
			  if (commBoard_list != null) {
					mv.addObject("commBoard_list", commBoard_list);
					mv.addObject("paging", paging);
					mv.addObject("memberInfo", memberInfo);
					return mv;
				}
				return new ModelAndView("hu/boardFree/error");
		} catch (Exception e) {
			System.out.println(e);
		}
		return new ModelAndView("hu/boardFree/error");
	  }
	  
	  @RequestMapping("comm_board_write.do")
	  public ModelAndView getBoardWrite(HttpSession session) {
		  try {
			  ModelAndView mv = new ModelAndView("hu/boardFree/communityBoardWrite");
			  
			  MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			  
			  if(memberInfo != null) {
				  mv.addObject("memberInfo", memberInfo);
				  return mv;
			  }
		  } catch (Exception e) {
			  System.out.println(e);
		  }
		  return new ModelAndView("hu/boardFree/error");
	  }
	  
	  @RequestMapping("comm_board_write_ok.do")
	  public ModelAndView getCommBoardWriteOk(CommBoardVO cbvo, HttpServletRequest request, HttpSession session) {
		  try {
			  ModelAndView mv = new ModelAndView("redirect:community_board.do");
			  
			  //맴버정보 세선 부르기
			  MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			  
			  String path = request.getSession().getServletContext().getRealPath("/resources/upload");
			  MultipartFile file = cbvo.getFile();
			  
			  if(memberInfo != null) {
				  //맴버세션 정보를 담기
				  cbvo.setMember_idx(memberInfo.getMember_idx());
				  
				  if(file.isEmpty()) {
					  cbvo.setBf_name(""); // "" 안에 path 넣으면 경로가 나온다.
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
	  
	  @RequestMapping("commBoard_detail.do")
	  public ModelAndView getCommBoardDetail(@ModelAttribute("cPage") String cPage, String b_idx, HttpSession session) {
		  try {
			  ModelAndView mv = new ModelAndView("hu/boardFree/communityBoardDetail");
			  
			  //맴버정보 세선 부르기
			  MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			  
			  //hit 업데이트
			  int result = commBoardService.getCommBoardHit(b_idx);
			  
			  if(memberInfo != null) {
				  //상세보기
				  CommBoardVO cbvo = commBoardService.getCommBoardDetail(b_idx);
				  
				  //맴버세션 정보를 담기
				  cbvo.setMember_idx(memberInfo.getMember_idx());
				  //cbvo.setMember_nickname(memberInfo.getMember_nickname());

				  if(result > 0 && cbvo != null && cbvo.getMember_idx().equals(memberInfo.getMember_idx())) {
					  mv.addObject("cbvo", cbvo);
					  mv.addObject("memberInfo", memberInfo);
					  //mv.addObject("member_nickname", memberInfo.getMember_nickname());
					  return mv;
				  }  
			  }
		  } catch (Exception e) {
			System.out.println(e);
		  }
		  return new ModelAndView("hu/boardFree/error");
	  }
	  
	  @RequestMapping("comm_board_down.do")
	  public void boardDown(HttpServletRequest request, HttpServletResponse response) {
			try {
				String f_name = request.getParameter("bf_name");
				String path = request.getSession().getServletContext().getRealPath("/resources/upload/" + f_name);
				String r_path = URLEncoder.encode(path, "UTF-8");
				response.setContentType("application/x-msdownload");
				response.setHeader("Content-Disposition", "attachment; filename=" + r_path);

				File file = new File(new String(path.getBytes(), "UTF-8"));
				FileInputStream in = new FileInputStream(file);
				OutputStream out = response.getOutputStream();
				FileCopyUtils.copy(in, out);
			} catch (Exception e) {
				System.out.println(e);
			}
	  }
	  
	  @RequestMapping("comm_reply_go.do")
	  public ModelAndView getCommBoardReply(@ModelAttribute("cPage") String cPage, @ModelAttribute("b_idx") String b_idx) {
		  return new ModelAndView("hu/boardFree/communityBoardReply");
	  }
	  
	  	//답글 입력 삽입
	  	@RequestMapping("comment_insert.do")
		public ModelAndView getCommentInsert(CommentVO cvo, String cPage, @ModelAttribute("b_idx")String b_idx) {
			ModelAndView mv = new ModelAndView("redirect:comm_board_reply_ok.do");
			
			int result = commBoardService.getCommentInsert(cvo);
			if(result > 0) {
				mv.addObject("cPage", cPage);
				return mv;
			}
			return new ModelAndView("hu/boardFree/error");
		}
	  
		@RequestMapping("comment_delete.do")
		public ModelAndView getCommentDelete(String c_idx, String cPage, @ModelAttribute("b_idx")String b_idx) {
			ModelAndView mv =  new ModelAndView("redirect:comm_board_reply_ok.do");
			int result = commBoardService.getCommentDelete(c_idx);
			if(result > 0) {
				mv.addObject("cPage", cPage);
				return mv;
			}
			return mv;
		}
		
		
		@RequestMapping("comment_update.do")
		public ModelAndView getCommentUpdate(CommentVO cvo, String c_idx, String cPage, String content, @ModelAttribute("b_idx")String b_idx) {
			ModelAndView mv =  new ModelAndView("redirect:comm_board_reply_ok.do");
			
			int result = commBoardService.getCommentUpdate(cvo);
			if(result > 0) {
				mv.addObject("cPage", cPage);
				return mv;
			}
			return new ModelAndView("hu/boardFree/error");
		}
	  
	  
	  @RequestMapping("comm_board_delete.do")
	  public ModelAndView getBoardDelete(@ModelAttribute("cPage") String cPage, @ModelAttribute("b_idx") String b_idx) {
		  try {
			  ModelAndView mv = new ModelAndView("hu/boardFree/communityBoardDelete");
			  mv.addObject("cPage", cPage);
			  return mv;
		  } catch (Exception e) {
			  System.out.println(e);
		  }
		  return new ModelAndView("hu/boardFree/error");
	  }
	  
	  //관리자 강제 삭제
	  @RequestMapping("comm_board_admin_delete.do")
	  public ModelAndView getCommBoardAdminDelete(String c_idx, String cPage, @ModelAttribute("b_idx") String b_idx) {
		  ModelAndView mv =  new ModelAndView("redirect:community_board.do");
		  int result = commBoardService.getCommBoardAdminDelete(b_idx);
		  if(result > 0) {
			  mv.addObject("cPage", cPage);
			  return mv;
		  }
		  return mv;
	  }
	  
	  @RequestMapping("comm_board_delete_ok.do")
	  public ModelAndView getBoardDeleteOk(@ModelAttribute("cPage") String cPage, 
				                           @ModelAttribute("b_idx")String b_idx, CommBoardVO cbvo) {
		  ModelAndView mv = new ModelAndView();

		  // 비밀번호 체크
		  CommBoardVO cbvo2 = commBoardService.getCommBoardDetail(cbvo.getB_idx());
		  	
		  String dpwd = cbvo2.getB_pwd();

		  if (!passwordEncoder.matches(cbvo.getB_pwd(), dpwd)) { 
		       mv.setViewName("hu/boardFree/communityBoardDelete");
			   mv.addObject("pwdchk", "fail");
			   return mv;
		   } else {
			   // active 컬럼의 값을 1로 변경하자.
			   int result = commBoardService.getCommBoardDelete(cbvo2);
			   if (result > 0) {
				   mv.setViewName("redirect:community_board.do");
					return mv;
				}
			}
			return new ModelAndView("hu/boardFree/error");
		}
	  
	  	@RequestMapping("comm_board_update.do")
		public ModelAndView getCommBoardUpdate(@ModelAttribute("cPage") String cPage, @ModelAttribute("b_idx") String b_idx) {
			ModelAndView mv = new ModelAndView("hu/boardFree/communityBoardUpdate");
			CommBoardVO cbvo = commBoardService.getCommBoardDetail(b_idx);
			if(cbvo != null) {
				mv.addObject("cbvo", cbvo);
				return mv;
			}
			return new ModelAndView("hu/boardFree/error");
		}
	  	
	  	@RequestMapping("comm_board_update_ok.do")
		public ModelAndView getCommBoardUpdateOK(@ModelAttribute("cPage")String cPage, @ModelAttribute("b_idx")String b_idx,
				                                 CommBoardVO cbvo, HttpServletRequest request) {
	  		
			ModelAndView mv = new ModelAndView();
			CommBoardVO cbvo2 = commBoardService.getCommBoardDetail(cbvo.getB_idx());
			String dpwd = cbvo2.getB_pwd();
			
			if(! passwordEncoder.matches(cbvo.getB_pwd(), dpwd)) {
				cbvo.setBf_name(dpwd);
				mv.addObject("pwchk", "fail");
				mv.addObject("cbvo", cbvo);
				mv.setViewName("hu/boardFree/communityBoardUpdate");
				return mv;
			}else {
				try {
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
						mv.setViewName("redirect:commBoard_detail.do");
						return mv;
					}
				} catch (Exception e) {
					System.out.println(e);
				}
			}
			return new ModelAndView("hu/boardFree/error");
		}
	  	
	  	@RequestMapping("commBoard_content.do")
	  	public ModelAndView getCommBoardContent(@ModelAttribute("cPage") String cPage, String b_idx, HttpSession session) {
	  		try {
	  			ModelAndView mv = new ModelAndView("hu/boardFree/communityBoardContent");
	  			//맴버정보 세선 부르기
				MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
				  
				  //hit 업데이트
				  int result = commBoardService.getCommBoardHit(b_idx);
				  
				  //비회원 게시판 보기 & 댓글보기
				  if(memberInfo == null) {
					  //상세보기
					  CommBoardVO cbvo = commBoardService.getCommBoardDetail(b_idx);
					  //댓글 리스트
					  List<CommentVO> commBoard_list2 = commBoardService.getCommBoardList2(b_idx);
					 
					  if(result > 0 && cbvo != null ){
						  mv.addObject("commBoard_list2", commBoard_list2);
						  mv.addObject("cbvo", cbvo);
						  return mv;
					  } 
					  return mv;
				  }
				  if(memberInfo != null) {
					  //상세보기
					  CommBoardVO cbvo = commBoardService.getCommBoardDetail(b_idx);
					  
					  //맴버세션 정보를 담기
					  cbvo.setMember_idx(memberInfo.getMember_idx());
					  //cbvo.setMember_nickname(memberInfo.getMember_nickname());

					  if(result > 0 && cbvo != null && cbvo.getMember_idx().equals(memberInfo.getMember_idx())) {
						  List<CommentVO> commBoard_list2 = commBoardService.getCommBoardList2(b_idx);
						  mv.addObject("commBoard_list2", commBoard_list2);
						  mv.addObject("cbvo", cbvo);
						  mv.addObject("memberInfo", memberInfo);
						 // mv.addObject("member_nickname", memberInfo.getMember_nickname());
						  return mv;
					  }  
				  }
			  } catch (Exception e) {
				System.out.println(e);
			  }
			  return new ModelAndView("hu/boardFree/error");
	  	}
	  	
	  	
	  	//댓글 출력
	  	 @RequestMapping("comm_board_reply_ok.do")
		   public ModelAndView getBbsDetail(String b_idx, String cPage, HttpSession session) {
			  
			   ModelAndView mv = new ModelAndView("hu/boardFree/communityBoardContent");
			  
			   MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			  
			   //hit 업데이트
			   int result = commBoardService.getCommBoardHit(b_idx);
			  
			   // 상세보기 
			   CommBoardVO cbvo = commBoardService.getCommBoardDetail(b_idx);
			  
				
			   if(result>0 && cbvo != null) {
				   // 댓글 가져오기 
				   List<CommentVO> commBoard_list2 = commBoardService.getCommBoardList2(b_idx);
				   mv.addObject("commBoard_list2", commBoard_list2);
				   mv.addObject("memberInfo", memberInfo);
				   mv.addObject("cbvo", cbvo);
				   mv.addObject("cPage", cPage);
			 	   return mv;
			   }
			   return new ModelAndView("hu/boardFree/error");
		   }

	  	
	  	
	  	/*
	  	@RequestMapping("comment_reply_ok.do")
		public ModelAndView getBoardAnsWrite(CommentVO cvo3, @ModelAttribute("cPage") String cPage, @ModelAttribute("bo_idx") String b_idx) {
	    	try {
	    		 CommBoardVO cbvo = commBoardService.getCommBoardDetail(b_idx);
	    		
	    		int groups = Integer.parseInt(cbvo.getGroups());
	    		int step = Integer.parseInt(cbvo.getStep());
				int lev = Integer.parseInt(cbvo.getLev());
	    		
				step++;
				lev++;
	    		
				Map<String, Integer> map = new HashMap<String, Integer>();
				map.put("groups", groups);
				map.put("lev", lev);
				
				int result = comReplyService.getLevUpdate(map);
				
				cvo3.setGroups(String.valueOf(groups));
				cvo3.setStep(String.valueOf(step));
				cvo3.setLev(String.valueOf(lev));
	    		
				//ModelAndView mv = new ModelAndView("redirect:commBoard_content.do");
				ModelAndView mv = new ModelAndView("hu/boardFree/communityBoardContent");
				
				int result2 = comReplyService.getAnsInsert(cvo3);
				if(result2 > 0) {
					mv.addObject("cvo", cvo3);
					return mv;
				}
			} catch (Exception e) {
				System.out.println(e);
			}
	    	return new ModelAndView("hu/boardFree/error");
		}
	  		*/
	  	
	  	
	  	// 댓글의 댓글 삽입 
	
		@RequestMapping("comment_reply_insert.do")
		public ModelAndView getCommentReplyInsert(CommentVO cvo, String cPage, @ModelAttribute("b_idx")String b_idx, HttpSession session) {
			ModelAndView mv = new ModelAndView("redirect:comm_board_reply_ok.do");
			
			MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			 
			List<CommentVO> lcvo = commBoardService.getCommentReplyList(b_idx);
			
			CommentVO cvo2 = commBoardService.getCommentReplyDetail(cvo.getC_idx());
			
			int groups = Integer.parseInt(cvo2.getGroups());
    		int step = Integer.parseInt(cvo2.getStep());
			int lev = Integer.parseInt(cvo2.getLev());
			
		
			step++;
			lev++;
		
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("groups", groups);
			map.put("lev", lev);
			
			int result = commBoardService.getLevUpdate(map);
			
			cvo.setGroups(String.valueOf(groups));
			cvo.setStep(String.valueOf(step));
			cvo.setLev(String.valueOf(lev));
			
			int result2 = commBoardService.getAnsInsert(cvo);
			if(result2 > 0) {
				mv.addObject("lcvo", lcvo);
				mv.addObject("memberInfo", memberInfo);
				mv.addObject("cPage", cPage);
				return mv;
			}
			return new ModelAndView("hu/boardFree/error");
		}
	  	
		
		
		
		
		
		
		
		
		//게시판 검색
	   @RequestMapping("board_free_list_go.do")
	   public ModelAndView getBoardFreeSearch() {
		 try {
			ModelAndView mv = new ModelAndView("hu//boardFree/boardFreeList");
			
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
	   
	   //게시판 검색
	   @RequestMapping("board_free_search.do")
	   public ModelAndView getBoardFreeSearchList(@ModelAttribute("b_idx")String b_idx, String keyword) {
		   try {
				ModelAndView mv = new ModelAndView("hu/boardFree/boardFreeSearchlist");
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
		
	   
	   
	 
	   
	   ///////////////////////////////////////
	   //////////////   캠핑 제품   ////////////
	   //////////////////////////////////////
	   /*
	   @RequestMapping("camping_gear_board.do") 
	   public ModelAndView getCampingGearBoardPage() { 
			try {
				 ModelAndView mv = new ModelAndView("hu/campingGearBoard/campingGearBoard"); 
				 return mv; 
			}
			catch (Exception e) { 
				System.out.println(e); 
			} 
			return new ModelAndView("error"); 
		}
	   */
	   /*
	   @RequestMapping("camping_gear_board.do")
		  public ModelAndView getCampingGearBoard(HttpServletRequest request, HttpSession session) {
			  try {
				  ModelAndView mv = new ModelAndView("hu/campingGearBoard/campingGearBoard");
				  
				  //페이징 기법 & 전체 게시물 수
				  int count = commBoardService.getTotalCount();
				  paging.setTotalRecord(count);
				  
				  //전체 페이지 수
				  if(paging.getTotalRecord() <= paging.getNumPerPage()) {
					  paging.setTotalPage(1);
				  }else {
					  //전체 페이지 수 (DB게시물 수 / 한페이지당 10줄)
					  paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage());
					  // (DB게시물 수 % 한페이지당 10줄 != 0) 이면 1pg를 더한다.
					  if(paging.getTotalRecord() % paging.getNumPerPage() != 0) {
						  paging.setTotalPage(paging.getTotalPage() + 1);
					  }
				  }
				  
				  //현재 페이지 구함
				  String cPage = request.getParameter("cPage");
				  if(cPage == null) {
					  paging.setNowPage(1);
				  }else {
					  paging.setNowPage(Integer.parseInt(cPage));
				  }
				  
				  // begin, end 구하기 (Oracle)
				  // offset 구하기
				  // offset = limit * (현재페이지-1);
				  paging.setOffset(paging.getNumPerPage() * (paging.getNowPage() - 1));
				  
				  //시작 블록 // 끝블록
				  paging.setBeginBlock(
							(int) ((paging.getNowPage() - 1) / paging.getPagePerBlock()) * paging.getPagePerBlock() + 1);
					paging.setEndBlock(paging.getBeginBlock() + paging.getPagePerBlock() - 1);
					
				  if (paging.getEndBlock() > paging.getTotalPage()) {
					  paging.setEndBlock(paging.getTotalPage());
				  }
				  
				  List<CampingGearVO> camping_gear_list = campingGearService.getCampingGearList(paging.getOffset(), paging.getNumPerPage());
				  
				  //맴버정보 세선 부르기
				  MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
				  CommBoardVO cbvo = new CommBoardVO();
				  
				  if(memberInfo != null) {
					  //맴버세션 정보를 담기
					  cbvo.setMember_idx(memberInfo.getMember_idx());
				  }
				  
				  if (commBoard_list != null) {
						mv.addObject("commBoard_list", commBoard_list);
						mv.addObject("paging", paging);
						mv.addObject("memberInfo", memberInfo);
						return mv;
					}
					return new ModelAndView("hu/boardFree/error");
			} catch (Exception e) {
				System.out.println(e);
			}
			return new ModelAndView("hu/boardFree/error");
		  }
	   */
	   
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	  	
	  	
	  	
	  	  	
}