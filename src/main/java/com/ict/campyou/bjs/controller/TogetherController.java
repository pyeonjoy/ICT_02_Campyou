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
	
	@RequestMapping("together.do")
	public ModelAndView getTogetherList(HttpServletRequest request, HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView();
		MemberVO member = (MemberVO) session.getAttribute("memberInfo"); 
		
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
		
		// member의 dob 꺼내서 나이로 환산
		List<Integer> memberAges = new ArrayList<>();
		List<String> memberDobList = togetherList.stream()
                .map(TogetherVO::getMember_dob)
                .collect(Collectors.toList());
        LocalDate currentDate = LocalDate.now();
        memberDobList.forEach(dobString -> {
            LocalDate dob = LocalDate.parse(dobString);
            int age = Period.between(dob, currentDate).getYears();
            memberAges.add(age);
        });
		
		mv.setViewName("bjs/together");
		mv.addObject("togetherList", togetherList);
		mv.addObject("paging", paging);
		mv.addObject("memberAges", memberAges);
		return mv;
	}
	
	@RequestMapping("together_detail.do")
	public ModelAndView getTogetherDetail() {
		return new ModelAndView("bjs/together_detail");
	}
	
	@RequestMapping("together_Write.do")
	public ModelAndView getTogetherWrite() {
		return new ModelAndView("bjs/together_write");
	}
}
