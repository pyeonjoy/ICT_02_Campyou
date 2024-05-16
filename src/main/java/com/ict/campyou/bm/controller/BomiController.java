package com.ict.campyou.bm.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.ict.campyou.bjs.dao.TogetherVO;
import com.ict.campyou.bjs.service.TogetherService;
import com.ict.campyou.bm.dao.BoardsVO;
import com.ict.campyou.bm.dao.ChatVO;
import com.ict.campyou.bm.dao.FaqVO;
import com.ict.campyou.bm.dao.PasswordCheckRequest;
import com.ict.campyou.bm.dao.QnaVO;
import com.ict.campyou.bm.service.MyService;
import com.ict.campyou.common.Paging;
import com.ict.campyou.hu.dao.BoardFreeVO;
import com.ict.campyou.hu.dao.CampingGearBoardVO;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.jun.dao.CampVO;
import com.ict.campyou.jun.dao.HeartVO;


@Controller
public class BomiController {

	@Autowired
	private MyService myService;

	@Autowired
	private TogetherService togetherService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private Paging paging;

//	Simple page router	
	@GetMapping("home.do")
	public ModelAndView gotoMainPage() {
		ModelAndView mv = new ModelAndView("home");
		return mv;
	}

	@GetMapping("my_main.do")
	public ModelAndView gotoMypage(HttpSession session) {
		ModelAndView mv = new ModelAndView("bm/my_main");
		MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
		String member_idx = mvo.getMember_idx();
		List<HeartVO> favlist = myService.getFavList(member_idx);
		List<BoardFreeVO> board1 = myService.getBoard1(member_idx);
		List<CampingGearBoardVO> board2 = myService.getBoard2(member_idx);
		List<BoardsVO> boardsList = new ArrayList<>();
		Map<String, String> map = new HashMap<>();
		 int count = 0; 
		 for (HeartVO heart : favlist) {
		     if (count < 4) { 
		         CampVO cvo = myService.getMyFavoriteCamp(heart.getContentid());
		         map.put(heart.getContentid(), cvo.getFacltnm());
		         count++;
		     } else {
		         break; 
		     }
		 }
		 
		 for (BoardFreeVO board : board1) {
	            BoardsVO boardsVO = new BoardsVO();
	            boardsVO.setBoard_idx(board.getBf_no());
	            boardsVO.setMember_idx(member_idx);
	            boardsVO.setB_subject(board.getB_subject());
	            boardsVO.setB_regdate(board.getB_regdate());
	            boardsList.add(boardsVO);
	        }

        for (CampingGearBoardVO board : board2) {
            BoardsVO boardsVO = new BoardsVO();
            boardsVO.setBoard_idx(board.getCp_idx());
            boardsVO.setMember_idx(board.getMember_idx());
            boardsVO.setB_subject(board.getCp_subject());
            boardsVO.setB_regdate(board.getCp_regdate());
            boardsList.add(boardsVO);
        }
	        
	    List<BoardsVO> selectedList = myService.getSelectFour(boardsList);
	        
		mv.addObject("mvo", mvo);
		mv.addObject("campMap", map); 
		mv.addObject("selectedList", selectedList);

		return mv;
	}
	

//	@GetMapping("my_fav_list.do")
//	public ModelAndView myFavList(HttpSession session) {
//		ModelAndView mv = new ModelAndView("bm/my_fav_camping");
//		MemberVO member = (MemberVO) session.getAttribute("memberInfo");
//		String member_idx = member.getMember_idx();
//		List<HeartVO> favlist = myService.getFavList(member_idx);
//		List<CampVO> camps = new ArrayList<>();
//		 for (HeartVO heart : favlist) {
//		CampVO cvo = myService.getMyFavoriteCamp(heart.getContentid());
//		camps.add(cvo);
//		 }
//		 mv.addObject("camps", camps);
//		return mv;		
//	}
	
	 @GetMapping("campDetail.do")
	 public ModelAndView campDetail(@RequestParam("contentid")String contentid) {
		 ModelAndView mv = new ModelAndView("jun/camp_detail");
		 CampVO info = myService.getMyFavoriteCamp(contentid);
		 mv.addObject("info", info);
		return mv;
	 }
	
	@RequestMapping("my_change_pw.do")
	public ModelAndView gotoMy_changePw(@RequestParam("member_idx") String member_idx) {
		ModelAndView mv = new ModelAndView("bm/my_change_pw");
		mv.addObject("member_idx", member_idx);
		return mv;
	}
	
	@GetMapping("chat-list.do")
	public ModelAndView showChatList(HttpSession session) {
		  ModelAndView mv = new ModelAndView();
		  MemberVO mvo = (MemberVO) session.getAttribute("memberInfo"); //내정보
		  String member_idx = mvo.getMember_idx(); // 내 idx
			 List <ChatVO> list = myService.getChatList(member_idx);
		    mv.setViewName("bm/chat_list"); 
			mv.addObject("list", list);
			mv.addObject("member_idx", member_idx);
		    return mv;
	}
	
	@GetMapping("selectOneRoom.do")
	public ModelAndView selectOneRoom(@RequestParam("msg_room") String msg_room, HttpSession session) {
		ModelAndView mv = new ModelAndView("bm/chatroom2");
		MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");// 내정보
		String my_idx = mvo.getMember_idx();
		String [] array = msg_room.split("-");
		String open_idx = array[0];
		String join_idx = array[1];  //sender_idx = member_idx
		List <ChatVO> chatList = myService.getOneRoom(msg_room);
		MemberVO joiner = myService.getMember(join_idx);  // 나
		MemberVO opener = myService.getMember(open_idx); //상대방
		
		for (ChatVO chat : chatList) {
		    if (!chat.getSend_idx().equals(my_idx)) { 
		        chat.setMsg_read("0");
		      int res = myService.updateMsgRead(chat.getMsg_idx());
		    }
		}
		
		mv.addObject("chatList", chatList);
		mv.addObject("msg_room", msg_room);
		mv.addObject("joiner", joiner);
		mv.addObject("opener", opener);
		mv.addObject("my_idx", my_idx); // 내 idx가져가기

		return mv;
	}
	@GetMapping("chatroom.do")
	public ModelAndView gotoChatRoom(@RequestParam("t_idx") String t_idx, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		try {
			MemberVO joiner = (MemberVO) session.getAttribute("memberInfo"); //내정보
			String my_idx = joiner.getMember_idx(); // 내 idx
			TogetherVO tvo = togetherService.getTogetherDetail(t_idx); //채팅방의 캠핑정보
			String opener_idx = tvo.getMember_idx(); // 동행 올린 사람의 idx
			String room_name = tvo.getT_campname()+" "+tvo.getT_startdate()+"-"+tvo.getT_enddate();
			MemberVO opener = myService.getMember(opener_idx); //상대방정보
			String msg_room = opener_idx+'-'+ my_idx;   //동행구하는사람의 idx-채팅보내는사람의 idx
			List <ChatVO> chatList = myService.getOneRoom(msg_room);
			
			mv.addObject("chatList", chatList);
			mv.addObject("msg_room", msg_room);
			mv.addObject("joiner", joiner);
			mv.addObject("opener", opener);
			mv.addObject("my_idx", my_idx); // 내 idx가져가기
			if(chatList.isEmpty()) {
				mv.addObject("room_name", room_name);
				mv.setViewName("bm/chatroom");
			}
			else {
				mv.addObject("chatList", chatList);
				mv.setViewName("bm/chatroom2");
			}			
		} catch (Exception e) {
			System.out.println(e);
		}
		return mv;
	}
	
// get all data for faq	
	@GetMapping("my_faq.do")
	public ModelAndView gotoFaq(FaqVO fvo, FaqVO fvo2) {
		ModelAndView mv = new ModelAndView("bm/my_faq");
		List<FaqVO> faqs = myService.getFaqs();
		List<FaqVO> faqs2 = myService.getFaqs2();
		mv.addObject("faqs", faqs);
		mv.addObject("faqs2", faqs2);		
		return mv;
	}
	
	///////////////////////////////////////USER INFORMATION///////////////////////////////////////////////////////////

//	check my information  
	@GetMapping("my_info.do")
	public ModelAndView gotoMyinfo(HttpSession session) {
		ModelAndView mv = new ModelAndView("bm/my_info");
		MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
		String member_idx = mvo.getMember_idx();
		MemberVO mvo2 = myService.getMember(member_idx);

		mv.addObject("mvo", mvo2);
		return mv;
	}
	
	// change user information and save	
		@PostMapping("changeInfo.do")
		public ModelAndView changeUserInfo(MemberVO mvo, HttpServletRequest req) {
			try {
				ModelAndView mv = new ModelAndView("redirect:my_info.do");
				String path = req.getSession().getServletContext().getRealPath("/resources/uploadUser_img");

				MultipartFile file = mvo.getFile();
				
				File uploadFolder = new File(path);

		        if (!uploadFolder.exists()) {
		            boolean created = uploadFolder.mkdirs();
		            if (!created) {
		                System.out.println("폴더 생성에 실패했습니다.");
		            }
		        }
				String old_userImg = mvo.getMember_old_img();
				System.out.println(file);
				if (file.isEmpty()) {
					mvo.setMember_img(old_userImg);

				} else {
					UUID uuid = UUID.randomUUID();
					String filename = uuid.toString() + "_" + file.getOriginalFilename();
					mvo.setMember_img(filename);

					byte[] in = file.getBytes();
					File out = new File(path, filename);
					FileCopyUtils.copy(in, out);
				}

				int res = myService.changeUserInfo(mvo);
				System.out.println(res);
				if (res > 0) {
					return mv;
				}			
			} catch (Exception e) {
				e.printStackTrace();
			}
			return new ModelAndView("error");		
		}
		
		// password change 
		@RequestMapping("pwd_change.do")
		public ModelAndView changeUserPw(@RequestParam("member_idx") String member_idx, PasswordCheckRequest pwdcheck) {
			ModelAndView mv = new ModelAndView("redirect:my_info.do");
			String newPassword = pwdcheck.getPassword();

			MemberVO mvo = myService.getMember(member_idx);
			mvo.setMember_pwd(passwordEncoder.encode(newPassword));
			int res = myService.changeUserPW(mvo);
			System.out.println(res);
			if(res>0) {				
				return mv;
			}
			return new ModelAndView("redirect:pwd_change.do");			
		}
		// Delete User
		@GetMapping("deleteUser.do")
		public ModelAndView changeUserPw(@RequestParam("member_idx") String member_idx) {
			ModelAndView mv = new ModelAndView("redirect:home.do");
			int res = myService.deletMember(member_idx);
			return mv;
		}
		
		//////////////////////////////////////////HANDLING QNA ////////////////////////////////////////////////////
		
		// goto the page where user can write 
		@GetMapping("inquiry_form.do")
		public ModelAndView gotoFormWriting(@RequestParam("member_idx") String member_idx, HttpSession session) {
			ModelAndView mv = new ModelAndView("bm/my_inquiry_form");
			mv.addObject("member_idx", member_idx);
			return mv;
		}
		
		
		//After User complete writing 
		 @PostMapping("QnaUpload.do")
		    public ModelAndView qnaUpload(QnaVO qvo, @RequestParam("member_idx") String member_idx) {
		        ModelAndView mv = new ModelAndView("redirect:my_inquiry_list.do?member_idx="+member_idx);
		        int res = myService.uploadQna(qvo);
		        System.out.println(res);
		        if(res>0) {					
					return mv;
				}
				return new ModelAndView("error");
		
		    }
		 
		//User's inquiry list 
		@GetMapping("my_inquiry_list.do")
		public ModelAndView gotoMyqnaList(HttpSession session, HttpServletRequest req) {
			ModelAndView mv = new ModelAndView("bm/my_inquiry_list");
			MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
			String member_idx = mvo.getMember_idx();
			
			int count = myService.getTotalCount(member_idx);
			paging.setTotalRecord(count);

			if(paging.getTotalRecord() <= paging.getNumPerPage()) {
				paging.setTotalPage(1);
			}else {
				paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage());
				if(paging.getTotalRecord() % paging.getNumPerPage() !=0) {
					paging.setTotalPage(paging.getTotalPage()+1);
				}
			}
			
			String cPage = req.getParameter("cPage");
			if(cPage == null) {
				paging.setNowPage(1);
			}else {
				paging.setNowPage(Integer.parseInt(cPage));
			}
			
			paging.setOffset(paging.getNumPerPage() * (paging.getNowPage()-1));
			
			paging.setBeginBlock((int)((paging.getNowPage()-1)/paging.getPagePerBlock())*
					paging.getPagePerBlock()+1);
			
			paging.setEndBlock(paging.getBeginBlock() + paging.getPagePerBlock()-1);
			
			if(paging.getEndBlock() > paging.getTotalBlock()) {
				paging.setEndBlock(paging.getTotalPage());
			}
		
			MemberVO mvo2 = myService.getMember(member_idx);
			
			String nickname = mvo.getMember_nickname();
			List<QnaVO> list = myService.getMyQna(member_idx,paging.getOffset(), paging.getNumPerPage());
			mv.addObject("nickname", nickname);
			mv.addObject("member_idx", member_idx);
			mv.addObject("list", list);
			mv.addObject("paging", paging);
			return mv;
		}
		
		// read User's inquiry
		// my qna : select one
		@GetMapping("my_inquiry.do")
		public ModelAndView getMyOneQna(@RequestParam("qna_idx") String qna_idx) {
			ModelAndView mv = new ModelAndView("bm/my_inquiry");
			QnaVO qvo = myService.getMyOneQna(qna_idx);
			mv.addObject("qvo", qvo);
			return mv;
		}		 
		 
		//  request the page where user can modify the form 
		 @RequestMapping("QnaUpdateForm.do")
		 public ModelAndView qnaUpdateForm(@RequestParam("qna_idx") String qna_idx) {
			 ModelAndView mv = new ModelAndView("bm/my_inquiry_update");
			 QnaVO qvo = myService.getMyOneQna(qna_idx);
				mv.addObject("qvo", qvo);
				return mv;
		 }
		 
		// update complete
		 @PostMapping("QnaUpdate.do")
		    public ModelAndView qnaUpdate(QnaVO qvo) {
			 String qna_idx = qvo.getQna_idx();
		        ModelAndView mv = new ModelAndView("redirect:my_inquiry.do?qna_idx="+qna_idx);
		        int res = myService.updateQna(qvo);
		        if(res>0) {					
					return mv;
				}
				return new ModelAndView("error");
		
		    }

//		 @GetMapping("my_acc_history.do")
//		 public ModelAndView goToAccompanyHistoryList(@RequestParam("member_idx") String member_idx, HttpServletRequest req) {
//			 ModelAndView mv = new ModelAndView("my_acc_history.do");
//			 
//			 int count = myService.getTotalCount(member_idx);
//				paging.setTotalRecord(count);
//				
//				if(paging.getTotalRecord() <= paging.getNumPerPage()) {
//					paging.setTotalPage(1);
//				}else {
//					paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage());
//					if(paging.getTotalRecord() % paging.getNumPerPage() !=0) {
//						paging.setTotalPage(paging.getTotalPage()+1);
//					}
//				}
//				
//				String cPage = req.getParameter("cPage");
//				if(cPage == null) {
//					paging.setNowPage(1);
//				}else {
//					paging.setNowPage(Integer.parseInt(cPage));
//				}
//				
//				paging.setOffset(paging.getNumPerPage() * (paging.getNowPage()-1));
//				
//				paging.setBeginBlock((int)((paging.getNowPage()-1)/paging.getPagePerBlock())*
//						paging.getPagePerBlock()+1);
//				
//				paging.setEndBlock(paging.getBeginBlock() + paging.getPagePerBlock()-1);
//				
//				if(paging.getEndBlock() > paging.getTotalBlock()) {
//					paging.setEndBlock(paging.getTotalPage());
//				}
//				
//			 List<TogetherVO> list = myService.getMyAcc_List(member_idx, paging.getOffset(), paging.getNumPerPage());
//			 mv.addObject("list",list);
//			 mv.addObject("paging", paging);
//			 //캠핑이미지첨부도 하기 !!
//			return mv;			 
//					 
//		 }

		}

	
