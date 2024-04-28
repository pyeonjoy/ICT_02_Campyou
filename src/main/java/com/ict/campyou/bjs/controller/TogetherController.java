package com.ict.campyou.bjs.controller;

import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ict.campyou.bjs.dao.TogetherVO;
import com.ict.campyou.bjs.service.TogetherService;
import com.ict.campyou.common.Paging;
import com.ict.campyou.hu.dao.MemberVO;

@Controller
public class TogetherController {
	@Autowired
	private TogetherService togetherService;
	
	@Autowired
	private Paging paging;
	
	@RequestMapping("together_list.do")
	public ModelAndView getTogetherList(HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		
		int count = togetherService.getToTotalCount();
		paging.setTotalRecord(count);
		
		// 전체 페이지의 수
		if(paging.getTotalRecord() <= paging.getNumPerPage()) {
			paging.setTotalPage(1);
		}else {
			paging.setTotalPage(paging.getTotalRecord() / paging.getNumPerPage());
			if(paging.getTotalRecord() % paging.getNumPerPage() != 0) {
				paging.setTotalPage(paging.getTotalPage() +1);
			}
		}
		
		String cPage = request.getParameter("cPage");
		if(cPage == null) {
			paging.setNowPage(1);
		}else {
			paging.setNowPage(Integer.parseInt(cPage));
		}
		
		paging.setOffset(paging.getNumPerPage() * (paging.getNowPage() -1));
		
		paging.setBeginBlock((int)((paging.getNowPage() -1) / paging.getPagePerBlock()) * paging.getPagePerBlock() +1);
		paging.setEndBlock(paging.getBeginBlock() + paging.getPagePerBlock() -1);
		
		if(paging.getEndBlock() > paging.getTotalPage()) {
			paging.setEndBlock(paging.getTotalPage());
		}
		
		List<TogetherVO> togetherList = togetherService.getTogetherList(paging.getOffset(), paging.getNumPerPage());
		
		// member의 dob 꺼내서 나이로 환산 후 set
		for (TogetherVO togetherVO : togetherList) {
		    String dobString = togetherVO.getMember_dob();
		    LocalDate dob = LocalDate.parse(dobString);
		    LocalDate currentDate = LocalDate.now();
		    int age = Period.between(dob, currentDate).getYears();
		    togetherVO.setMember_dob(String.valueOf(age));
		}
        
		mv.setViewName("bjs/together_list");
		mv.addObject("togetherList", togetherList);
		mv.addObject("paging", paging);
		return mv;
	}
	
	@RequestMapping("together_Write.do")
	public ModelAndView getTogetherWrite(TogetherVO tvo, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		MemberVO memberUser = (MemberVO) session.getAttribute("memberInfo"); 
		if(memberUser != null) {
			mv.setViewName("bjs/together_write");
		}else {
			session.setAttribute("requestPage", "together_Write.do");
            mv.setViewName("redirect:login_form.do");
		}
		return mv;
	}
	
//	@RequestMapping("together_Write_ok.do")
//	public ModelAndView getTogetherWrite(TogetherVO tvo, HttpSession session) {
//		ModelAndView mv = new ModelAndView();
//		MemberVO memberUser = (MemberVO) session.getAttribute("memberInfo"); 
//		if(memberUser != null) {
//			tvo.setMember_idx(memberUser.getMember_idx());
//		}
//		return new ModelAndView("bjs/together_write");
//	}
	
	@RequestMapping("together_detail.do")
	public ModelAndView getTogetherDetail() {
		return new ModelAndView("bjs/together_detail");
	}
	
}
