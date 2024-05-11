package com.ict.campyou.bjs.controller;

import java.time.LocalDate;
import java.time.Period;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.ict.campyou.bjs.dao.PromiseVO;
import com.ict.campyou.bjs.dao.TogetherVO;
import com.ict.campyou.bjs.service.TogetherService;
import com.ict.campyou.common.Paging2;
import com.ict.campyou.hu.dao.MemberVO;

@Controller
public class TogetherController {
	@Autowired
	private TogetherService togetherService;
	
	@Autowired
	private Paging2 paging;
	
	@RequestMapping("together_list.do")
	public ModelAndView getTogetherList(@RequestParam(value = "searchType", required = false) String searchType, @RequestParam(value = "searchKeyword", required = false) String searchKeyword, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();
		if(searchType != null && searchKeyword != null) {
			int count2 = togetherService.getToTotalCount2(searchType, searchKeyword);
			paging.setTotalRecord(count2);
		}else {
			int count = togetherService.getToTotalCount();
			paging.setTotalRecord(count);
		}
		
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
		
		List<TogetherVO> togetherList = new ArrayList<TogetherVO>();
		if (searchType != null && searchKeyword != null) {
			togetherList = togetherService.getTogetherListSearch(paging.getOffset(), paging.getNumPerPage(), searchType, searchKeyword);
		}else {
			togetherList = togetherService.getTogetherList(paging.getOffset(), paging.getNumPerPage());
		}
		
		// member의 dob 꺼내서 나이로 환산 후 연령대 구해서 set
		for (TogetherVO tvo : togetherList) {
		    LocalDate dob = LocalDate.parse(tvo.getMember_dob());
		    LocalDate currentDate = LocalDate.now();
		    int age = Period.between(dob, currentDate).getYears();
//		    int age = dob.until(currentDate).getYears();
		    
		    String ageGroup;
		    switch (age / 10) {
		        case 0: ageGroup = "10대 미만"; break;
		        case 1: ageGroup = "10대"; break;
		        case 2: ageGroup = "20대"; break;
		        case 3: ageGroup = "30대"; break;
		        case 4: ageGroup = "40대"; break;
		        case 5: ageGroup = "50대 이상"; break;
		        case 6: ageGroup = "60대 이상"; break;
		        case 7: ageGroup = "70대 이상"; break;
		        default: ageGroup = "80대 이상"; break;
		    }
		    tvo.setMember_dob(ageGroup);
		}
		
		mv.setViewName("bjs/together_list");
		mv.addObject("togetherList", togetherList);
		mv.addObject("paging", paging);
		mv.addObject("searchType", searchType);
		mv.addObject("searchKeyword", searchKeyword);
		return mv;
	}
	
	
	@RequestMapping("together_Write.do")
	public ModelAndView getTogetherWrite(TogetherVO tvo, HttpSession session) throws Exception{
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
	
	@RequestMapping("together_detail.do")
	public ModelAndView getTogetherDetail(@ModelAttribute("cPage")String cPage, String t_idx, HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView();
		MemberVO memberUser = (MemberVO) session.getAttribute("memberInfo");
		TogetherVO tvo = togetherService.getTogetherDetail(t_idx);
		int pvo = togetherService.getPomiseCount(t_idx);
		
		// member의 dob 꺼내서 나이로 환산 후 연령대 구해서 set
	    LocalDate dob = LocalDate.parse(tvo.getMember_dob());
	    LocalDate currentDate = LocalDate.now();
	    int age = Period.between(dob, currentDate).getYears();
//	    int age = dob.until(currentDate).getYears();

	    String ageGroup;
	    switch (age / 10) {
	        case 0: ageGroup = "10대 미만"; break;
	        case 1: ageGroup = "10대"; break;
	        case 2: ageGroup = "20대"; break;
	        case 3: ageGroup = "30대"; break;
	        case 4: ageGroup = "40대"; break;
	        case 5: ageGroup = "50대 이상"; break;
	        case 6: ageGroup = "60대 이상"; break;
	        case 7: ageGroup = "70대 이상"; break;
	        default: ageGroup = "80대 이상"; break;
	    }
	    tvo.setMember_dob(ageGroup);
		
		if(tvo != null) {
			mv.setViewName("bjs/together_detail");
			mv.addObject("tvo", tvo);
			mv.addObject("memberUser", memberUser);
			mv.addObject("appluNum", pvo);
			return mv;
		}
		return new ModelAndView("error");
	}
	
	@RequestMapping("to_update.do")
	public ModelAndView getTogetherUpdate(@ModelAttribute("cPage")String cPage, @ModelAttribute("t_idx")String t_idx) throws Exception {
		ModelAndView mv = new ModelAndView("bjs/together_update");
		TogetherVO tvo = togetherService.getTogetherDetail(t_idx);
		if(tvo != null) {
			mv.addObject("tvo", tvo);
			return mv;
		}
		return new ModelAndView("error");
	}
	
	@RequestMapping("to_delete_ok.do")
	public ModelAndView getTogetherDeleteOK(@ModelAttribute("cPage")String cPage, @ModelAttribute("t_idx")String t_idx, TogetherVO tvo) throws Exception {
		ModelAndView mv = new ModelAndView("bjs/together_update");
		
		int result = togetherService.getTogetherDeleteOK(t_idx);
		if (result > 0) {
			mv.setViewName("redirect:together_list.do?cPage=" + cPage);
			return mv;
		}
		return new ModelAndView("error");
	}
	
	@RequestMapping("together_history.do")
	public ModelAndView getTogetherHistory(@RequestParam("member_idx")String member_idx) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("bjs/together_history");
		mv.addObject("member_idx", member_idx);
		return mv;
	}
	
	
}
