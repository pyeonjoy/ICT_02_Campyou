package com.ict.campyou.bm.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.campyou.bm.dao.FaqVO;
import com.ict.campyou.bm.service.MyService;
import com.ict.campyou.hu.dao.MemberVO;
import com.ict.campyou.hu.service.MemberService;

@Controller
public class BomiController {

	@Autowired
	private MyService myService;

//	page router
	@GetMapping("inquiry_form.do")
	public ModelAndView gotoFormWriting() {
		ModelAndView mv = new ModelAndView("bm/my_inquiry_form");
		return mv;
	}
	@GetMapping("my_main.do")
	public ModelAndView gotoMypage() {
		ModelAndView mv = new ModelAndView("bm/my_main");
		return mv;
	}
	@GetMapping("my_change_pw.do")
	public ModelAndView gotoMy_changePw() {
		ModelAndView mv = new ModelAndView("bm/my_change_pw");
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
		mv.addObject("mvo", mvo);
		return mv;
	}

// change user information and save	
	@PostMapping("changeInfo.do")
	public ModelAndView changeUserInfo(MemberVO mvo, HttpServletRequest req) {
		try {
			ModelAndView mv = new ModelAndView("redirect:my_info.do");
			String path = req.getSession().getServletContext().getRealPath("/resources/uploadUser_img");
			  System.out.println("업로드 폴더 경로: " + path);
			MultipartFile file = mvo.get;
			
			// 파일이 저장될 폴더 객체 생성
	        File uploadFolder = new File(path);

			int res = myService.changeUserInfo(mvo);
			return mv;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
				
	}
}
