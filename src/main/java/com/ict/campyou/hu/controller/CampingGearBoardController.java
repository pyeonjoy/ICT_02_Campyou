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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.campyou.common.Paging;
import com.ict.campyou.hu.dao.CampingGearBoardVO;
import com.ict.campyou.hu.dao.CampingGearSearchVO;
import com.ict.campyou.hu.dao.BoardFreeVO;
import com.ict.campyou.hu.dao.CampingGearBoardCommentVO;
import com.ict.campyou.hu.dao.CommBoardVO;
import com.ict.campyou.hu.dao.CommentVO;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.hu.service.CampingGearBoardService;
import com.ict.campyou.hu.service.CampingGearSearchService;
import com.ict.campyou.hu.service.MemberService;

@Controller
public class CampingGearBoardController {
	@Autowired
	private CampingGearBoardService campingGearBoardService;
	
	@Autowired
	private CampingGearSearchService campingGearSearchService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private Paging paging;
	
	 @RequestMapping("camping_gear_board.do")
	  public ModelAndView getCampingGearBoard(HttpServletRequest request, HttpSession session) {
		  try {
			  ModelAndView mv = new ModelAndView("hu/campingGearBoard/campingGearBoard");
			  
			
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
			  CampingGearBoardVO cgbvo = new CampingGearBoardVO();
			  
			  if(memberInfo != null) {
				  cgbvo.setMember_idx(memberInfo.getMember_idx());
			  }
			  
			  if (camping_gear_list != null) {
					mv.addObject("camping_gear_list", camping_gear_list);
					mv.addObject("paging", paging);
					mv.addObject("memberInfo", memberInfo);
					return mv;
				}
				return new ModelAndView("hu/campingGearBoard/error");
		} catch (Exception e) {
			System.out.println(e);
		}
		return new ModelAndView("hu/campingGearBoard/error");
	  }
	 
	 @RequestMapping("camping_gear_write.do")
	  public ModelAndView getCampingGearWrite(HttpSession session) {
		  try {
			  ModelAndView mv = new ModelAndView("hu/campingGearBoard/campingGearWrite");
			  
			  MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			  
			  if(memberInfo != null) {
				  mv.addObject("memberInfo", memberInfo);
				  return mv;
			  }
		  } catch (Exception e) {
			  System.out.println(e);
		  }
		  return new ModelAndView("hu/campingGearBoard/error");
	  }
	 
	 @RequestMapping("camping_gear_write_ok.do")
	  public ModelAndView getCampingGearWriteOk(CampingGearBoardVO cgbvo, HttpServletRequest request, HttpSession session) {
		  try {
			  ModelAndView mv = new ModelAndView("redirect:camping_gear_board.do");
			  
			  MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			  
			  String path = request.getSession().getServletContext().getRealPath("/resources/upload");
			  MultipartFile file = cgbvo.getFile();
			  
			  if(memberInfo != null) {
				  cgbvo.setMember_idx(memberInfo.getMember_idx());
				  
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
	 
	  @RequestMapping("camping_gear_detail.do")
	  public ModelAndView getCampingGearDetail(@ModelAttribute("cPage") String cPage, String cp_idx, HttpSession session) {
		  try {
			  ModelAndView mv = new ModelAndView("hu/campingGearBoard/campingGearDetail");
			  
			  MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			  
			  int result = campingGearBoardService.getCampingGearHit(cp_idx);
			  
			  if(memberInfo != null) {
		
				  CampingGearBoardVO cgbvo = campingGearBoardService.getCampingGearDetail(cp_idx);
				  
				  cgbvo.setMember_idx(memberInfo.getMember_idx());
				  //cbvo.setMember_nickname(memberInfo.getMember_nickname());

				  if(result > 0 && cgbvo != null && cgbvo.getMember_idx().equals(memberInfo.getMember_idx())) {
					  mv.addObject("cgbvo", cgbvo);
					  mv.addObject("memberInfo", memberInfo);
					  //mv.addObject("member_nickname", memberInfo.getMember_nickname());
					  return mv;
				  }  
			  }
		  } catch (Exception e) {
			System.out.println(e);
		  }
		  return new ModelAndView("hu/campingGearBoard/error");
	  }
	 
	  @RequestMapping("camping_gear_pics_down.do")
	  public void CampingGearPicsDown(HttpServletRequest request, HttpServletResponse response) {
		  try {
		  	  String f_name = request.getParameter("cpf_name");
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
	  
	  @RequestMapping("camping_gear_update.do")
	  public ModelAndView getCampingGearUpdate(@ModelAttribute("cPage") String cPage, @ModelAttribute("cp_idx") String cp_idx) {
		  
		  ModelAndView mv = new ModelAndView("hu/campingGearBoard/campingGearUpdate");
		  
		  CampingGearBoardVO cgbvo = campingGearBoardService.getCampingGearDetail(cp_idx);
		  if(cgbvo != null) {
			  mv.addObject("cgbvo", cgbvo);
			  return mv;
		  }
		  return new ModelAndView("hu/campingGearBoard/error");
	  }
	  
	  	@RequestMapping("camping_gear_update_ok.do")
		public ModelAndView getCampingGearUpdateOK(@ModelAttribute("cPage")String cPage, @ModelAttribute("cp_idx")String cp_idx,
												  CampingGearBoardVO cgbvo, HttpServletRequest request) {
			ModelAndView mv = new ModelAndView();
			CampingGearBoardVO cgbvo2 = campingGearBoardService.getCampingGearDetail(cgbvo.getCp_idx());
			String dpwd = cgbvo2.getCp_pwd();
			
			if(! passwordEncoder.matches(cgbvo.getCp_pwd(), dpwd)) {
				cgbvo.setCpf_name(cgbvo.getOld_f_name());
				mv.addObject("pwchk", "fail");
				mv.addObject("cgbvo", cgbvo);
				mv.setViewName("hu/campingGearBoard/campingGearUpdate");
				return mv;
			}else {
				try {
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
						mv.setViewName("redirect:camping_gear_detail.do");
						return mv;
					}
				} catch (Exception e) {
					System.out.println(e);
				}
			}
			return new ModelAndView("hu/campingGearBoard/error");
		}
	  	
	  	 @RequestMapping("camping_gear_delete.do")
		  public ModelAndView getCampingGearDelete(@ModelAttribute("cPage") String cPage, @ModelAttribute("cp_idx") String cp_idx) {
			  try {
				  ModelAndView mv = new ModelAndView("hu/campingGearBoard/campingGearDelete");
				  mv.addObject("cPage", cPage);
				  return mv;
			  } catch (Exception e) {
				  System.out.println(e);
			  }
			  return new ModelAndView("hu/campingGearBoard/error");
		  }
	  	 
	  	 @RequestMapping("camping_gear_delete_ok.do")
		  public ModelAndView getCampingGearDeleteOk(@ModelAttribute("cPage") String cPage, 
					                           @ModelAttribute("cp_idx")String cp_idx, CampingGearBoardVO cgbvo) {
			  ModelAndView mv = new ModelAndView();

			  CampingGearBoardVO cgbvo2 = campingGearBoardService.getCampingGearDetail(cgbvo.getCp_idx());
			  	
			  String dpwd = cgbvo2.getCp_pwd();

			  if (!passwordEncoder.matches(cgbvo.getCp_pwd(), dpwd)) { 
			       mv.setViewName("hu/campingGearBoard/campingGearDelete");
				   mv.addObject("pwdchk", "fail");
				   return mv;
			   } else {
				   int result = campingGearBoardService.getCampingGearDelete(cgbvo2);
				   if (result > 0) {
					   mv.setViewName("redirect:camping_gear_board.do");
						return mv;
					}
				}
				return new ModelAndView("hu/boardFree/error");
			}
	  	
		  @RequestMapping("camping_gear_admin_delete.do")
		  public ModelAndView getCommBoardAdminDelete(String c_idx, String cPage, @ModelAttribute("cp_idx") String cp_idx) {
			  ModelAndView mv =  new ModelAndView("redirect:camping_gear_board.do");
			  int result = campingGearBoardService.getCampingGearAdminDelete(cp_idx);
			  if(result > 0) {
				  mv.addObject("cPage", cPage);
				  return mv;
			  }
			  return mv;
		  }
	  	
	  	@RequestMapping("camping_gear_content.do")
	  	public ModelAndView getCommBoardContent(@ModelAttribute("cPage") String cPage, String cp_idx, HttpSession session) {
	  		try {
	  			ModelAndView mv = new ModelAndView("hu/campingGearBoard/campingGearContent");
				MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
				  
				  int result = campingGearBoardService.getCampingGearHit(cp_idx);
				  
				  if(memberInfo == null) {
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
					  //cbvo.setMember_nickname(memberInfo.getMember_nickname());

					  if(result > 0 && cgbvo != null && cgbvo.getMember_idx().equals(memberInfo.getMember_idx())) {
						  List<CampingGearBoardCommentVO> camping_gear_list2 = campingGearBoardService.getCampingGearList2(cp_idx);
						  mv.addObject("camping_gear_list2", camping_gear_list2);
						  mv.addObject("cgbvo", cgbvo);
						  mv.addObject("memberInfo", memberInfo);
						 // mv.addObject("member_nickname", memberInfo.getMember_nickname());
						  return mv;
					  }  
				  }
			  } catch (Exception e) {
				System.out.println(e);
			  }
			  return new ModelAndView("hu/campingGearBoard/error");
	  	}
	  	
	  	@RequestMapping("cgb_comment_insert.do")
		public ModelAndView getCampingGearBoardCommentInsert(CampingGearBoardCommentVO cgbvo, String cPage, @ModelAttribute("cp_idx")String cp_idx) {
			ModelAndView mv = new ModelAndView("redirect:cgb_board_reply_ok.do");
			
			int result = campingGearBoardService.getCampingGearCommentInsert(cgbvo);
			if(result > 0) {
				mv.addObject("cPage", cPage);
				return mv;
			}
			return new ModelAndView("hu/campingGearBoard/error");
		}
	  	
		@RequestMapping("cgb_comment_delete.do")
		public ModelAndView getCampingGearBoardCommentDelete(String c_idx, String cPage, @ModelAttribute("cp_idx")String cp_idx) {
			ModelAndView mv =  new ModelAndView("redirect:cgb_board_reply_ok.do");
			int result = campingGearBoardService.getCampingGearCommentDelete(c_idx);
			if(result > 0) {
				mv.addObject("cPage", cPage);
				return mv;
			}
			return new ModelAndView("hu/campingGearBoard/error");
		}
		
		@RequestMapping("cgb_comment_update.do")
		public ModelAndView getCampingGearBoardCommentUpdate(CampingGearBoardCommentVO cgbvo, String c_idx, String cPage, String content, @ModelAttribute("cp_idx")String cp_idx) {
			ModelAndView mv =  new ModelAndView("redirect:cgb_board_reply_ok.do");
			
			int result = campingGearBoardService.getCampingGearCommentUpdate(cgbvo);
			if(result > 0) {
				mv.addObject("cPage", cPage);
				return mv;
			}
			return new ModelAndView("hu/campingGearBoard/error");
		}
		
	  	 @RequestMapping("cgb_board_reply_ok.do")
		   public ModelAndView getBbsDetail(String cp_idx, String cPage, HttpSession session) {
			  
			   ModelAndView mv = new ModelAndView("hu/campingGearBoard/campingGearContent");
			  
			   MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
			  
			  // int result = campingGearBoardService.getCommBoardHit(cp_idx);
			   int result = campingGearBoardService.getCampingGearHit(cp_idx);
			  
			   //CommBoardVO cbvo = campingGearBoardService.getCommBoardDetail(cp_idx);
			   CampingGearBoardVO cgbvo = campingGearBoardService.getCampingGearDetail(cp_idx);
			  
				
			   if(result>0 && cgbvo != null) {
				   List<CampingGearBoardCommentVO> camping_gear_list2 = campingGearBoardService.getCampingGearList2(cp_idx);
				   mv.addObject("camping_gear_list2", camping_gear_list2);
				   mv.addObject("memberInfo", memberInfo);
				   mv.addObject("cgbvo", cgbvo);
				   mv.addObject("cPage", cPage);
			 	   return mv;
			   }
			   return new ModelAndView("hu/campingGearBoard/error");
		   }

			@RequestMapping("cgb_comment_reply_insert.do")
			public ModelAndView getCommentReplyInsert(CampingGearBoardCommentVO cgbvo, String cPage, @ModelAttribute("cp_idx")String cp_idx, HttpSession session) {
				ModelAndView mv = new ModelAndView("redirect:cgb_board_reply_ok.do");
				
				MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
				 
				List<CampingGearBoardCommentVO> lcgbcvo = campingGearBoardService.getCampingGearCommentReplyList(cp_idx);
				
				//CommentVO cvo2 = commBoardService.getCommentReplyDetail(cvo.getC_idx());
				CampingGearBoardCommentVO cgbvo2 = campingGearBoardService.getCampingGearDetail2(cgbvo.getC_idx());
				
				int groups = Integer.parseInt(cgbvo2.getGroups());
	    		int step = Integer.parseInt(cgbvo2.getStep());
				int lev = Integer.parseInt(cgbvo2.getLev());
				
				step++;
				lev++;
			
				Map<String, Integer> map = new HashMap<String, Integer>();
				map.put("groups", groups);
				map.put("lev", lev);
				
				int result = campingGearBoardService.getLevUpdate(map);
				
				cgbvo.setGroups(String.valueOf(groups));
				cgbvo.setStep(String.valueOf(step));
				cgbvo.setLev(String.valueOf(lev));
				
				int result2 = campingGearBoardService.getAnsInsert(cgbvo);
				if(result2 > 0) {
					mv.addObject("lcgbcvo", lcgbcvo);
					mv.addObject("memberInfo", memberInfo);
					mv.addObject("cPage", cPage);
					return mv;
				}
				return new ModelAndView("hu/campingGearBoard/error");
			}
			
		   @RequestMapping("camping_gear_list_go.do")
		   public ModelAndView getCampingGearSearch() {
			 try {
				ModelAndView mv = new ModelAndView("hu/campingGearBoard/campingGearList");
				
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
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   //�Խ��� �˻� 
		   @RequestMapping("camping_gear_search.do")
		   public ModelAndView getCampingGearSearchList(@ModelAttribute("cp_idx")String cp_idx, String keyword) {
			   try {
					ModelAndView mv = new ModelAndView("hu/campingGearBoard/campingGearSearchList");
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
		   
		    
		   /*
		      @RequestMapping("camping_gear_search.do")
			  public ModelAndView getCampingGearSearchList(HttpServletRequest request, HttpSession session, @ModelAttribute("cp_idx")String cp_idx, String keyword) {
				  try {
					  ModelAndView mv = new ModelAndView("hu/campingGearBoard/campingGearSearchList");
					  
					  //����¡ ��� & ��ü �Խù� ��
					  int count = campingGearBoardService.getTotalCount();
					  paging.setTotalRecord(count);
					  
					  //��ü ������ ��
					  if(paging.getTotalRecord() <= paging.getNumPerPage()) {
						  paging.setTotalPage(1);
					  }else {
						  //��ü ������ �� (DB�Խù� �� / ���������� 10��)
						  paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage());
						  // (DB�Խù� �� % ���������� 10�� != 0) �̸� 1pg�� ���Ѵ�.
						  if(paging.getTotalRecord() % paging.getNumPerPage() != 0) {
							  paging.setTotalPage(paging.getTotalPage() + 1);
						  }
					  }
					  
					  //���� ������ ����
					  String cPage = request.getParameter("cPage");
					  if(cPage == null) {
						  paging.setNowPage(1);
					  }else {
						  paging.setNowPage(Integer.parseInt(cPage));
					  }
					  
					  // begin, end ���ϱ� (Oracle)
					  // offset ���ϱ�
					  // offset = limit * (����������-1);
					  paging.setOffset(paging.getNumPerPage() * (paging.getNowPage() - 1));
					  
					  //���� ��� // �����
					  paging.setBeginBlock(
								(int) ((paging.getNowPage() - 1) / paging.getPagePerBlock()) * paging.getPagePerBlock() + 1);
						paging.setEndBlock(paging.getBeginBlock() + paging.getPagePerBlock() - 1);
						
					  if (paging.getEndBlock() > paging.getTotalPage()) {
						  paging.setEndBlock(paging.getTotalPage());
					  }
					  
					  List<CampingGearBoardVO> camping_gear_list = campingGearBoardService.getCampingGearList(paging.getOffset(), paging.getNumPerPage());
					  
					  List<CampingGearSearchVO> searchlist = campingGearSearchService.getCampingGearSearchListOk(cp_idx, keyword);
					  
					  //�ɹ����� ���� �θ���
					  MemberVO memberInfo = (MemberVO) session.getAttribute("memberInfo");
					  //CampingGearBoardVO cgbvo = new CampingGearBoardVO();
					  
					  //if(memberInfo != null) {
						  //�ɹ����� ������ ���
					//	  cgbvo.setMember_idx(memberInfo.getMember_idx());
					 // }
					  
					  if (camping_gear_list != null) {
							mv.addObject("camping_gear_list", camping_gear_list);
							mv.addObject("searchlist", searchlist);
							mv.addObject("paging", paging);
							mv.addObject("memberInfo", memberInfo);
							return mv;
						}
						return new ModelAndView("hu/campingGearBoard/error");
				} catch (Exception e) {
					System.out.println(e);
				}
				return new ModelAndView("hu/campingGearBoard/error");
			  }
		   
		   */
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
}
