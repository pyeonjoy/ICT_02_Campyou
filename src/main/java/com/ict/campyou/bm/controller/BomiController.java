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
import com.ict.campyou.bm.service.MyService;
import com.ict.campyou.hu.dao.MemberVO;


@Controller
public class BomiController {

	@Autowired
	private MyService myService;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
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
	@PostMapping("pwd_change.do")
	public ModelAndView changeUserPw(@RequestParam("member_idx") String member_idx, PasswordCheckRequest pwdcheck) {
		ModelAndView mv = new ModelAndView("redirect:my_info.do");
		String newPassword = pwdcheck.getPassword();
	
		System.out.println(newPassword);
		System.out.println(member_idx);
		MemberVO mvo = myService.getMember(member_idx);
		mvo.setMember_pwd(passwordEncoder.encode(newPassword));
		int res = myService.changeUserPW(mvo);
		System.out.println(res);
		if(res>0) {
			
			return mv;
		}
		return new ModelAndView("redirect:pwd_change.do");
		
	}
	}

