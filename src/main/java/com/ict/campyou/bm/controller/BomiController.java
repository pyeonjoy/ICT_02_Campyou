package com.ict.campyou.bm.controller;

import java.io.File;
import java.util.List;
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

import com.ict.campyou.bm.dao.FaqVO;
import com.ict.campyou.bm.dao.PasswordCheckRequest;
import com.ict.campyou.bm.dao.QnaVO;
import com.ict.campyou.bm.service.MyService;
import com.ict.campyou.common.Paging;
import com.ict.campyou.hu.dao.MemberVO;


@Controller
public class BomiController {

	@Autowired
	private MyService myService;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	Paging paging;
	
//	page router
	@GetMapping("inquiry_form.do")
	public ModelAndView gotoFormWriting(@RequestParam("member_idx") String member_idx, HttpSession session) {
		ModelAndView mv = new ModelAndView("bm/my_inquiry_form");
		mv.addObject("member_idx", member_idx);
		return mv;
	}
	
	@GetMapping("my_inquiry.do")
	public ModelAndView gotoMyqnaList(@RequestParam("member_idx") String member_idx, HttpServletRequest req) {
		ModelAndView mv = new ModelAndView("bm/my_inquiry");
		
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
	
		MemberVO mvo = myService.getMember(member_idx);
		
		String nickname = mvo.getMember_nickname();
		List<QnaVO> list = myService.getMyQna(member_idx);
		mv.addObject("nickname", nickname);
		mv.addObject("member_idx", member_idx);
		mv.addObject("list", list);
		mv.addObject("paging", paging);

		return mv;
	}
	
	@GetMapping("my_main.do")
	public ModelAndView gotoMypage(HttpSession session) {
		ModelAndView mv = new ModelAndView("bm/my_main");
		MemberVO mvo = (MemberVO) session.getAttribute("memberInfo");
		mv.addObject("mvo", mvo);
		return mv;
	}
	@RequestMapping("my_change_pw.do")
	public ModelAndView gotoMy_changePw(@RequestParam("member_idx") String member_idx) {
		ModelAndView mv = new ModelAndView("bm/my_change_pw");
		mv.addObject("member_idx", member_idx);
		return mv;
	}
	
	@GetMapping("chatroom.do")
	public ModelAndView gotoChatRoom() {
		ModelAndView mv = new ModelAndView("bm/chatroom");
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
				String old_userImg = mvo.getMember_old_img();
				
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
				
				if (res > 0) {
					return mv;
				}			
				return mv;
				
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
		 @PostMapping("QnaUpload.do")
		    public ModelAndView qnaUpload(QnaVO qvo, @RequestParam("member_idx") String member_idx) {
		        ModelAndView mv = new ModelAndView("redirect:my_inquiry.do?member_idx="+member_idx);
		        int res = myService.uploadQna(qvo);
		        if(res>0) {
					
					return mv;
				}
				return new ModelAndView("error");
		
		    }

		}

	
