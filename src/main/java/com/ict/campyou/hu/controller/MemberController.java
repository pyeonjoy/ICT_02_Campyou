package com.ict.campyou.hu.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.campyou.common.Paging;
import com.ict.campyou.hu.dao.AdminMembVO;
import com.ict.campyou.hu.dao.BoardFreeVO;
import com.ict.campyou.hu.dao.CommBoardVO;
import com.ict.campyou.hu.dao.CommentVO;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.hu.service.AdminMembService;
import com.ict.campyou.hu.service.BoardFreeService;
import com.ict.campyou.hu.service.CommBoardService;
import com.ict.campyou.hu.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CommBoardService commBoardService;
	
	@Autowired
	private BoardFreeService boardFreeService;
	
	@Autowired
	private AdminMembService adminMembService;

	@Autowired
	private Paging paging;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

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
	  
	  //일반회원 회원가입
	  @RequestMapping("sign_up_go.do")
	  public ModelAndView getSignUp(MemberVO mvo, HttpServletRequest request) {
		  try {
			  ModelAndView mv = new ModelAndView();
			  
			  String member_id = request.getParameter("member_id");
			  String member_name = request.getParameter("member_name");
			  String member_nickname = request.getParameter("member_nickname");
			  String member_dob = request.getParameter("member_dob");
			  String member_email = request.getParameter("member_email");
			  String member_gender = request.getParameter("member_gender");
			  String member_pwd = request.getParameter("member_pwd");
			  String member_phone = request.getParameter("member_phone");
			  
			  String member_encrypt_pwd = passwordEncoder.encode(member_pwd);
			  
			  MemberVO vo = new MemberVO();
			  vo.setMember_id(member_id);
			  vo.setMember_name(member_name);
			  vo.setMember_nickname(member_nickname);
			  vo.setMember_dob(member_dob);
			  vo.setMember_email(member_email);
			  vo.setMember_gender(member_gender);
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
	  
	  //일반회원 로그인 페이지
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
	  
	  //일반회원 로그인
	  @RequestMapping("login_go_ok.do")
	  public ModelAndView getLogin(HttpServletRequest request, MemberVO vo) {
		  try {
			  HttpSession session = request.getSession();
	          ModelAndView mv = new ModelAndView("hu/loginForm");
	          
	          MemberVO vo2 = memberService.getLogInOK(vo);
	          
	          if(vo2 == null || !passwordEncoder.matches(vo.getMember_pwd(), vo2.getMember_pwd()) && (vo.getMember_id() != vo2.getMember_id()) ) {
	        	  //mv.setViewName("redirect:login_form.do");
	        	  //mv.setViewName("hu/loginForm");
	        	  mv.addObject("pwdchk", "fail");
	              return mv;
	          }else {
	        	  if(vo2 != null && vo2.getMember_active().equals("1")){
	        		  session.setAttribute("admin", "ok"); 
				  }	
	        	  session.setAttribute("memberInfo", vo2);
	        	  String requestPage = (String) session.getAttribute("requestPage");
	        	  System.out.println("컨트롤러 requestPage : " + requestPage);
	        	  if(requestPage != null && !requestPage.isEmpty()) {
	        		  mv.setViewName("redirect:" + requestPage);
	        	  }else {
	        		  mv.setViewName("redirect:/");
	        	  }
				  mv.addObject("member_idx", vo2.getMember_idx());
				  return mv;  
	          }
		  }catch (Exception e) {
			System.out.println(e);
		}
		  return new ModelAndView("hu/error");
	  }
	  
	  //관리자 회원가입 페이지 가기
	  @RequestMapping("admin_signup_page_go.do") 
	  public ModelAndView getAdminSignUpPage() { 
		  try {
			  	ModelAndView mv = new ModelAndView("hu/adminSignUp"); 
			  	return mv; 
		  }
		  catch (Exception e) { 
			  System.out.println(e); 
		  } 
		  return new ModelAndView("error"); 
	  }
	  
	  //관리자 회원가입
	  @RequestMapping("admin_sign_up_go.do")
	  public ModelAndView getAdminSignUp(AdminMembVO admvo, HttpServletRequest request) {
		  try {
			  ModelAndView mv = new ModelAndView();
			  
			  String admin_id = request.getParameter("admin_id");
			  String admin_pwd = request.getParameter("admin_pwd");
			  String admin_name = request.getParameter("admin_name");
			  String admin_nickname = request.getParameter("admin_nickname");
			  String admin_phone = request.getParameter("admin_phone");
			  String admin_email = request.getParameter("admin_email");
			  
			  String admin_encrypt_pwd = passwordEncoder.encode(admin_pwd);
			  
			  AdminMembVO admvo2 = new AdminMembVO();
			  admvo2.setAdmin_id(admin_id);
			  admvo2.setAdmin_pwd(admin_encrypt_pwd);
			  admvo2.setAdmin_name(admin_name);
			  admvo2.setAdmin_nickname(admin_nickname);
			  admvo2.setAdmin_phone(admin_phone);
			  admvo2.setAdmin_email(admin_email);
			  
			  int result = adminMembService.getAdminSignUp(admvo2);
			  
			  if(result > 0) {
				  mv.setViewName("redirect:admin_page.do");
				  return mv;
			  }
		  }catch (Exception e) {
			System.out.println(e);
		}
		return new ModelAndView("hu/error");
	  }
	  
	  //관리자 로그인 페이지 가기
	  @RequestMapping("admin_login_form.do")
	  public ModelAndView getAdminLoginForm() {
		  try {
			  ModelAndView mv = new ModelAndView("hu/adminLoginForm");
			  return mv;
		  }catch (Exception e) {
			System.out.println(e);
		}
		  return new ModelAndView("hu/error");
	  }
	  
	  //관리자 로그인 기능
	  @RequestMapping("admin_login_go_ok.do")
	  public ModelAndView getAdminLogin(HttpServletRequest request, AdminMembVO admvo) {
		  try {
			  HttpSession session = request.getSession();
	          ModelAndView mv = new ModelAndView();
	          
	          //대장 관리자 로그인
	          AdminMembVO admvo2 = adminMembService.getAdminLogInOK(admvo);
	          
	          if(admvo2 == null || !passwordEncoder.matches(admvo.getAdmin_pwd(), admvo2.getAdmin_pwd()) && (admvo.getAdmin_id() != admvo2.getAdmin_id()) ) {
	        	  mv.setViewName("redirect:admin_login_form.do");
	              return mv;
	          }else {
	        	  //슈퍼관리자 세션
	        	  if(admvo2 != null && admvo2.getAdmin_status().equals("2")){
	        		  session.setAttribute("admin", admvo2); 
	        		  mv.setViewName("redirect:admin_main.do");
					  return mv;
				  }
	        	  //일반관리자 세션
	        	  if(admvo2 != null && admvo2.getAdmin_status().equals("1")){
	        		  session.setAttribute("admin", admvo2); 
	        		  mv.setViewName("redirect:admin_main.do");
					  return mv;
				  }
	        	  //권한 빼앗긴 관리자 로그인 (로그인 자체 불가)
	        	  if(admvo2 != null && admvo2.getAdmin_status().equals("0")){
	        		  mv.setViewName("redirect:admin_main.do");
					  return mv;
				  }	
	          }
		  }catch (Exception e) {
			System.out.println(e);
		}
		  return new ModelAndView("hu/error");
	  }
	  
	  //카카오 로그인
	  @RequestMapping("kakaologinok.do")
	  public ModelAndView getKakaoLogin(HttpSession session,HttpServletResponse response) {
		  ModelAndView mv = new ModelAndView();
		  try {
			 //카카오 로그인 access token 받아오기
			 String access_token = (String) session.getAttribute("access_token");
			
			//access_token 세션
			if(access_token != null) {
				 session.setAttribute("access_token", access_token);
			}
			//카카오 회원 insert 하기
			int result = memberService.getInsertKakaoId(session);
			MemberVO kakao_mvo = memberService.getKakaoLogInOk(session);
			if (result > 0) {
				session.setAttribute("kakaoMemberInfo", kakao_mvo); 
				session.setAttribute("memberInfo", kakao_mvo); 
				mv.addObject("memberInfo",kakao_mvo);
			    response.setCharacterEncoding("UTF-8");
		        response.setContentType("text/html; charset=utf-8");
		        PrintWriter out = response.getWriter();
		        out.println("<script> alert('추가 정보 입력이 필요합니다. 추가정보 입력칸으로 이동하겠습니다.'); window.location.href='sns_update_form.do';</script>");
		        out.close();
				return new ModelAndView("hu/snsInfo");
			}
			
			
			//카카오 회원 세션
			if(kakao_mvo != null) { 
				session.setAttribute("kakaoMemberInfo", kakao_mvo); 
				session.setAttribute("memberInfo", kakao_mvo);
				String member_id = kakao_mvo.getMember_id();
				String member_dob = kakao_mvo.getMember_dob();
				MemberVO vo = new MemberVO();
				vo.setMember_id(member_id);
				vo.setMember_dob(member_dob);
				
				MemberVO chkinfo = memberService.getinfo(vo);
				System.out.println(chkinfo);
				System.out.println(member_id+"아이디..?");
				if (chkinfo != null) {
					return new ModelAndView("home"); 
				}else {
				    response.setCharacterEncoding("UTF-8");
			        response.setContentType("text/html; charset=utf-8");
			        PrintWriter out = response.getWriter();
			        out.println("<script> alert('추가 정보 입력이 필요합니다. 추가정보 입력칸으로 이동하겠습니다.'); window.location.href='sns_update_form.do';</script>");
			        out.close();
					return new ModelAndView("hu/snsInfo");
				}
				}
		  } catch (Exception e) {
			  System.out.println(e);
		  }
		  return null;
	  }
	  
	  //네이버 로그인
	  @RequestMapping("naverloginok.do")
	  public ModelAndView getNaverLogin(HttpSession session,HttpServletResponse response) {
		  ModelAndView mv = new ModelAndView();
		  try {
			//네이버 로그인 access token 받아오기
			String access_token = (String) session.getAttribute("access_token");
			
			if(access_token != null) {
				 session.setAttribute("access_token", access_token);
			}
			//네이버 회원 insert 하기
			int result = memberService.getInsertNaverId(session);
			MemberVO naver_mvo = memberService.getNaverLogInOk(session);
			if (result > 0) {
				session.setAttribute("naverMemberInfo", naver_mvo); 
				session.setAttribute("memberInfo", naver_mvo); 
				mv.addObject("memberInfo",naver_mvo);
			    response.setCharacterEncoding("UTF-8");
		        response.setContentType("text/html; charset=utf-8");
		        PrintWriter out = response.getWriter();
		        out.println("<script> alert('추가 정보 입력이 필요합니다. 추가정보 입력칸으로 이동하겠습니다.'); window.location.href='sns_update_naver_form.do';</script>");
		        out.close();
				return new ModelAndView("hu/snsInfo_naver");
			}

			//네이버 회원 세션
			if(naver_mvo != null) {
				session.setAttribute("naverMemberInfo", naver_mvo);
				session.setAttribute("memberInfo", naver_mvo);
				String member_id = naver_mvo.getMember_id();
				String member_dob = naver_mvo.getMember_dob();
				System.out.println(member_id);
				System.out.println(member_dob);
				MemberVO vo = new MemberVO();
				vo.setMember_id(member_id);
				vo.setMember_dob(member_dob);
				MemberVO chkinfo = memberService.getinfo(vo);
				if (chkinfo != null) {
					return new ModelAndView("home"); 
				}else {
				    response.setCharacterEncoding("UTF-8");
			        response.setContentType("text/html; charset=utf-8");
			        PrintWriter out = response.getWriter();
			        out.println("<script> alert('추가 정보 입력이 필요합니다. 추가정보 입력칸으로 이동하겠습니다.'); window.location.href='sns_update_naver_form.do';</script>");
			        out.close();
					return new ModelAndView("hu/snsInfo_naver");
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	  }
	  
	   @RequestMapping("logout_form.do")
	   public ModelAndView getLogOut(HttpSession session) {
		   try {
			   //session.invalidate();
			   session.removeAttribute("memberInfo");
			   session.removeAttribute("admin");
			   session.removeAttribute("kakaoMemberInfo");
			   session.removeAttribute("naverMemberInfo");
			   session.removeAttribute("requestPage");
			   return new ModelAndView("redirect:/");
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

	          int count = commBoardService.getTotalCount();
	          paging.setTotalRecord(count);

	          if (paging.getTotalRecord() <= paging.getNumPerPage()) {
	              paging.setTotalPage(1);
	          } else {
	              paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage());
	              if (paging.getTotalRecord() % paging.getNumPerPage() != 0) {
	                  paging.setTotalPage(paging.getTotalPage() + 1);
	              }
	          }

	          String cPage = request.getParameter("cPage");
	          if (cPage == null) {
	              paging.setNowPage(1);
	          } else {
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
	          
	          // 필터를 써서 골라내기
	          List<CommBoardVO> selected_CommBoard_List = commBoard_list.stream()
	                  .filter(k -> "1".equals(k.getB_active()))
	                  .collect(Collectors.toList());

	          MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
	          AdminMembVO adminInfo = (AdminMembVO) session.getAttribute("admin");
	          MemberVO kakaoMemberInfo = (MemberVO) session.getAttribute("kakaoMemberInfo");
	          MemberVO naverMemberInfo = (MemberVO) session.getAttribute("naverMemberInfo");

	          CommBoardVO cbvo = new CommBoardVO();

	          if (memberInfo != null) {
	              cbvo.setMember_idx(memberInfo.getMember_idx());
	          }

	          if (memberInfo != null) {
	              cbvo.setMember_grade(memberInfo.getMember_grade());
	          }

	          if (adminInfo != null) {
	              cbvo.setMember_idx(adminInfo.getAdmin_idx());
	          }

	          if (!selected_CommBoard_List.isEmpty()) {
	              mv.addObject("commBoard_list", selected_CommBoard_List);
	              mv.addObject("paging", paging);
	              mv.addObject("memberInfo", memberInfo);
	              mv.addObject("adminInfo", adminInfo);
	              mv.addObject("kakaoMemberInfo", kakaoMemberInfo);
	              mv.addObject("naverMemberInfo", naverMemberInfo);
	              return mv;
	          } else {
	              return new ModelAndView("hu/boardFree/communityBoard");
	          }
	      } catch (Exception e) {
	          System.out.println(e);
	      }
	      return new ModelAndView("hu/boardFree/error");
	  }

	  //관리자가 자유게시판 회원 글 숨기기
	  @RequestMapping("community_board_content_hide_update.do")
	  public ModelAndView getCommunityBoardContentHideUpdate(String cPage, String b_idx, CommBoardVO cbvo, HttpServletRequest request) {
		  try {
			ModelAndView mv = new ModelAndView("redirect:admin_community_board.do");
			
			
			System.out.println("글 숨기는것" + b_idx);
			
			int result = commBoardService.getCommunityBoardContentHideUpdate(b_idx);
			
			if(result > 0) {
				mv.addObject("paging", paging);
				mv.addObject("b_idx", b_idx);
				mv.addObject("cPage", cPage);
				return mv;
			}
					
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	  }
	  
	  //관리자가 자유 게시판 회원 글 보이게 하기
	  @RequestMapping("community_board_content_show_update.do")
	  public ModelAndView getCommunityBoardContentShowUpdate(String cPage, String b_idx, CommBoardVO cbvo, HttpServletRequest request) {
		  try {
			ModelAndView mv = new ModelAndView("redirect:admin_community_board.do");
			
			
			System.out.println("글 보이는것 " + b_idx);
			
			int result = commBoardService.getCommunityBoardContentShowUpdate(b_idx);
			
			if(result > 0) {
				mv.addObject("paging", paging);
				mv.addObject("b_idx", b_idx);
				mv.addObject("cPage", cPage);
				return mv;
			}
					
		} catch (Exception e) {
			System.out.println(e);
		}
		return null;
	  }
	  
	  @RequestMapping("comm_board_write.do")
	  public ModelAndView getBoardWrite(HttpSession session) {
		  try {
			  ModelAndView mv = new ModelAndView("hu/boardFree/communityBoardWrite");
			  
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
	  
	  @RequestMapping("comm_board_write_ok.do")
	  public ModelAndView getCommBoardWriteOk(CommBoardVO cbvo, String b_idx, HttpServletRequest request, HttpSession session) {
		  try {
			  ModelAndView mv = new ModelAndView("redirect:community_board.do");
			  
			  MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			  AdminMembVO adminInfo = (AdminMembVO) session.getAttribute("admin");
			  MemberVO kakaoMemberInfo = (MemberVO) session.getAttribute("kakaoMemberInfo");
			  MemberVO naverMemberInfo = (MemberVO) session.getAttribute("naverMemberInfo");
			 
			  String path = request.getSession().getServletContext().getRealPath("/resources/upload");
			  MultipartFile file = cbvo.getFile();
			  
			  //일반회원 글쓰기
			  if(memberInfo != null) {
				  cbvo.setMember_idx(memberInfo.getMember_idx());
				  cbvo.setMember_grade(memberInfo.getMember_grade());
			   
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
				  
				  if(true) {				  
					  //자유 게시판에 글쓸때 마다 member_free 등급 올리기
					  String member_idx = cbvo.getMember_idx();
					  int result2 = memberService.getMemberFreeUpdate(member_idx);
					  
					  String member_idx2 = memberInfo.getMember_idx();
					  MemberVO mvo = memberService.getMemeberDetail(member_idx2);
					  cbvo.setMember_grade(mvo.getMember_grade());
				
					  if(mvo.getMember_free() < 2) {
						  int result3 = memberService.getUpdateMemberGrade(member_idx2);
						  
					  }else if(mvo.getMember_free() >= 2 && mvo.getMember_free() < 4) {	
						  
						  int result3 = memberService.getUpdateMemberGrade2(member_idx2);	
						  
					  }else if(mvo.getMember_free() >= 4 && mvo.getMember_free() < 6) {	
						  
						  int result3 = memberService.getUpdateMemberGrade3(member_idx2);
						  
					  }else if(mvo.getMember_free() >= 6 && mvo.getMember_free() < 8) {  
						  
						  int result3 = memberService.getUpdateMemberGrade4(member_idx2);	
						  
					  }else if(mvo.getMember_free() > 8) {	  
						  
						  int result3 = memberService.getUpdateMemberGrade5(member_idx2);
					  } 
					  cbvo.setMember_grade(mvo.getMember_grade());
					  int result = commBoardService.getCommBoardInsert(cbvo);
					  
					  if(result > 0) {
						 // 회원 최대 등급 구하기 
						 int res = commBoardService.getMemberGrade(member_idx2);
						 
						 // 쵀대 등급으로 업데이트 하기 
						 int res2 = commBoardService.getGreadUpdate(member_idx2, res);
					  }
					  return mv;
				  }
			  }
			  //카카오회원 글쓰기
			  if(kakaoMemberInfo != null) {
				  
				  cbvo.setMember_idx(kakaoMemberInfo.getMember_idx());
				 //cbvo.setMember_grade(memberInfo.getMember_grade());
				  
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
				  
				  if(true) {
				
					  //자유 게시판에 글쓸때 마다 member_free 등급 올리기
					  String member_idx = cbvo.getMember_idx();
					  int result2 = memberService.getMemberFreeUpdate(member_idx);
					  
					  String member_idx2 = kakaoMemberInfo.getMember_idx();
					  MemberVO mvo = memberService.getMemeberDetail(member_idx2);
					  cbvo.setMember_grade(mvo.getMember_grade());
					  
					  if(mvo.getMember_free() < 2) {
						  int result3 = memberService.getUpdateMemberGrade(member_idx2);
						  
					  }else if(mvo.getMember_free() >= 2 && mvo.getMember_free() < 4) {	
						  
						  int result3 = memberService.getUpdateMemberGrade2(member_idx2);	
						  
					  }else if(mvo.getMember_free() >= 4 && mvo.getMember_free() < 6) {	
						  
						  int result3 = memberService.getUpdateMemberGrade3(member_idx2);
						  
					  }else if(mvo.getMember_free() >= 6 && mvo.getMember_free() < 8) {  
						  
						  int result3 = memberService.getUpdateMemberGrade4(member_idx2);	
						  
					  }else if(mvo.getMember_free() > 8) {	  
						  
						  int result3 = memberService.getUpdateMemberGrade5(member_idx2);
					  }
					  cbvo.setMember_grade(mvo.getMember_grade());
					  int result = commBoardService.getCommBoardInsert(cbvo);
					  
					  if(result > 0) {
						 // 최대 권한 구하기 
						 int res = commBoardService.getMemberGrade(member_idx2);
						 
						 // 쵀대 권한으로 업데이트 하기 
						 int res2 = commBoardService.getGreadUpdate(member_idx2, res);
					  }				  
					  return mv;
				  } 
			  }
			  
			  //네이버회원 글쓰기
			  if(naverMemberInfo != null) {
				  
				  cbvo.setMember_idx(naverMemberInfo.getMember_idx());
				 //cbvo.setMember_grade(memberInfo.getMember_grade());
				  
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
				  
				  if(true) {
				
					  //자유 게시판에 글쓸때 마다 member_free 등급 올리기
					  String member_idx = cbvo.getMember_idx();
					  int result2 = memberService.getMemberFreeUpdate(member_idx);
					  
					  String member_idx2 = naverMemberInfo.getMember_idx();
					  MemberVO mvo = memberService.getMemeberDetail(member_idx2);
					  cbvo.setMember_grade(mvo.getMember_grade());
					  
					  if(mvo.getMember_free() < 2) {
						  int result3 = memberService.getUpdateMemberGrade(member_idx2);
						  
					  }else if(mvo.getMember_free() >= 2 && mvo.getMember_free() < 4) {	
						  
						  int result3 = memberService.getUpdateMemberGrade2(member_idx2);	
						  
					  }else if(mvo.getMember_free() >= 4 && mvo.getMember_free() < 6) {	
						  
						  int result3 = memberService.getUpdateMemberGrade3(member_idx2);
						  
					  }else if(mvo.getMember_free() >= 6 && mvo.getMember_free() < 8) {  
						  
						  int result3 = memberService.getUpdateMemberGrade4(member_idx2);	
						  
					  }else if(mvo.getMember_free() > 8) {	  
						  
						  int result3 = memberService.getUpdateMemberGrade5(member_idx2);
					  }
					  cbvo.setMember_grade(mvo.getMember_grade());
					  int result = commBoardService.getCommBoardInsert(cbvo);
					  
					  if(result > 0) {
						 // 최대 권한 구하기 
						 int res = commBoardService.getMemberGrade(member_idx2);
						 
						 // 쵀대 권한으로 업데이트 하기 
						 int res2 = commBoardService.getGreadUpdate(member_idx2, res);
					  }				  
					  return mv;
				  } 
			  }
			  
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
	  
	  @RequestMapping("commBoard_detail.do")
	  public ModelAndView getCommBoardDetail(@ModelAttribute("cPage") String cPage, String b_idx, HttpSession session) {
		  try {
			  ModelAndView mv = new ModelAndView("hu/boardFree/communityBoardDetail");
			  
			  MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			  AdminMembVO adminInfo = (AdminMembVO) session.getAttribute("admin");
			  MemberVO kakaoMemberInfo = (MemberVO) session.getAttribute("kakaoMemberInfo");
			  MemberVO naverMemberInfo = (MemberVO) session.getAttribute("naverMemberInfo");
			  
			  int result = commBoardService.getCommBoardHit(b_idx);
			  
			  if(memberInfo != null) {
				  CommBoardVO cbvo = commBoardService.getCommBoardDetail(b_idx);
				  cbvo.setMember_idx(memberInfo.getMember_idx());
				  
				  if(result > 0 && cbvo != null && cbvo.getMember_idx().equals(memberInfo.getMember_idx())) {  
					  mv.addObject("cbvo", cbvo);
					  mv.addObject("memberInfo", memberInfo);
					  mv.addObject("adminInfo", adminInfo);
					  return mv;
				  }  
			  }
			  if(adminInfo != null) {
				  CommBoardVO cbvo = commBoardService.getCommBoardDetail(b_idx);
				  cbvo.setAdmin_idx(adminInfo.getAdmin_idx());
				  
				  if(result > 0 && cbvo != null && cbvo.getAdmin_idx().equals(adminInfo.getAdmin_idx())) {
					  mv.addObject("cbvo", cbvo);
					  mv.addObject("memberInfo", memberInfo);
					  mv.addObject("adminInfo", adminInfo);
					  return mv;
				  }  
			  }
			  if(kakaoMemberInfo != null) {
				  CommBoardVO cbvo = commBoardService.getCommBoardDetail(b_idx);
				  cbvo.setMember_idx(kakaoMemberInfo.getMember_idx());
				  
				  if(result > 0 && cbvo != null && cbvo.getMember_idx().equals(kakaoMemberInfo.getMember_idx())) {
					  mv.addObject("cbvo", cbvo);
					  mv.addObject("memberInfo", memberInfo);
					  mv.addObject("adminInfo", adminInfo);
					  mv.addObject("kakaoMemberInfo", kakaoMemberInfo);
					  return mv;
				  }  
			  }
			  if(naverMemberInfo != null) {
				  CommBoardVO cbvo = commBoardService.getCommBoardDetail(b_idx);
				  cbvo.setMember_idx(naverMemberInfo.getMember_idx());
				  
				  if(result > 0 && cbvo != null && cbvo.getMember_idx().equals(naverMemberInfo.getMember_idx())) {
					  mv.addObject("cbvo", cbvo);
					  mv.addObject("memberInfo", memberInfo);
					  mv.addObject("adminInfo", adminInfo);
					  mv.addObject("naverMemberInfo", naverMemberInfo);
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
	  
	  	//댓글입력 저장
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
	  
	  //관리자 강제삭제
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

		  CommBoardVO cbvo2 = commBoardService.getCommBoardDetail(cbvo.getB_idx());
		  	
		  String dpwd = cbvo2.getB_pwd();

		  if (!passwordEncoder.matches(cbvo.getB_pwd(), dpwd)) { 
		       mv.setViewName("hu/boardFree/communityBoardDelete");
			   mv.addObject("pwdchk", "fail");
			   return mv;
		   } else {
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
				cbvo.setBf_name(cbvo.getOld_f_name());
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
	  	
	  	
	  	 @RequestMapping("comm_board_reply_ok.do")
		   public ModelAndView getBbsDetail(String b_idx, String cPage, HttpSession session) {
			  
			   ModelAndView mv = new ModelAndView("hu/boardFree/communityBoardContent");
			  
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
	
		@RequestMapping("comment_reply_insert.do")
		public ModelAndView getCommentReplyInsert(CommentVO cvo, String cPage, @ModelAttribute("b_idx")String b_idx, HttpSession session) {
			ModelAndView mv = new ModelAndView("redirect:comm_board_reply_ok.do");
			
			MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			AdminMembVO adminInfo = (AdminMembVO) session.getAttribute("admin");
			MemberVO kakaoMemberInfo = (MemberVO) session.getAttribute("kakaoMemberInfo");
			MemberVO naverMemberInfo = (MemberVO) session.getAttribute("naverMemberInfo");
			 
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
				mv.addObject("adminInfo", adminInfo);
				mv.addObject("kakaoMemberInfo", kakaoMemberInfo);
				mv.addObject("naverMemberInfo", naverMemberInfo);
				mv.addObject("adminInfo", adminInfo);
				mv.addObject("cPage", cPage);
				return mv;
			}
			return new ModelAndView("hu/boardFree/error");
		}
	  	
	   @RequestMapping("board_free_list_go.do")
	   public ModelAndView getBoardFreeSearch() {
		 try {
			ModelAndView mv = new ModelAndView("hu/boardFree/boardFreeList");
			
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
	   
	   
	   @RequestMapping("sns_update_form.do")
		   public ModelAndView sns_update_form() {
			   return new ModelAndView("hu/snsInfo");
		   }
	   @RequestMapping("sns_update_naver_form.do")
	   public ModelAndView sns_update_naver_form() {
		   return new ModelAndView("hu/snsInfo_naver");
	   }
	   @RequestMapping("sns_update.do")
	   public ModelAndView setUpdateSnsInfo(MemberVO mvo, HttpServletRequest request,HttpSession session,HttpServletResponse response) {
			MemberVO mvo2 = (MemberVO) session.getAttribute("memberInfo");
		   try {
				  ModelAndView mv = new ModelAndView();
				  mv.addObject("mvo",mvo2);
				  String member_id = mvo2.getMember_id();
				  String member_name = request.getParameter("member_name");
				  String member_dob = request.getParameter("member_dob");
				  String member_gender = request.getParameter("member_gender");
				  String member_pwd = request.getParameter("member_pwd");
				  String member_phone = request.getParameter("member_phone");
				  
				  String member_encrypt_pwd = passwordEncoder.encode(member_pwd);
				  
				  MemberVO vo = new MemberVO();
				  vo.setMember_name(member_name);
				  vo.setMember_dob(member_dob);
				  vo.setMember_gender(member_gender);
				  vo.setMember_pwd(member_encrypt_pwd);
				  vo.setMember_phone(member_phone);
				  vo.setMember_id(member_id);
				  int result = memberService.setUpdateSnsInfo(vo);
				  if (result > 0) {
					 response.setCharacterEncoding("UTF-8");
				     response.setContentType("text/html; charset=utf-8");
				     PrintWriter out = response.getWriter();
				     out.println("<script> alert('성공적으로 수정하였습니다 다시 로그인 해주세요.'); window.location.href='logout_form.do';</script>");
				     out.close();
				}

			  }catch (Exception e) {
				System.out.println(e);
			}
			return new ModelAndView("home");
		  }
	   
	   @RequestMapping("sns_update_naver.do")
	   public ModelAndView setUpdateSnsInfo_naver(MemberVO mvo, HttpServletRequest request,HttpSession session,HttpServletResponse response) {
		   MemberVO mvo2 = (MemberVO) session.getAttribute("memberInfo");
		   try {
			   ModelAndView mv = new ModelAndView();
			   mv.addObject("mvo",mvo2);
			   String member_id = mvo2.getMember_id();
			   String member_nickname = request.getParameter("member_nickname");
			   String member_dob = request.getParameter("member_dob");
			   String member_gender = request.getParameter("member_gender");
			   String member_pwd = request.getParameter("member_pwd");
			   String member_phone = request.getParameter("member_phone");
			   
			   String member_encrypt_pwd = passwordEncoder.encode(member_pwd);
			   
			   MemberVO vo = new MemberVO();
			   vo.setMember_nickname(member_nickname);
			   vo.setMember_dob(member_dob);
			   vo.setMember_gender(member_gender);
			   vo.setMember_pwd(member_encrypt_pwd);
			   vo.setMember_phone(member_phone);
			   vo.setMember_id(member_id);
			   int result = memberService.setUpdateSnsInfo_naver(vo);
			   if (result > 0) {
				   response.setCharacterEncoding("UTF-8");
				   response.setContentType("text/html; charset=utf-8");
				   PrintWriter out = response.getWriter();
				   out.println("<script> alert('성공적으로 수정하였습니다 다시 로그인 해주세요.'); window.location.href='logout_form.do';</script>");
				   out.close();
			   }
			   
		   }catch (Exception e) {
			   System.out.println(e);
		   }
		   return new ModelAndView("home");
	   }

}